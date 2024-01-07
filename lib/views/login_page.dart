// login_page.dart

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import '../controllers/login_controller.dart';
import '../widgets/custom_input_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LoginScreen(controller: LoginController());
  }
}

class LoginScreen extends StatefulWidget {
  final LoginController controller;

  const LoginScreen({required this.controller, Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => widget.controller.onBackPressed(),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: widget.controller.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomInputField(
                    controller: widget.controller.emailController,
                    hintText: "Email",
                    prefixIcon: Icons.email,
                    onValidationError: widget.controller.onValidationError,
                  ),
                  const SizedBox(height: 16.0),
                  CustomInputField(
                    controller: widget.controller.passwordController,
                    hintText: "Password",
                    prefixIcon: Icons.lock,
                    isPassword: true,
                    onValidationError: widget.controller.onValidationError,
                  ),
                  const SizedBox(height: 24.0),
                  ElevatedButton(
                    onPressed: isLoading
                        ? null
                        : () => widget.controller
                            .onLoginPressed(onLoadingStateChanged),
                    child: Text(isLoading ? 'Logging in...' : 'Login'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Callback to handle loading state changes
  void onLoadingStateChanged(bool loading) {
    setState(() {
      isLoading = loading;
    });
  }
}
