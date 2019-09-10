import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();

// Start writing Firebase Functions
// https://firebase.google.com/docs/functions/typescript

// hello world test function
export const helloWorld = functions.https.onRequest((request, response) => {

 response.status(200).json({message : 'Hello from Firebase cloud functions'});
});

exports.addAOwner = functions.https.onCall((data, context) => {

    if (context.auth.token.isOwner !== true) {
        error: "Request not authorized.  User must have Owner permissions.";
        
    };

    const email = data.email;
    return grantOwnerRole(email).then(() => {
        return {
            result: 'Request fulfilled! ${email} now has Owner permissions.'
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
    });
}

async function grantIsAdultStudentRole(email: string): Promise<void> {
    // create user constant from the firebase auth admin using the user email
    const user = await admin.auth().getUserByEmail(email);
    // check to see if the user already has this AdultStudent properties set, 
    // if true then return... nothing to do here
    if (user.customClaims && (user.customClaims as any).isOwner == false) {
        return;
    } 
    // otherwise set the custom claims i wish to have in place for AdultStudent
    return admin.auth().setCustomUserClaims(user.uid, {
        isOwner: false,
        isKid: false,
    });
}

async function grantIsKidStudentRole(email: string): Promise<void> {
    // create user constant from the firebase auth admin using the user email
    const user = await admin.auth().getUserByEmail(email);
    // check to see if the user already has this KidStudent properties set, 
    // if true then return... nothing to do here
    if (user.customClaims && (user.customClaims as any).isOwner == false) {
        return;
    } 
    // otherwise set the custom claims i wish to have in place for KidStudent
    return admin.auth().setCustomUserClaims(user.uid, {
        isOwner: false,
        isKid: true,
    });
}

