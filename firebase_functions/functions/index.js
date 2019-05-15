const functions = require('firebase-functions');

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

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
    const songs = admin.firestore().collection('rooms/ZzqG0nrtavCSfv2uxB53/songs');
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
