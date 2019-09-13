import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();

// Start writing Firebase Functions
// https://firebase.google.com/docs/functions/typescript

// hello world test function
export const helloWorld = functions.https.onRequest((request, response) => {

 response.status(200).json({message : 'Hello from Firebase cloud functions'});
});

exports.createOwner = functions.firestore
    .document('owners/{userId}')
    .onCreate((snap, context) => {
      // Get an object representing the document
      // e.g. {'name': 'Marie', 'age': 66}
      const ownerData : any = snap.data();
      // perform desired operations ...
      return grantOwnerRole(ownerData.email).then(() => {
          return {
            result: 'Request fulfilled! ${ ownerData.email } is now an owner.'
          }
      })
    });

    exports.createStudent = functions.firestore
    .document('kidStudents/{userId}')
    .onCreate((snap, context) => {
      // Get an object representing the document
      // e.g. {'name': 'Marie', 'age': 66}
      const kidStudentData : any = snap.data();
      // perform desired operations ...
      return grantKidStudentRole(kidStudentData.email).then(() => {
          return {
            result: 'Request fulfilled! ${ kidStudentData.email } is now a kid student.'
          }
      })
    });

    exports.createStudent = functions.firestore
    .document('adultStudents/{userId}')
    .onCreate((snap, context) => {
      // Get an object representing the document
      // e.g. {'name': 'Marie', 'age': 66}
      const adultStudentData : any = snap.data();
      // perform desired operations ...
      return grantAdultStudentRole(adultStudentData.email).then(() => {
          return {
            result: 'Request fulfilled! ${ adultStudentData.email } is now an adult student.'
          }
      })
    });



async function grantOwnerRole(email: string): Promise<void> {
    // create user constant from the firebase auth admin using the user email
    const user = await admin.auth().getUserByEmail(email);
    // check to see if the user already has this isOwner property set, 
    // if true then return... nothing to do here
    if (user.customClaims && (user.customClaims as any).isOwner == true) {
        return;
    } 
    // otherwise set the custom claims i wish to have in place
    return admin.auth().setCustomUserClaims(user.uid, {
        isOwner: true,
        isKid: false,
        isActive: true,
        isMedicalMembershipPaused: false,
        isMembershipPaused: false,
        isPaid: true
    });
}


async function grantAdultStudentRole(email: string): Promise<void> {
    // create user constant from the firebase auth admin using the user email
    const user = await admin.auth().getUserByEmail(email);
    // check to see if the user already has this AdultStudent properties set, 
    // if true then return... nothing to do here
    if (user.customClaims && (user.customClaims as any).isOwner == false && (user.customClaims as any).isKid == false) {
        return;
    } 
    // otherwise set the custom claims i wish to have in place for AdultStudent
    return admin.auth().setCustomUserClaims(user.uid, {
        isOwner: false,
        isKid: false,
        isActive: true,
        isMedicalMembershipPaused: false,
        isMembershipPaused: false,
        isPaid: true
    });
}

async function grantKidStudentRole(email: string): Promise<void> {
    // create user constant from the firebase auth admin using the user email
    const user = await admin.auth().getUserByEmail(email);
    // check to see if the user already has this AdultStudent properties set, 
    // if true then return... nothing to do here
    if (user.customClaims && (user.customClaims as any).isOwner == false && (user.customClaims as any).isKid == true) {
        return;
    } 
    // otherwise set the custom claims i wish to have in place for AdultStudent
    return admin.auth().setCustomUserClaims(user.uid, {
        isOwner: false,
        isKid: true,
        isActive: true,
        isMedicalMembershipPaused: false,
        isMembershipPaused: false,
        isPaid: true
    });
}

// perhaps want to consider triggers on server side
// for now these async functions will be called from the respective client
// 