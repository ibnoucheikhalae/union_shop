# Authentication System Quick Reference

## 🔐 Authentication Flows

### 1. Sign Up Flow

```
User visits /signup
         ↓
Enters information:
- First Name
- Last Name  
- Email
- Password
- Confirm Password
         ↓
Clicks "Create account" OR
Clicks "Continue with Google" OR
Clicks "Continue with Apple" (iOS)
         ↓
AuthService.signUpWithEmail() OR
AuthService.signInWithGoogle() OR
AuthService.signInWithApple()
         ↓
Firebase Auth creates account
         ↓
Firestore creates user profile
         ↓
Redirect to /account
```

### 2. Login Flow

```
User visits /login
         ↓
Enters credentials OR clicks social login
         ↓
AuthService.signInWithEmail() OR
AuthService.signInWithGoogle() OR
AuthService.signInWithApple()
         ↓
Firebase Auth verifies credentials
         ↓
Redirect to /account
```

### 3. Forgot Password Flow

```
User clicks "Forgot password?"
         ↓
Dialog appears
         ↓
User enters email
         ↓
AuthService.resetPassword()
         ↓
Firebase sends reset email
         ↓
User follows email link
         ↓
Resets password on Firebase page
         ↓
Returns to app and logs in
```

### 4. Account Management Flow

```
User logged in → Header shows filled purple icon
         ↓
Click account icon
         ↓
Navigate to /account
         ↓
View profile information:
- Email
- Display Name
- Phone
- Address
- Provider
         ↓
Click "Edit" button
         ↓
Update fields
         ↓
Click "Save"
         ↓
AuthService.updateUserProfile()
         ↓
Firestore updates user document
         ↓
UI refreshes with new data
```

### 5. Sign Out Flow

```
User clicks logout icon on /account
         ↓
AuthService.signOut()
         ↓
Firebase Auth signs out
         ↓
Google Sign-In signs out
         ↓
Redirect to /login
         ↓
Header shows outline icon
```

### 6. Delete Account Flow

```
User clicks "Delete Account"
         ↓
Confirmation dialog appears
         ↓
User confirms deletion
         ↓
AuthService.deleteAccount()
         ↓
Firestore deletes user document
         ↓
Firebase Auth deletes account
         ↓
Redirect to /login
         ↓
Account permanently deleted
```

## 🎨 UI States

### Header Account Icon

**Not Logged In:**
- Icon: `Icons.person_outline`
- Color: Grey
- Action: Navigate to `/login`

**Logged In:**
- Icon: `Icons.person` (filled)
- Color: Purple (#4d2963)
- Action: Navigate to `/account`

### Form States

**Idle:**
- All fields enabled
- Submit button enabled
- No loading indicator

**Loading:**
- All fields disabled
- Submit button shows CircularProgressIndicator
- User cannot interact

**Error:**
- Fields remain enabled
- Error shown in SnackBar
- User can retry

**Success:**
- Redirect to next page
- Success message (optional)

## 🗂️ Data Structure

### Firestore User Document
```
/users/{userId}
├── email: string
├── displayName: string
├── firstName: string (email signup only)
├── lastName: string (email signup only)
├── phone: string (optional)
├── address: string (optional)
├── photoURL: string (Google/Apple only)
├── provider: string (email|google|apple)
└── createdAt: timestamp
```

## 🛠️ Key Components

### AuthService Methods

| Method | Purpose | Parameters |
|--------|---------|------------|
| `signUpWithEmail()` | Create new account | email, password, firstName, lastName |
| `signInWithEmail()` | Login with credentials | email, password |
| `signInWithGoogle()` | Google OAuth login | none |
| `signInWithApple()` | Apple ID login | none |
| `getUserProfile()` | Fetch user data | uid |
| `updateUserProfile()` | Update user info | displayName, phone, address, etc. |
| `resetPassword()` | Send reset email | email |
| `signOut()` | Log out user | none |
| `deleteAccount()` | Delete account | none |

### Pages

| Route | Purpose | Auth Required |
|-------|---------|---------------|
| `/login` | User login | No |
| `/signup` | New account | No |
| `/account` | User dashboard | Yes |

## 🎯 Validation Rules

### Email
- Required
- Must contain '@'

### Password (Signup)
- Required
- Minimum 6 characters

### Confirm Password
- Required
- Must match password

### First/Last Name
- Required
- No specific format

### Phone (Optional)
- Not required
- No validation

### Address (Optional)
- Not required
- Multi-line text

## 🔄 State Management

### StreamBuilder in Header
```dart
StreamBuilder<User?>(
  stream: _authService.authStateChanges,
  builder: (context, snapshot) {
    final isLoggedIn = snapshot.data != null;
    // Update UI based on auth state
  },
)
```

This ensures the header icon updates immediately when:
- User signs in
- User signs out
- User deletes account
- App reopens with existing session

## 📱 Platform Support

### iOS
- ✅ Email/Password
- ✅ Google Sign-In
- ✅ Apple Sign-In
- ✅ All account features

### Android
- ✅ Email/Password
- ✅ Google Sign-In
- ❌ Apple Sign-In (not available)
- ✅ All account features

### Web
- ✅ Email/Password
- ✅ Google Sign-In
- ✅ Apple Sign-In
- ✅ All account features

## 🚦 Error Codes

| Firebase Code | User Message |
|---------------|--------------|
| `weak-password` | The password is too weak |
| `email-already-in-use` | An account already exists with this email |
| `invalid-email` | Invalid email address |
| `user-not-found` | No account found with this email |
| `wrong-password` | Incorrect password |
| `invalid-credential` | Invalid email or password |
| `too-many-requests` | Too many attempts. Please try again later |
| `requires-recent-login` | Please sign in again to delete your account |

## 🎨 Color Scheme

- **Primary Purple**: `#4d2963`
- **Error Red**: `Colors.red`
- **Success Green**: Default Material green
- **Grey (Inactive)**: `Colors.grey`
- **White**: Background and buttons

## 📋 Testing Checklist

- [ ] Sign up with email/password
- [ ] Sign up validation works
- [ ] Sign in with email/password
- [ ] Sign in with Google
- [ ] Sign in with Apple (iOS)
- [ ] Password visibility toggle
- [ ] Forgot password flow
- [ ] View account dashboard
- [ ] Edit profile information
- [ ] Save profile changes
- [ ] Header shows correct icon state
- [ ] Sign out works
- [ ] Delete account with confirmation
- [ ] Error messages display correctly
- [ ] Loading states show properly
- [ ] Mobile responsive design
- [ ] Navigation works correctly

## 💡 Tips

1. **Testing without Firebase**: App will run but show Firebase init error
2. **SHA-1 for Android**: Required for Google Sign-In on Android
3. **URL Scheme for iOS**: Required for Google Sign-In on iOS
4. **Test Mode Firestore**: Easy for development, but switch to production rules
5. **Re-authentication**: Account deletion may require recent login
