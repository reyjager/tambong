// // reset_password_view.dart
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:tambong/authentication/auth_service.dart';
// import 'package:tambong/authentication/auth_viewmodel.dart';
// import 'package:flutter/material.dart';
// import 'package:stacked/stacked.dart';

// class ResetPasswordView extends StatelessWidget {
//   final TextEditingController emailController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return ViewModelBuilder<AuthenticationViewModel>.reactive(
//       viewModelBuilder: () =>
//           AuthenticationViewModel(AuthenticationService(FirebaseAuth.instance)),
//       builder: (context, model, child) => Scaffold(
//         appBar: AppBar(title: const Text('Reset Password')),
//         body: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               TextField(
//                   controller: emailController,
//                   decoration: const InputDecoration(labelText: 'Email')),
//               const SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () => model.resetPassword(emailController.text),
//                 child: const Text('Reset Password'),
//               ),
//               if (model.errorMessage != null) ...[
//                 const SizedBox(height: 20),
//                 Text(
//                   model.errorMessage!,
//                   style: const TextStyle(color: Colors.red),
//                 ),
//               ],
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
