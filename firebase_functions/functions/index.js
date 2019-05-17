const functions = require('firebase-functions');

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

exports.addUser = functions.https.onCall((data, context) => {
    //skicka data.token till spotify
    const request = require('request');

    const options = {
        url: 'https://api.spotify.com/v1/me',
        headers: {
            'User-Agent': 'request',
            'Authorization': 'Bearer ' + data.token,
            'Content-Type': 'application/json'
        }
    };

    function callback(error, response, body) {
        if (!error && response.statusCode === 200) {
            const info = JSON.parse(body);
            console.log(info);
        }
    }

    request(options, callback);

    var spotifyUser = request.JSON(id)
    console.log(spotifyUser)
    /*
    //få username, spara till const spotifyUser
    const hash = crypto.createHash("sha512").update(spotifyUser + "saltlakrits").digest('hex');
    const user = admin.firestore().collection('users').doc(hash);
    return user.set({
        karma: 0,
        voted: [],//array med låtar/dokument som man har röstat på.
        added: []//array med låtar/dokument som man har lagt till.
    }, {merge: true});*/
});

exports.addUser = functions.https.onCall((data, context) => {
    //skicka data.token till spotify
    const request = require('request');

    const options = {
        url: 'https://api.spotify.com/v1/me',
        headers: {
            'User-Agent': 'request',
            'Authorization': 'Bearer ' + data.token,
            'Content-Type': 'application/json'
        }
    };

    function callback(error, response, body) {
        if (!error && response.statusCode === 200) {
            const info = JSON.parse(body);
            console.log(info);
        }
    }

    request(options, callback);

    var spotifyUser = request.JSON(id)
    console.log(spotifyUser)
    /*
    //få username, spara till const spotifyUser
    const hash = crypto.createHash("sha512").update(spotifyUser + "saltlakrits").digest('hex');
    const user = admin.firestore().collection('users').doc(hash);
    return user.set({
        karma: 0,
        voted: [],//array med låtar/dokument som man har röstat på.
        added: []//array med låtar/dokument som man har lagt till.
    }, {merge: true});*/
});

const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

exports.addRoom = functions.https.onCall((data, context) => {
    const room = admin.firestore().collection('rooms').doc(data.roomname);
    return room.set({
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
    return songs.add({
        id: data["id"],
        votes: data["votes"]
    });
});

exports.editRoom = functions.https.onCall((data, context) => {
    const room = admin.firestore().collection('rooms').doc(data.roomname);
    return room.set({
        explicit: data["explicit"],
        voting: data["voting"],
        genre: data["genre"],
        maxQueueSize: data["maxQueueSize"],
        songsPerPerson: data["songsPerPerson"]
    }, { merge: true });
});
