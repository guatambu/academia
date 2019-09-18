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

    exports.createKidStudent = functions.firestore
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

    exports.createAdultStudent = functions.firestore
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
    if (user.customClaims && (user.customClaims as any).isOwner === true) {
        return;
    } 
    // otherwise set the custom claims i wish to have in place
    return admin.auth().setCustomUserClaims(user.uid, {
        isOwner: true,
        isKid: false,
        isActive: true,
        isMedicalMembershipPaused: false,
        isMembershipPaused: false,
        isPaid: true,
        isElligibleForPromotion: false,
        isElligibleForNextBelt: false
    });
}


async function grantAdultStudentRole(email: string): Promise<void> {
    // create user constant from the firebase auth admin using the user email
    const user = await admin.auth().getUserByEmail(email);
    // check to see if the user already has this AdultStudent properties set, 
    // if true then return... nothing to do here
    if (user.customClaims && (user.customClaims as any).isOwner === false && (user.customClaims as any).isKid === false) {
        return;
    } 
    // otherwise set the custom claims i wish to have in place for AdultStudent
    return admin.auth().setCustomUserClaims(user.uid, {
        isOwner: false,
        isKid: false,
        isActive: true,
        isMedicalMembershipPaused: false,
        isMembershipPaused: false,
        isPaid: true,
        isElligibleForPromotion: false,
        isElligibleForNextBelt: false
    });
}

async function grantKidStudentRole(email: string): Promise<void> {
    // create user constant from the firebase auth admin using the user email
    const user = await admin.auth().getUserByEmail(email);
    // check to see if the user already has this AdultStudent properties set, 
    // if true then return... nothing to do here
    if (user.customClaims && (user.customClaims as any).isOwner === false && (user.customClaims as any).isKid === true) {
        return;
    } 
    // otherwise set the custom claims i wish to have in place for AdultStudent
    return admin.auth().setCustomUserClaims(user.uid, {
        isOwner: false,
        isKid: true,
        isActive: true,
        isMedicalMembershipPaused: false,
        isMembershipPaused: false,
        isPaid: true,
        isElligibleForPromotion: false,
        isElligibleForNextBelt: false
    });
}

async function setIsElligibleForPromotion(email: string): Promise<void> {
    // get the authenticated user object
    admin.auth().getUserByEmail(email).then((user) => {
        // Add incremental custom claim without overwriting existing claims.
        const currentCustomClaims: any = user.customClaims;
        // check to make sure the isElligibleForPromotion is not null
        if (currentCustomClaims.isElligibleForPromotion) {
            // set isElligibleForPromotion status
            currentCustomClaims['isElligibleForPromotion'] = true;
            currentCustomClaims['isElligibleForNextBelt'] = false;
            // Add custom claims for additional privileges.
            return admin.auth().setCustomUserClaims(user.uid, currentCustomClaims);
        } else {
            return
        }
    })
        .catch((error) => {
          console.log(error);
    });
}

async function setIsElligibleForNextBelt(email: string): Promise<void> {
    // get the authenticated user object
    admin.auth().getUserByEmail(email).then((user) => {
        // Add incremental custom claim without overwriting existing claims.
        const currentCustomClaims: any = user.customClaims;
        // check to make sure the isElligibleForNextBelt is not null
        if (currentCustomClaims.isElligibleForNextBelt) {
            // set IsElligibleForNextBelt status
            currentCustomClaims['isElligibleForPromotion'] = false;
            currentCustomClaims['isElligibleForNextBelt'] = true;
            // Add custom claims for additional privileges.
            return admin.auth().setCustomUserClaims(user.uid, currentCustomClaims);
        } else {
            return
        }
    })
        .catch((error) => {
          console.log(error);
    });
}


async function resetPromotions(email: string): Promise<void> {
    // get the authenticated user object
    admin.auth().getUserByEmail(email).then((user) => {
        // Add incremental custom claim without overwriting existing claims.
        const currentCustomClaims: any = user.customClaims;
        // check to make sure the isElligibleForPromotion is not null
        if (currentCustomClaims.isElligibleForPromotion) {
            // set isElligibleForPromotion status
            currentCustomClaims['isElligibleForPromotion'] = false;
            currentCustomClaims['isElligibleForNextBelt'] = false;
            // Add custom claims for additional privileges.
            return admin.auth().setCustomUserClaims(user.uid, currentCustomClaims);
        } else {
            return
        }
    })
        .catch((error) => {
          console.log(error);
    });
}


async function setIsActive(email: string): Promise<void> {
    // get the authenticated user object
    admin.auth().getUserByEmail(email).then((user) => {
        // Add incremental custom claim without overwriting existing claims.
        const currentCustomClaims : any = user.customClaims;
        // check to make sure the isActive is not null
        if (currentCustomClaims.isActive) {
            // set isActive status
            currentCustomClaims['isActive'] = !currentCustomClaims['isActive'];
            // Add custom claims for additional privileges.
            return admin.auth().setCustomUserClaims(user.uid, currentCustomClaims);
        } else {
            return
        }
    })
        .catch((error) => {
          console.log(error);
    });
}

async function setIsMedicalMembershipPaused(email: string): Promise<void> {
    // get the authenticated user object
    admin.auth().getUserByEmail(email).then((user) => {
        // Add incremental custom claim without overwriting existing claims.
        const currentCustomClaims: any = user.customClaims;
        // check to make sure the isMedicalMembershipPaused is not null
        if (currentCustomClaims.isMedicalMembershipPaused) {
            // set isMedicalMembershipPaused status
            currentCustomClaims['isMedicalMembershipPaused'] = !currentCustomClaims['isMedicalMembershipPaused'];
            // Add custom claims for additional privileges.
            return admin.auth().setCustomUserClaims(user.uid, currentCustomClaims);
        } else {
            return
        }
    })
        .catch((error) => {
          console.log(error);
    });
}

async function setIsPaid(email: string): Promise<void> {
    // get the authenticated user object
    admin.auth().getUserByEmail(email).then((user) => {
        // Add incremental custom claim without overwriting existing claims.
        const currentCustomClaims: any = user.customClaims;
        // check to make sure the isPaid is not null
        if (currentCustomClaims.isPaid) {
            // set isPaid status
            currentCustomClaims['isPaid'] = !currentCustomClaims['isPaid'];
            // Add custom claims for additional privileges.
            return admin.auth().setCustomUserClaims(user.uid, currentCustomClaims);
        } else {
            return
        }
    })
        .catch((error) => {
          console.log(error);
    });
}

async function setIsMembershipPaused(email: string): Promise<void> {
    // get the authenticated user object
    admin.auth().getUserByEmail(email).then((user) => {
        // Add incremental custom claim without overwriting existing claims.
        const currentCustomClaims: any = user.customClaims;
        // check to make sure the isMembershipPaused is not null
        if (currentCustomClaims.isMembershipPaused) {
            // set isMembershipPaused status
            currentCustomClaims['isMembershipPaused'] = !currentCustomClaims['isMembershipPaused'];
            // Add custom claims for additional privileges.
            return admin.auth().setCustomUserClaims(user.uid, currentCustomClaims);
        } else {
            return
        }
    })
        .catch((error) => {
          console.log(error);
    });
}

// perhaps want to consider triggers on server side
// for now these async functions will be called from the respective client
// 