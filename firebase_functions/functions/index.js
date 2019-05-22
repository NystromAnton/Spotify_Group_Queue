const functions = require('firebase-functions');
const request = require('request');
const crypto = require('crypto');
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

exports.addUser = functions.https.onCall((data, context) => {

  const url = 'https://api.spotify.com/v1/me';
  const options = {
       url: 'https://api.spotify.com/v1/me',
       headers: {
           'User-Agent': 'request',
           'Authorization': 'Bearer ' + data.token,
           'Content-Type': 'application/json'
       }
   };

    function downloadPage(options) {
        console.log("options", options);
        return new Promise((resolve, reject) => {
            console.log("return new promise");
            request(options, (error, response, body) => {
                console.log("error, body here ---");
                console.log(error, body);
                if (error) reject(error);
                if (response.statusCode !== 200) {
                    reject(new Error('Invalid status code <' + response.statusCode + '>'));
                }
                resolve(body);
            });
        });
    }

    async function doit() {
    try {
        const body = await downloadPage(options);
        console.log(body);
        console.log("checkp 1")
        const json = JSON.parse(body);
        const spotifyUser = json.id;
        console.log("checkp 2")
        console.log(spotifyUser);
        const hash = crypto.createHash("sha512").update(spotifyUser + "saltlakrits").digest('hex');
        console.log("checkp 3")
        const user = admin.firestore().collection('users').doc(hash);
        console.log("--- user.set ---")
        user.set({
          karma: 0,
          voted: [5, true, 'hello'],//array med låtar/dokument som man har röstat på.
          added: [5, true, 'hello']//array med låtar/dokument som man har lagt till.
        }, {merge: true});
        console.log(hash)
        return hash;
      } catch (error){
        console.error(error);
        return {}
      }
    }
    console.log("return doit")
    return doit();
});

exports.addRoom = functions.https.onCall((data, context) => {
    const room = admin.firestore().collection('rooms').doc(data.roomname);
    room.set({
        explicit: true,
        voting: true,
        genre: "none",
        maxQueueSize: 1000,
        songsPerPerson:100
    }, { merge: true });
});

// exports.roomExists = functions.https.onCall((data, context) => {
//     admin.firestore().collection('rooms').doc(data.roomname).get()
//         .then((docSnapshot) => {
//             if (docSnapshot.exists) {
// 		// do the things and send TRUE to app
//             } else {
//                 // do nothing and send FALSE to app
//             }
//         }
//     }
// }

exports.addSong = functions.https.onCall((data, context) => {
    const songs = admin.firestore().collection('rooms/' + data.roomname + '/songs');
    songs.add({
        submitter: data["submitter"],
        id: data["id"],
        image: data["image"],
        title: data["title"],
        artists: data["artists"],
        votes: data["votes"]
    });
});

exports.editRoom = functions.https.onCall((data, context) => {
    const room = admin.firestore().collection('rooms').doc(data.roomname);
    room.set({
        explicit: data["explicit"],
        voting: data["voting"],
        genre: data["genre"],
        maxQueueSize: data["maxQueueSize"],
        songsPerPerson: data["songsPerPerson"]
    }, { merge: true });
});


exports.addVote = functions.https.onCall((data, context) => {
    const song = admin.firestore().collection('rooms/' + data.roomname + '/songs').doc(data.song);
    //const user = admin.firestore().collection('users').doc(data.hash);
    const submitter = admin.firestore().collection('users').doc(data.submitter);
    const vote = admin.firestore.FieldValue.increment(5);

    song.update({ votes: vote})
    //submitter.update({ karma: vote})
});
