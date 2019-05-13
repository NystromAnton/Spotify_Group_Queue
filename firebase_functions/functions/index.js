const functions = require('firebase-functions');

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

exports.addSong = functions.https.onCall((data, context) => {
    const songs = admin.firestore().collection('rooms/ZzqG0nrtavCSfv2uxB53/songs');
    return songs.add({
        id: data["id"],
        votes: data["votes"]
    });
});
