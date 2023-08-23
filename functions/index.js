const functions = require("firebase-functions/v1");
const admin = require("firebase-admin");
admin.initializeApp();

exports.monitorRecordsSize = functions.firestore
    .document("users/{email}/records/{recordId}")
    .onWrite(async (change, context) => {
        const userEmail = context.params.email;
        const recordId = context.params.recordId;

        const userDocRef = admin.firestore().collection("users").doc(userEmail);
        const recordsCollectionRef = userDocRef.collection("records");

        const userDocSnapshot = await userDocRef.get();
        const userFCMToken = userDocSnapshot.get("fCMToken");
        const userName = userDocSnapshot.get("name");

        const recordSnapshot = await recordsCollectionRef.doc(recordId).get();
        const recordCount = (await recordsCollectionRef.get()).size;

        if (recordSnapshot.get("fCMToken") !== userFCMToken) {
            return null;
            // If the fCMToken in the last record doesn't match the user's fCMToken, exit
        }

        const previousRecordCount = change.before.exists ? recordCount - 1 : 0;
        const currentRecordCount = change.after.exists ? recordCount : 0;

        if (currentRecordCount > previousRecordCount) {
            const payload = {
                notification: {
                    title: "Requested Service Approved",
                    body: `Hello ${userName}. Your requested service has been approved. Please review the details and enjoy your experience with us.`,
                },
            };

            await admin.messaging().sendToDevice(userFCMToken, payload);
        }

        return null;
    });
