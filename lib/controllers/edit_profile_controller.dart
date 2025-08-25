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
  final _isOldPasswordEntered = false.obs;
  final _securityUnlocked = false.obs;
  final _wantsToChangePassword = false.obs;
  final _recentPassword = Rxn<String>();

  RxBool get isLoading => _isLoading;
  Rxn<User> get user => _user;
  RxBool get isPasswordVisible => _isPasswordVisible;
  RxBool get isConfirmPasswordVisible => _isConfirmPasswordVisible;
  RxBool get isOldPasswordEntered => _isOldPasswordEntered;
  RxBool get securityUnlocked => _securityUnlocked;
  RxBool get wantsToChangePassword => _wantsToChangePassword;
  bool get isPasswordValid => _recentPassword.value != null;
  String? get storedPassword => _recentPassword.value;

  @override
  void onClose() {
    _clearStoredPassword();
    super.onClose();
  }

  // update user
  Future<void> editUser(String uid, Map<String, dynamic> data) async {
    await _db.collection('users').doc(uid).update(data);
    await _appService.fetchUser(uid);
  }

  // toggle password visibility
  void togglePasswordVisibility() {
    _isPasswordVisible.value = !_isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    _isConfirmPasswordVisible.value = !_isConfirmPasswordVisible.value;
  }

  // Edit Email
  Future<void> editEmail({
    required String newEmail,
    required String currentPassword,
    required String oldEmail,
  }) async {
    try {
      // Check if Email is in auth

      //updating email in firebase auth
      await _auth.currentUser?.verifyBeforeUpdateEmail(newEmail);
      Get.log(_auth.currentUser!.emailVerified.toString());
      // Adding new temp email to the database
      await _db.collection('users').doc(_auth.currentUser!.uid).update({
        'newTempEmail': newEmail,
      });
      //re-fetching the user
      await _appService.fetchUser(_auth.currentUser!.uid);
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'invalid-credential':
          message = 'Invalid credentials.';
          break;
        case 'user-not-found':
          message = 'This email is not associated with any account.';
          break;
        case 'email-already-in-use':
          message = 'An account already exists for that email.';
          break;
        case 'requires-recent-login':
          message = 'Please login again to change email.';
          break;
        case 'channel-error':
          message = 'An error occurred during email update.';
          break;
        default:
          message = 'An error occurred during email update.';
          Get.log("Unexpected Error: $e");
      }
      throw message;
    } catch (e) {
      throw "An unexpected error occurred $e";
    }
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

  //Verify current password
  Future<void> verifyCurrentPassword(String currentPassword) async {
    try {
      await _auth.currentUser
          ?.reauthenticateWithCredential(
            EmailAuthProvider.credential(
              email: _auth.currentUser!.email!,
              password: currentPassword,
            ),
          )
          .then((value) {
            Get.log("Password is Correct");
          });
      _recentPassword.value = currentPassword;
      _securityUnlocked.value = true;
    } on FirebaseAuthException catch (e) {
      String message;
      switch (e.code) {
        case 'invalid-credential':
          message = 'Invalid credentials.';
          break;
        case 'user-not-found':
          message = 'This email is not associated with any account.';
          break;
        default:
          message = 'An error occurred during password verification.';
          Get.log("Unexpected Error: $e");
      }
      throw message;
    } catch (e) {
      throw "An unexpected error occurred $e";
    }
  }

  void _clearStoredPassword() {
    _recentPassword.value = null;
    _securityUnlocked.value = false;
    _wantsToChangePassword.value = false;
  }
}
