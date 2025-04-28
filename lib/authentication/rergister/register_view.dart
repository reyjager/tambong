// register_view.dart
import 'package:tambong/authentication/rergister/register_viewmodel.dart';
import 'package:tambong/themes/theme_service.dart';
import 'package:tambong/widgets/eleveted_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class RegisterView extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  RegisterView({super.key});
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RegisterViewModel>.reactive(
      viewModelBuilder: () => RegisterViewModel(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: ThemeService.currentColorScheme.primaryColor,
        appBar: AppBar(
          backgroundColor: ThemeService.currentColorScheme.primaryColor,
          title: const Text(
            'Register',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: model.isBusy
            ? const Center(child: CircularProgressIndicator())
            : Stack(
                children: [
                  Positioned(
                    left: 20,
                    right: 20,
                    top: 20,
                    child: Column(
                      children: [
                        Image.asset(
                          "assets/tambong_logo.png",
                          height: 200,
                          width: 200,
                          color: Colors.amber,
                        ),
                        const Text(
                          "Tambong",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              letterSpacing: 18),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Container(
                        height: 500,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: TextField(
                                  controller: emailController,
                                  decoration: const InputDecoration(
                                      hintText: "yourEmail@gmail.com",
                                      labelText: 'Email',
                                      border: OutlineInputBorder()),
                                  keyboardType: TextInputType.emailAddress,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: TextField(
                                  controller: passwordController,
                                  decoration: InputDecoration(
                                    iconColor: ThemeService
                                        .currentColorScheme.primaryColor,
                                    labelText: 'Password',
                                    border: const OutlineInputBorder(),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        model.obscurePassword
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                      onPressed: () =>
                                          model.togglePasswordVisibility(),
                                    ),
                                  ),
                                  keyboardType: TextInputType.visiblePassword,
                                  obscureText: model.obscurePassword,
                                ),
                              ),
                              if (model.errorMessage != null) ...[
                                const SizedBox(height: 20),
                                Text(
                                  model.errorMessage!,
                                  style: const TextStyle(color: Colors.red),
                                ),
                              ],
                              const SizedBox(height: 20),
                              CustomElevatedButton(
                                text: 'Register',
                                onPressed: () => model.signUp(
                                    emailController.text,
                                    passwordController.text),
                                backgroundColor: ThemeService
                                    .currentColorScheme.primaryColor,
                              ),
                              GestureDetector(
                                onTap: () => model.navigateToSignIn(),
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 20),
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        const TextSpan(
                                          text: "Already have an Account? ",
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        TextSpan(
                                          text: 'Sign In here',
                                          style: TextStyle(
                                            color: ThemeService
                                                .currentColorScheme
                                                .primaryColor,
                                            decoration:
                                                TextDecoration.underline,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
