import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:unity_project/models/services/app_service.dart';
import 'package:unity_project/models/user/app_user.dart';

class AuthController extends GetxController {
  final _isLoading = false.obs;
  final _user = Rxn<User>();
  final _isPasswordVisible = true.obs;
  final _isConfirmPasswordVisible = true.obs;
  final _isRememberMe = false.obs;
  final _isGuest = false.obs;

  RxBool get isLoading => _isLoading;
  Rxn<User> get user => _user;
  RxBool get isPasswordVisible => _isPasswordVisible;
  RxBool get isConfirmPasswordVisible => _isConfirmPasswordVisible;
  RxBool get isRememberMe => _isRememberMe;
  RxBool get isGuest => _isGuest;
  User? get currentUser => FirebaseAuth.instance.currentUser;

  // Email validation
  bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Password validation
  bool isValidPassword(String password) {
    return password.length >= 6; // Firebase minimum requirement
  }

  // Toggle Suffix Icon to reveal password
  void togglePasswordVisibility() {
    _isPasswordVisible.value = !_isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible.value = !_isConfirmPasswordVisible.value;
  }

  // Unfocus Keyboard when tapping outside
  void unfocusKeyboard() {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
  }

  bool isValidName(String name) {
    return name.length >= 3;
  }

  // LOGIN into the firebase auth
  void login(String email, String password) async {
    try {
      _isLoading.value = true;
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      await Get.find<AppService>().fetchUser(userCredential.user!.uid);
      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'user-not-found':
          message = 'No user found for that email.';
          break;
        case 'invalid-credential':
          message = 'The email or password is incorrect';
          break;
        case 'invalid-email':
          message = 'The email address is not valid.';
          break;
        case 'user-disabled':
          message = 'This user account has been disabled.';
          break;
        default:
          message = 'An error occurred during login.';
          Get.log("Firebase Auth Error: ${e.code}");
      }
      Get.snackbar(
        'Error',
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
        duration: Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
      );
      Get.log("Unexpected Error: $e");
    } finally {
      _isLoading.value = false;
    }
  }

  // REGISTER into the firebase auth
  void register(
    String email,
    String password,
    String city,
    String displayName,
  ) async {
    try {
      _isLoading.value = true;
      final UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      final userService = Get.find<AppService>();
      final newUser = AppUser(
        uid: userCredential.user!.uid,
        email: email,
        displayName: displayName,
        city: city,
        isAdmin: false,
        createdAt: DateTime.now(),
        isBanned: false,
        isGoogle: false,
      );
      await userService.createUser(newUser);
      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'weak-password':
          message = 'The password provided is too weak.';
          break;
        case 'email-already-in-use':
          message = 'An account already exists for that email.';
          break;
        case 'invalid-email':
          message = 'The email address is not valid.';
          break;
        default:
          message = 'An error occurred during registration.';
          Get.log("Firebase Auth Error: ${e.code}");
      }
      Get.snackbar(
        'Error',
        message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
        duration: Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        "An unexpected error occurred",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
        duration: Duration(seconds: 3),
      );
      Get.log("Unexpected Error: $e");
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      _isLoading.value = true;

      // Trigger the authentication flow
      final GoogleSignIn signIn = GoogleSignIn();
      final GoogleSignInAccount? googleUser = await signIn.signIn();
      if (googleUser == null) {
        _isLoading.value = false;
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final firebaseUser = await FirebaseAuth.instance.signInWithCredential(
        credential,
      );
      final userService = Get.find<AppService>();
      final newUser = AppUser(
        uid: firebaseUser.user!.uid,
        email: googleUser.email,
        city: "",
        isAdmin: false,
        displayName: googleUser.displayName,
        createdAt: DateTime.now(),
        isBanned: false,
        isGoogle: true,
      );
      await userService.createUser(newUser);
      await userService.fetchUser(firebaseUser.user!.uid);
      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error',
        e.message ?? 'An error occurred during Google sign-in.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
        duration: Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
        duration: Duration(seconds: 3),
      );
      Get.log("Unexpected Error: $e");
    } finally {
      _isLoading.value = false;
    }
  }

  Future<void> signInAnonymously() async {
    try {
      _isLoading.value = true;
      await FirebaseAuth.instance.signInAnonymously();
      Get.offAllNamed('/home');
    } on FirebaseAuthException catch (e) {
      Get.snackbar(
        'Error',
        e.message ?? 'An error occurred during guest sign-in.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
        duration: Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'An unexpected error occurred',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
        duration: Duration(seconds: 3),
      );
      Get.log("Unexpected Error: $e");
    } finally {
      _isLoading.value = false;
    }
  }
}
