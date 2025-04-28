// // authentication_viewmodel.dart
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:tambong/authentication/auth_service.dart';
// import 'package:tambong/rergister/register_view.dart';
// import 'package:tambong/sign_in/sign_in_view.dart';
// import 'package:tambong/home/home_view.dart';
// import 'package:get/get.dart';
// import 'package:stacked/stacked.dart';

// class AuthenticationViewModel extends BaseViewModel {
//   final AuthenticationService _authenticationService;

//   AuthenticationViewModel(this._authenticationService);

//   String? _errorMessage;
//   String? get errorMessage => _errorMessage;

//   bool _obscurePassword = true;
//   bool _isChecked = false;
//   bool get obscurePassword => _obscurePassword;
//   bool get isChecked => _isChecked;

//   Future<void> signIn(String email, String password) async {
//     setBusy(true);

//     String? response =
//         await _authenticationService.signIn(email: email, password: password);

//     if (response == "Signed in") {
//       _errorMessage = null;
//       Get.off(() => HomeView());
//     } else {
//       _errorMessage = response;
//     }

//     setBusy(false);
//   }

//   Future<void> signUp(String email, String password) async {
//     setBusy(true);
//     _errorMessage = null;
//     String? response =
//         await _authenticationService.signUp(email: email, password: password);

//     if (response == "Signed up") {
//       User? currentUser = FirebaseAuth.instance.currentUser;
//       if (currentUser != null) {
//         Get.off(() => HomeView());
//         //  CompleteProfileView(
//         //     userId: currentUser.uid, email: currentUser.email!, isEdit: false));
//       } else {
//         _errorMessage = "User not found";
//       }
//     } else {
//       _errorMessage = response;
//     }
//     setBusy(false);
//   }

//   Future<void> signOut() async {
//     setBusy(true);
//     await _authenticationService.signOut();
//     Get.off(() => SignInView());
//     setBusy(false);
//   }

//   Future<void> resetPassword(String email) async {
//     setBusy(true);
//     _errorMessage = await _authenticationService.resetPassword(email: email);
//     setBusy(false);
//   }

//   navigateToRegister() {
//     Get.off(() => RegisterView());
//   }

//   navigateToSignIn() {
//     Get.off(() => SignInView());
//   }

//   void togglePasswordVisibility() {
//     _obscurePassword = !_obscurePassword;
//     notifyListeners();
//   }

//   void toggleCheckbox(bool? value) {
//     _isChecked = value ?? false;
//     notifyListeners();
//   }
// }
