importScripts('https://www.gstatic.com/firebasejs/8.2.0/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.2.0/firebase-messaging.js');

// Initialize the Firebase app in the service worker by passing the generated config
const firebaseConfig = {
  apiKey: "AIzaSyA4bZScxo8wxAsVmtpEDN8bbCBKuozMjso",
  authDomain: "needstohome-dev.firebaseapp.com",
  projectId: "needstohome-dev",
  storageBucket: "needstohome-dev.appspot.com",
  messagingSenderId: "1090231107467",
  appId: "1:1090231107467:web:892020320461293dea798e",
  measurementId: "G-LKSVR79Y6K"
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