# Firebase Authentication Setup Instructions

## Overview
The authentication system is now implemented with support for:
- ✅ Email/Password authentication
- ✅ Google Sign-In
- ✅ Apple Sign-In (iOS only)
- ✅ Account dashboard with profile management
- ✅ Password reset functionality
- ✅ Account deletion

## Required: Firebase Project Setup

### Step 1: Create Firebase Project
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add project"
3. Name it (e.g., "Union Shop")
4. Follow the setup wizard

### Step 2: Enable Authentication Methods
1. In Firebase Console, go to **Authentication** → **Sign-in method**
2. Enable:
   - ✅ Email/Password
   - ✅ Google
   - ✅ Apple (for iOS)

### Step 3: Add Firebase to Your Flutter App

#### For Android:
1. In Firebase Console, click **Add app** → Android
2. Register app with package name: `com.example.union_shop` (or your actual package name)
3. Download `google-services.json`
4. Place it in: `android/app/google-services.json`
5. Add to `android/build.gradle.kts`:
   ```kotlin
   dependencies {
       classpath("com.google.gms:google-services:4.4.0")
   }
   ```
6. Add to `android/app/build.gradle.kts`:
   ```kotlin
   plugins {
       id("com.google.gms.google-services")
   }
   ```

#### For iOS:
1. In Firebase Console, click **Add app** → iOS
2. Register app with bundle ID: `com.example.unionShop` (or your actual bundle ID)
3. Download `GoogleService-Info.plist`
4. Place it in: `ios/Runner/GoogleService-Info.plist`
5. Open Xcode and add the file to the Runner target

#### For Web:
1. In Firebase Console, click **Add app** → Web
2. Register your web app
3. Copy the Firebase configuration
4. Update `lib/main.dart` with your Firebase config:
   ```dart
   await Firebase.initializeApp(
     options: const FirebaseOptions(
       apiKey: 'YOUR-API-KEY',
       appId: 'YOUR-APP-ID',
       messagingSenderId: 'YOUR-MESSAGING-SENDER-ID',
       projectId: 'YOUR-PROJECT-ID',
       storageBucket: 'YOUR-STORAGE-BUCKET',
     ),
   );
   ```

### Step 4: Configure Google Sign-In

#### Android:
1. Get SHA-1 fingerprint:
   ```bash
   keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
   ```
2. Add SHA-1 to Firebase Console → Project Settings → Your Android app

#### iOS:
1. Add URL scheme to `ios/Runner/Info.plist`:
   ```xml
   <key>CFBundleURLTypes</key>
   <array>
     <dict>
       <key>CFBundleURLSchemes</key>
       <array>
         <string>com.googleusercontent.apps.YOUR-CLIENT-ID</string>
       </array>
     </dict>
   </array>
   ```
2. Get the reversed client ID from `GoogleService-Info.plist`

### Step 5: Create Firestore Database
1. In Firebase Console, go to **Firestore Database**
2. Click **Create database**
3. Start in test mode (or production mode with rules)
4. Choose a location

### Step 6: Set Firestore Security Rules
```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read: if request.auth != null && request.auth.uid == userId;
      allow write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

## Testing the App

### Without Firebase (Testing UI Only):
The app will run but authentication won't work. You'll see a Firebase initialization error in the console.

### With Firebase:
1. Complete all setup steps above
2. Run the app:
   ```bash
   flutter run
   ```
3. Test features:
   - Create account with email/password
   - Sign in with Google
   - Sign in with Apple (iOS only)
   - Update profile information
   - Reset password
   - Delete account

## Features Implemented

### Authentication Pages
- **Login Page** (`/login`): Email/password + social login
- **Signup Page** (`/signup`): Account creation with validation
- **Account Page** (`/account`): User dashboard and profile management

### Authentication Service
- **AuthService** (`lib/services/auth_service.dart`):
  - Email/password signup and signin
  - Google Sign-In
  - Apple Sign-In
  - Password reset
  - Profile management (Firestore)
  - Account deletion
  - Error handling

### UI Updates
- **App Header**: Shows authentication state
  - Grey outline icon when logged out
  - Purple filled icon when logged in
  - Clicking account icon navigates to `/account` or `/login` based on state

### Account Dashboard Features
- View profile information
- Edit display name, phone, address
- View order history (placeholder)
- Sign out
- Delete account (with confirmation)

## Architecture

```
lib/
├── services/
│   ├── auth_service.dart        # Authentication logic
│   └── cart_service.dart        # Cart functionality
├── pages/
│   ├── login_page.dart          # Login UI with social auth
│   ├── signup_page.dart         # Signup UI with social auth
│   └── account_page.dart        # Account dashboard
├── widgets/
│   └── app_header.dart          # Header with auth state
└── main.dart                    # Firebase initialization
```

## Next Steps

1. ✅ Complete Firebase setup following instructions above
2. ✅ Test authentication flows
3. ⏭️ Consider adding:
   - Email verification
   - Phone authentication
   - Two-factor authentication
   - OAuth providers (Facebook, Twitter, etc.)
   - Order history integration
   - Wishlist functionality

## Troubleshooting

### "Firebase initialization failed"
- Ensure Firebase config is correct in `main.dart`
- Check that `google-services.json` (Android) or `GoogleService-Info.plist` (iOS) is in the correct location

### Google Sign-In not working
- Verify SHA-1 is added to Firebase Console (Android)
- Check URL scheme is configured (iOS)
- Ensure Google Sign-In is enabled in Firebase Console

### Apple Sign-In not working
- Only works on iOS 13+
- Ensure Apple Sign-In is enabled in Firebase Console
- Configure Apple Sign-In in your Apple Developer account

### Firestore permission errors
- Check Firestore security rules
- Ensure user is authenticated before accessing `/users/{userId}`

## Support

For Firebase-specific issues, refer to:
- [Firebase Documentation](https://firebase.google.com/docs)
- [FlutterFire Documentation](https://firebase.flutter.dev/)
