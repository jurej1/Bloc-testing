import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();

// Start writing Firebase Functions
// https://firebase.google.com/docs/functions/typescript


export const onBostonWeatherUpdate = 
functions.firestore.document('cities-weather/boston-ma-us').onUpdate((changed) => {

    const after = changed.after.data();

    const  payload = {
        data: {
            temp: String(after.temp),
            conditions: after.conditions
        }
    }

   return  admin.messaging().sendToTopic('weather_boston-ma-us', payload)
   .catch(error => {
           console.log(error);
       });
});



export const weather  = functions.https.onRequest((request, response) => {

    admin.firestore().doc('cities-weather/boston').get()
    .then( snapshot => {
    const snapData = snapshot.data();    
      response.send(snapData);   
    })
    .catch(error => {
        console.log(error);
        response.status(500).send(error);
    });
});