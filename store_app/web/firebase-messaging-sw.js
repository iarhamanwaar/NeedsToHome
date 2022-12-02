importScripts('https://www.gstatic.com/firebasejs/8.2.0/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.2.0/firebase-messaging.js');

// Initialize the Firebase app in the service worker by passing the generated config
var firebaseConfig = {
     apiKey: "AIzaSyAt6uE8g4SglT0F4TQBUtyC64IBORa6ZtA",
     authDomain: "multi-super-store.firebaseapp.com",
     projectId: "multi-super-store",
     storageBucket: "multi-super-store.appspot.com",
     messagingSenderId: "292705944206",
     appId: "1:292705944206:web:8796d6a366787f30b2ffdf",
     measurementId: "G-NNBCDRTVZP"
};

firebase.initializeApp(firebaseConfig);

// Retrieve firebase messaging
const messaging = firebase.messaging();

messaging.onBackgroundMessage(function(payload) {
  console.log('Received background message ', payload);

  const notificationTitle = payload.notification.title;
  const notificationOptions = {
    body: payload.notification.body,
  };

  self.registration.showNotification(notificationTitle,
    notificationOptions);
});