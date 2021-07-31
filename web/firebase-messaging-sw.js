importScripts('https://www.gstatic.com/firebasejs/8.6.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/8.6.1/firebase-auth.js');
importScripts('https://www.gstatic.com/firebasejs/8.6.1/firebase-messaging.js');
importScripts('https://www.gstatic.com/firebasejs/8.6.1/firebase-firestore.js');
importScripts('https://www.gstatic.com/firebasejs/8.6.1/firebase-storage.js');
importScripts('https://www.gstatic.com/firebasejs/8.6.1/firebase-database.js');

firebase.initializeApp({
	apiKey: "AIzaSyBgtNyeALQx8cuerCs6nFB4fQKzLL8r474",
    authDomain: "leaforg-8c873.firebaseapp.com",
    databaseURL: "https://leaforg-8c873.firebaseio.com",
    projectId: "leaforg-8c873",
    storageBucket: "leaforg-8c873.appspot.com",
    messagingSenderId: "256127547159",
    appId: "1:256127547159:web:db035049167ff40b692952",
    measurementId: "G-8QX3DELFCQ",
});

const messaging = firebase.messaging();