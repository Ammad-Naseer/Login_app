import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/login_model.dart';
import '../utils/toast.dart';

class LoginController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LoginModel _model = LoginModel();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late Function(bool) onLoadingStateChanged;

  Future<bool> onBackPressed() async {
    return await showDialog(
      context: _getContext(),
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Exit App'),
          content: const Text('Are you sure you want to exit the app?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).popUntil((route) => route.isFirst);
                Navigator.of(context).pop(true);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> onLoginPressed(
      void Function(bool loading) onLoadingStateChanged) async {
    if (formKey.currentState?.validate() ?? false) {
      // Form is valid, proceed with login
      final email = emailController.text;
      final password = passwordController.text;

      bool isAuthenticated = await _model.authenticateUser(email, password);

      if (isAuthenticated) {
        // Navigate to the next screen or perform any other action upon successful authentication.
        if (kDebugMode) {
          print("User authenticated!");
        }
      } else {
        // Display an error message or perform any other action upon unsuccessful authentication.
        if (kDebugMode) {
          print("Authentication failed!");
        }
      }
    }
  }

  BuildContext _getContext() {
    return navigatorKey.currentContext!;
  }

  void onValidationError(String? error) {
    if (error != null) {
      Utils().toastMessage(error);
      if (kDebugMode) {
        print(error);
      }
    }
  }
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
