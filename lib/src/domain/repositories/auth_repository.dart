import 'package:eco_cycle/src/domain/repositories/exceptions/login_exception.dart';
import 'package:eco_cycle/src/domain/repositories/exceptions/register_email_password_failure.dart';
import 'package:eco_cycle/src/presentation/pages/home_page.dart';
import 'package:eco_cycle/src/presentation/screens/login_screen.dart';
import 'package:eco_cycle/src/presentation/screens/welcome_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get to => Get.find();

  final auth = FirebaseAuth.instance;
  late final Rx<User?> firebaseUser;
  var verificationId = "".obs;

  @override
  void onReady() {
    firebaseUser = Rx<User?>(auth.currentUser);
    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, setInitialScreen);
  }

  setInitialScreen(User? user) {
    user == null
        ? Get.offAll(() => WelcomeScreen())
        : Get.offAll(() => HomePage());
  }

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

  Future<String?> createUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => LoginScreen())
          : Get.offAll(() => WelcomeScreen());
    } on FirebaseAuthException catch (e) {
      var ex = RegisterWithEmailAndPasswordFailure.code(e.code);
      return ex.message;
    } catch (_) {
      var ex = RegisterWithEmailAndPasswordFailure();
      return ex.message;
    }
    return null;
  }

  Future<String?> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      firebaseUser.value != null
          ? Get.offAll(() => HomePage())
          : Get.offAll(() => WelcomeScreen());
    } on FirebaseAuthException catch (e) {
      var ex = LoginException.code(e.code);
      return ex.message;
    } catch (_) {
      var ex = LoginException();
      return ex.message;
    }
    return null;

  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
