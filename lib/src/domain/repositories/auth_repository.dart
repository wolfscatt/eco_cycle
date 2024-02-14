import 'package:eco_cycle/src/domain/repositories/exceptions/login_exception.dart';
import 'package:eco_cycle/src/domain/repositories/exceptions/register_email_password_failure.dart';
import 'package:eco_cycle/src/domain/repositories/user_repository/user_repository.dart';
import 'package:eco_cycle/src/presentation/pages/home_page.dart';
import 'package:eco_cycle/src/presentation/screens/login_screen.dart';
import 'package:eco_cycle/src/presentation/screens/mail_verification.dart';
import 'package:eco_cycle/src/presentation/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get to => Get.find();

  final auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = "".obs;

  final userRepo = Get.put(UserRepository());

  @override
  void onReady() {
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    FlutterNativeSplash.remove();
    setInitialScreen(firebaseUser.value);
    //ever(firebaseUser, setInitialScreen);
  }

  setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => WelcomeScreen())
        : user.emailVerified
            ? Get.offAll(() => HomePage())
            : Get.offAll(() => MailVerification());
  }

  // -------------------- Phone Auth --------------------
  Future<void> phoneAuth(String phoneNo) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNo,
      verificationCompleted: (credentials) {
        auth.signInWithCredential(credentials);
      },
      verificationFailed: (error) {
        if (error.code == "invalid-phone-number") {
          Get.snackbar(
              "Invalid Phone Number", "Please enter a valid phone number");
        } else {
          Get.snackbar("Phone Auth Verification Failed", "Try Again");
        }
      },
      codeSent: (verificationId, resendToken) {
        this.verificationId.value = verificationId;
      },
      codeAutoRetrievalTimeout: (verificationId) {
        this.verificationId.value = verificationId;
      },
    );
  }

  Future<bool> verifyOTP(String otp) async {
    var credentials = await auth.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: verificationId.value, smsCode: otp));
    return credentials.user != null ? true : false;
  }

  // -------------------- Email and Password Auth --------------------
  Future<String?> createUserWithEmailAndPassword(
      String email, String? password) async {
    try {
      if (password != null) {
        await auth.createUserWithEmailAndPassword(
            email: email, password: password);
      }
    } on FirebaseAuthException catch (e) {
      var ex = RegisterWithEmailAndPasswordFailure.code(e.code);
      return ex.message;
    } catch (_) {
      var ex = RegisterWithEmailAndPasswordFailure();
      return ex.message;
    }
    return null;
  }

  Future<void> sendEmailVerification() async {
    try {
      await auth.currentUser?.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      throw e;
    } catch (_) {
      print("An error occurred while trying to send email verification");
    }
  }

  // -------------------- Login User --------------------
  Future<String?> loginUserWithEmailAndPassword(
      String email, String? password) async {
    try {
      if (password != null) {
        await auth.signInWithEmailAndPassword(email: email, password: password);
      }
    } on FirebaseAuthException catch (e) {
      var ex = LoginException.code(e.code);
      return ex.message;
    } catch (_) {
      var ex = LoginException();
      return ex.message;
    }
    return null;
  }

  // -------------------- Sign In With Google --------------------
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser!.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      final userCredential = await auth.signInWithCredential(credential);
      final user = userCredential.user;
      if (user != null) {
        userRepo.addGoogleUser(user);
      }
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      throw e;
    } catch (_) {
      print("An error occurred while trying to sign in with Google");
    }
  }

  // -------------------- Sign Out --------------------
  Future<void> signOut() async {
    try {
      await auth.signOut();
      await GoogleSignIn().signOut();
      auth.authStateChanges().listen((User? user) {
        if (user == null) {
          Get.offAll(() => WelcomeScreen());
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
