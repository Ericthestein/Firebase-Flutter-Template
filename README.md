# Firebase-Flutter-Template

This repository houses a template for creating a [Flutter](https://flutter.dev/) application that leverages the power of [Firebase](https://firebase.google.com/).

The [Flutter directory](Flutter) includes [Dart](https://dart.dev/) code for using the following Firebase services:
1. Authentication
2. Cloud Firestore
3. Cloud Functions

The [FirebaseCloudFunctions directory](FirebaseCloudFunctions) includes JavaScript code for implementing:
1. an HTTP Firebase Cloud Function.

### Demo

A demo of the Flutter app that this repository powers can be found [here](https://fir-flutter-demo-95874.web.app/#/).

### Cloning this project

To use this project:
1. In a shell, run the command `git clone https://github.com/Ericthestein/Firebase-Flutter-Template.git`.
2. Follow the relevant steps below to set up the Flutter portion and/or the Firebase Cloud Functions portion.

### Setting up Firebase

To set up Firebase for this project:
1. Head over to the [Firebase website](https://firebase.google.com/), log in / sign up, and create a new project.

## Flutter Walkthrough

### Background

For help getting started with Flutter, check out [this tutorial](https://flutter.dev/docs/get-started/install).

### Setting up

Four main actions should be completed to get the Flutter portion of this project up and running:
1. Run `firebase init` and select the Hosting option (make sure that you run `cd Flutter` to get into the Flutter directory if you are starting in the root directory).
  When asked about making your web app a single-page app, select Yes
  If asked to overwrite index.html, select No
2. Download all necessary libraries by running `flutter pub get`.
3. Modify [index.html](Flutter/web/index.html) to include your project's configuration.
  - The code can be generated by going to your Firebase Project -> Settings -> General -> Your Apps -> Web Apps -> CDN
  - For more help, check out [this link](https://firebase.flutter.dev/docs/installation/web/#initializing-firebase)
4. Create a Cloud Firestore datastore by going to your Firebase Project -> Cloud Firestore -> Create Database

### Authentication

The Authentication service from Firebase is mostly used in [AuthenticationPage.dart](Flutter/lib/pages/bottomNavigationPages/AuthenticationPage.dart). There, users can register for an account in our app or sign into an existing account using an email and password. Upon authentication, the user is allowed access to the other pages.

### Cloud Firestore

The Cloud Firestore service from Firebase is used in [CloudFirestorePage.dart](Flutter/lib/pages/bottomNavigationPages/CloudFirestorePage.dart). There, users can participate in an election to finally settle the following age-old question: cats or dogs (using photos of the pets of yours truly as reference)? When the vote buttons are pressed, the corresponding values in the provisioned Cloud Firestore service are modified, and every time a data update occurs, the client app listens and updates its display to reflect the new vote values.

### Cloud Functions

The Cloud Functions service from Firebase is used in [CloudFunctionsPage.dart](Flutter/lib/pages/bottomNavigationPages/CloudFunctionsPage.dart). There, users can use an HTTP function to send a preconfigured email to a given email address (see below). It includes an anti-spam measure to force users to wait at least a minute before sending another email in their current session.

## Firebase Cloud Functions Walkthrough

### Background

For help getting started with [node.js](https://nodejs.org/en/), check out [this tutorial](https://nodejs.org/en/docs/guides/getting-started-guide/).

### Setting up

To set up the included Cloud Functions:
1. Run `firebase init` and select the Cloud Functions option (make sure that you run `cd FirebaseCloudFunctions` to get into the FirebaseCloudFunctions directory if you are starting in the root directory).
2. Modify [index.js](FirebaseCloudFunctions/functions/index.js) to include the credentials for your email bot account (see below). Make sure your account can be logged into through unsecure services.
3. Enable the Blaze plan in your Firebase account and add a billing account (though this is required for Cloud Functions to be used, Firebase offers a [free tier](https://cloud.google.com/functions/pricing#:~:text=Cloud%20Functions%20provides%20a%20perpetual,Internet%20egress%20traffic%20per%20month.) that will be used up before you are charged.

### HTTP Firebase Cloud Function

EmailSender, the included HTTP Firebase Cloud Function, can be used to send a preconfigured email to a given email address via a REST API call (or by using the Firebase Cloud Functions library for Flutter, as we are doing). It works by using [Nodemailer](https://github.com/nodemailer/nodemailer), a library for sending automatic emails.

## License

This project is licensed under the MIT License - see [LICENSE.md](LICSENSE.md) for more details.