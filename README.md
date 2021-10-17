# Email, Google and Facebook Signup for Flutter Login

1. Create a helper directory in lib folder of the Project and create a dart file named auth.dart.
2. Create a new Firebase Project and Link it to your Flutter Project.
3. Install the given dependencies : 
  - [`firebase_core`](https://pub.dev/packages/firebase_core)
  - [`firebase_auth`](https://pub.dev/packages/firebase_auth)
4. Create a class AuthMethods in auth.dart


## Email SignIn
***Turn on Email and Password Authentication in the Authentication section of your Firebase Project.***
1. import Firebase Auth in auth.dart.
`import 'package:firebase_auth/firebase_auth.dart';`
2. Create a Firebase Instance in class AuthMethods.
`FirebaseAuth auth = FirebaseAuth.instance;`
3. Create the following function for *Email Password Sign In Authentication*.
```
  Future EmailPassSignIn(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      return user;
    } on FirebaseAuthException catch (error) {
      return error.message;
    } catch (error) {
      return error;
    }
  }
 ```
 This Function returns the [`User`](https://pub.dev/documentation/firebase/latest/firebase/User-class.html) type.
 
 4. To use the above given Function, create an instance of AuthMethods and SignIn() function in your Login/SignIn page.
 ```
 //Email Password Sign in Function
 AuthMethods authmethods = new AuthMethods();
  SignIn() async {
    print("Email : $email.text");
    await authMethods.EmailPassSignIn(email.text, password.text).then((result) {
      if (result != null) {
        print("Done Log In");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Demo()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            result,
            style: TextStyle(fontSize: 16),
          ),
        ));
      }
    });
  }
  ```
  Here email.text and password.text are [Text Editing Controllers](https://api.flutter.dev/flutter/widgets/TextEditingController-class.html) `email` and `password` respectively.
  ```
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  ```
  5. Create a Login button with onPressed Property to call the SignIn() Function.

## Email SignUp
***Turn on Email and Password Authentication in the Authentication section of your Firebase Project.***
1. import Firebase Auth in auth.dart.
`import 'package:firebase_auth/firebase_auth.dart';`
2. Create a Firebase Instance in class AuthMethods.
`FirebaseAuth auth = FirebaseAuth.instance;`
3. Create the following function for *Email Password Sign Up Authentication*.
```
 Future EmailPassSignUp(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      return user;
    } on FirebaseAuthException catch (error) {
      return error.message;
    } catch (error) {
      return error;
    }
  }
 ```
 This Function returns the [`User`](https://pub.dev/documentation/firebase/latest/firebase/User-class.html) type.
 
 4. To use the above given Function, create an instance of AuthMethods and SignUp() function in your SignUp page.
 ```
//Email Password Sign Up Function
 AuthMethods authmethods = new AuthMethods();
  SignUp() async {
    print("Email : $email.text");
    await authMethods.EmailPassSignUp(email.text, password.text).then((result) {
      if (result != null) {
        print("Done Sign Up");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Demo()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            result,
            style: TextStyle(fontSize: 16),
          ),
        ));
      }
    });
  }
  ```
  Here email.text and password.text are [Text Editing Controllers](https://api.flutter.dev/flutter/widgets/TextEditingController-class.html) `email` and `password` respectively. 
  ```
  TextEditingController email = new TextEditingController();
  TextEditingController password = new TextEditingController();
  ```
  5. Create a Create Account / Sign Up button with onPressed Property to call the SignUp() Function.


## Google Sign In /Sign Up
***Turn on Google Authentication in your Firebase Project in the Authentication Section and add Your Support Email.***
- **Setup SHA-1 and SHA-256 key.**
1. Open cmd.
2. Go to `[YOUR PROJECT FOLDER PATH]\android`.
3. Type in the following command in :
`gradlew signingReport` or `./gradlew signingReport`
4. Copy SHA-1 key
5. Go to Firebase Project Settings -> Your Apps Section. Click on ***Add fingerprint*** and paste your SHA-1 key and hit save.
6. Copy SHA-256 key from cmd.
7. Go to Firebase Project Settings -> Your Apps Section. Click on ***Add fingerprint*** and paste your SHA-256 key and hit save.
- **Setup Authentication**
1. Add [`google_sign_in`](https://pub.dev/packages/google_sign_in) dependency in your pubspec.ymal file.
2. In your auth.dart, import google_sign_in : `import 'package:google_sign_in/google_sign_in.dart';`
3. Add the following Funtion to your AuthMethods class : 
```
Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the User
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      User user = userCredential.user;
      return user;
    } on FirebaseAuthException catch (error) {
      return error;
    } catch (error) {
      return error;
    }
  }
  ```
 This Function returns the [`User`](https://pub.dev/documentation/firebase/latest/firebase/User-class.html) type.
  
 4. To use the above given function, create an instance of AuthMethods and googleAuth() Function in your Login/Signup page.
  ```
  // Google Sign In function
  AuthMethods authmethods = new AuthMethods();
  googleAuth() async {
    await authMethods.signInWithGoogle().then((value) {
      if (value != null) {
        print("Done Google Sign In");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Demo()));
      } else {
      print("Null value received from Google");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ));
      }
    });
  }
  ```
5. Create a *Sign In with Google / Sign Up with Google* button with onPressed Property to call the googleAuth() Function.
## Facebook Sign In /Sign Up
- **Setup Facebook for Flutter Project.**
1. Go to [Facebook Developers](https://developers.facebook.com/).
2. Go to My Apps -> Create Project.
3. Choose your app type and Display Name.
4. Click Facebook Login Setup and choose Android option.
5. Click Next as we don't need to download Facebook SDK for our Flutter Project.
6. Go to your android level `build.gradle` file and check / add `jcenter()` and `mavenCentral()` to `repositories{}`. Your android level `build.gradle` file should look like : [`android\build.gradle`](android/build.gradle)
7. Go to your app level `build.gradle` file and add `implementation 'com.facebook.android:facebook-android-sdk:latest.release'` to `dependencies{}`. Your app level `build.gradle` file should look like : [`app\build.gradle`](android/app/build.gradle). Click Next.
8. Go to `android\app\src\main\AndroidManifest.xml` and then copy the package value and paste to *Package Name* in Facebook Developers Page. Paste ***[PACKAGE NAME].MainActivity*** to *Default Activity Class Name*. Hit Save and Continue.
9. **Key Hashes :** You should have java jdk installed. Go to `[JAVA JDK PATH]\bin` in cmd and paste the following command `keytool -exportcert -alias androiddebugkey -keystore "C:\Users\[USERNAME]\.android\debug.keystore" | openssl.exe sha1 -binary | openssl.exe base64`, Edit your [USERNAME]. If it asks for password, type *android*. Copy the key and paste it into the *Key Hashes*. Hit save and continue.
10. Now to Edit your Resources and Manifest:
    - Create a `strings.xml` file in `android/app/src/main/res/values/` and add the following code:
    ```
    <?xml version="1.0" encoding="utf-8"?> <!--To prevent xml syntax errors.xml versions can vary, Check styles.xml in the same folder.-->
    <resources>
      <string name="app_name">[YOUR APP NAME]</string>
    </resources>
    ```
    - Now, Copy the code for strings.xml from Facebook Developers page and paste it into `resources` tag of `strings.xml`.
    - Add `<uses-permission android:name="android.permission.INTERNET"/>` to your `android\app\src\main\AndroidManifest.xml` file.
    - Copy the **Meta data code** from Facebook Developers page and paste it into `application` tag of `android\app\src\main\AndroidManifest.xml` file. Your `AndroidManifest.xml` file should look like : [`AndroidManifest.xml`](android/app/src/main/AndroidManifest.xml).


- **Setup Firebase for Flutter Project.**
1. Go to your Firebase project -> Authentication.
2. In the Sign in method, Add facebook.
3. Copy ***App ID*** and ***App Secret*** from your Facebook Project Basic Settings and paste them into Firebase Facebook dialog box.

- **Setup Facebook Authentication**
1. Add [`flutter_facebook_auth`](https://pub.dev/packages/flutter_facebook_auth) dependency in your pubspec.ymal file.
2. In your auth.dart, import flutter_facebook_auth : `import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';`
3. Add the following Funtion to your AuthMethods class :
```
Future signInWithFacebook() async {
    try{
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential = FacebookAuthProvider.credential(loginResult.accessToken.token);

    // Once signed in, return the User
    UserCredential userCredential=  await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
    User user = userCredential.user;
    return user;
      }
    on Exception catch(error){
      print("Error FaceBook : $error");
    }catch(error){
      print(error);
    }
  }
  ```
 This Function returns the [`User`](https://pub.dev/documentation/firebase/latest/firebase/User-class.html) type.
 
 4. To use the above given function, create an instance of AuthMethods and facebookAuth() Function in your Login/Signup page.
 ```
  AuthMethods authMethods = new AuthMethods();
  //Facebook Sign In function
  facebookAuth() async {
    await authMethods.signInWithFacebook().then((value) {
      if (value != null) {
        print("Done Facebook Sign In");
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Demo()));
      } else {
        print("Null Value Received for Facebook User");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ));
      }
    });
  }
  ```
 5. Create a Sign In with Facebook / Sign Up with Facebook button with onPressed Property to call the facebookAuth() Function.


- [ ] **6. Email Password SignOut**
- [ ] **7. Google Sign Out**
- [ ] **8. Facebook Sign Out**
- [ ] **9. Twitter Sign In**
- [ ] **10. Twitter Sign Out**
- [ ] **11. Phone Authentication**
