# Appcircle _Firebase Deployment_ component

Deploy your web applications to Firebase Hosting

## Required Inputs

- `AC_FIREBASE_VERSION`: Firebase Version. Firebase version to be used. Enter v11.11.0 for a specific version.
- `AC_FIREBASE_PROJECT_PATH`: Project Directory. The directory containing your `firebase.json` file.

## Optional Inputs

- `AC_FIREBASE_TOKEN`: Firebase Token. A refresh token that's printed when you authenticate with `firebase login:ci` command. **Either select Firebase token or Google Service account**.
- `GOOGLE_APPLICATION_CREDENTIALS`: Google Service Account. Path of Google Service Account JSON. Upload service account as a file to your environment group and name it `GOOGLE_APPLICATION_CREDENTIALS`. **Either select Firebase token or Google Service account**.
- `AC_FIREBASE_EXTRA_PARAMETERS`: Extra parameters. Extra command line parameters. Enter --debug for debug mode.
