import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:unity_project/models/services/app_service.dart';

class EditProfileController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final AppService _appService = Get.find<AppService>();
  final _isLoading = false.obs;
  final _user = Rxn<User>();
  final _isPasswordVisible = true.obs;
  final _isConfirmPasswordVisible = true.obs;
  final _isOldPasswordVisible = true.obs;

  RxBool get isLoading => _isLoading;
  Rxn<User> get user => _user;
  RxBool get isPasswordVisible => _isPasswordVisible;
  RxBool get isConfirmPasswordVisible => _isConfirmPasswordVisible;
  RxBool get isOldPasswordVisible => _isOldPasswordVisible;

  // update user
  Future<void> editUser(String uid, Map<String, dynamic> data) async {
    await _db.collection('users').doc(uid).update(data);
    await _appService.fetchUser(uid);
  }

  // toggle old password visibility
  void toggleOldPasswordVisibility() {
    _isOldPasswordVisible.value = !_isOldPasswordVisible.value;
  }

  // toggle password visibility
  void togglePasswordVisibility() {
    _isPasswordVisible.value = !_isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible.value = !_isConfirmPasswordVisible.value;
  }

  // Edit Email
  Future<void> editEmail(String newEmail) async {
    try {
      // Checking if the email is already in use
      //updating email in firebase auth
      await _auth.currentUser?.verifyBeforeUpdateEmail(newEmail);
      // Adding new temp email to the database
      await _db.collection('users').doc(_auth.currentUser!.uid).update({
        'newTempEmail': newEmail,
      });
      //re-fetching the user
      await _appService.fetchUser(_auth.currentUser!.uid);
      Get.log("Email updated successfully");
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'invalid-email':
          message = 'The email address is not valid.';
          break;
        case 'email-already-in-use':
          message = 'An account already exists for that email.';
          break;
        case 'requires-recent-login':
          message = 'Please login again to change email.';
          break;
        default:
          message = 'An error occurred during email update.';
          Get.log("Unexpected Error: $e");
      }
      throw message;
    } catch (e) {
      throw "An unexpected error occurred";
    }
  }

  // Reauthenticate User with Password
  Future<void> reauthenticateWithPassword(
    String currentEmail,
    String password,
  ) async {
    final user = FirebaseAuth.instance.currentUser!;
    final cred = EmailAuthProvider.credential(
      email: currentEmail,
      password: password,
    );
    await user.reauthenticateWithCredential(cred);
  }

  // Change Password
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      // Try to change password first
      await _auth.currentUser!.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        // Reauthenticate and retry
        final user = _auth.currentUser!;
        final email = user.email!;
        final cred = EmailAuthProvider.credential(
          email: email,
          password: currentPassword,
        );
        await user.reauthenticateWithCredential(cred);
        await user.updatePassword(newPassword);
      } else {
        // Handle other errors
        final message = switch (e.code) {
          'wrong-password' => 'Old password is incorrect.',
          'weak-password' =>
            'Password is too weak. Use 8+ chars with letters & numbers.',
          'too-many-requests' => 'Too many attempts. Try again later.',
          _ => 'Could not change password. Please try again.',
        };
        throw message;
      }
    }
  }

  // Safe Edit Email
  Future<void> safeEditEmail(
    String newEmail, {
    required bool isGoogleUser,
    required String currentEmail,
    String? passwordForReauth,
  }) async {
    try {
      await editEmail(newEmail); // sends verification + writes newTempEmail
    } on String catch (msg) {
      if (msg.contains('Please login again')) {
        if (isGoogleUser) {
          await reauthenticateWithPassword(currentEmail, passwordForReauth!);
        } else {
          // prompt for password in UI, then:
        }
        await editEmail(newEmail); // retry
      } else {
        rethrow;
      }
    }
  }
}
