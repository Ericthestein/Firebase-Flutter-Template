const functions = require('firebase-functions');
const nodemailer = require('nodemailer');

exports.EmailSender = functions.https.onCall(async (data, context) => {
    const email = data;

    if (!email) {
        return "Error: No email provided";
    }

    // Create transporter
    const emailTransporter = nodemailer.createTransport({
        service: 'gmail',
        auth: { // replace with your credentials
            user: '', // email
            pass: '' // password
        }
    });

    // Create email payload
    const emailOptions = {
        from: "FirebaseFlutterDemo Bot <firebaseflutterdemobot@gmail.com>",
        to: email,
        subject: "Hello from Firebase Cloud Functions!",
        html: "<p>This email was sent through Firebase Cloud Functions.</p>"
    }

    // Send email

    try {
        await emailTransporter.sendMail(emailOptions, (err, info) => {
            if (err) {
                functions.logger.log("Error sending email: ", err);
                return "Error";
            }
        })
    } catch (err) {
        functions.logger.log("Error sending email: ", err);
        return "Error";
    }

    functions.logger.log("Sent an email to " + email);

    return "Success!";
});
