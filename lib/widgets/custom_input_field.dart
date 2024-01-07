// CustomInputField.dart

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';

class CustomInputField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final bool isPassword;
  final Function(String?)? onValidationError; // Callback for validation errors

  const CustomInputField({
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.isPassword = false,
    this.onValidationError,
    Key? key,
  }) : super(key: key);

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            spreadRadius: 7,
            offset: const Offset(1, 1),
            color: Colors.grey.withOpacity(0.4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 15.0),
        child: TextFormField(
          controller: widget.controller,
          obscureText: widget.isPassword && !isPasswordVisible,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              color: Colors.grey,
            ),
            prefixIcon: Icon(
              widget.prefixIcon,
              color: Colors.green,
            ),
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        isPasswordVisible = !isPasswordVisible;
                      });
                    },
                  )
                : null,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: Colors.white,
                width: 1.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: const BorderSide(
                color: Colors.white,
                width: 1.0,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter ${widget.hintText.toLowerCase()}';
            }

            if (widget.isPassword) {
              if (value.length < 8) {
                return 'Password must be at least 8 characters';
              }

              if (!value.contains(RegExp(r'[A-Z]'))) {
                return 'Password must contain at least one capital letter';
              }

              if (!value.contains(RegExp(r'[a-z]'))) {
                return 'Password must contain at least one small letter';
              }

              if (!value.contains(RegExp(r'[0-9]'))) {
                return 'Password must contain at least one number';
              }

              if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
                return 'Password must contain at least one special character';
              }
            } else if (!_isValidEmail(value)) {
              return 'Please enter a valid email address';
            }

            return null; // Return null if the validation passes
          },
        ),
      ),
    );
  }

  bool _isValidPassword(String password) {
    return password.length >= 8;
  }

  bool _isValidEmail(String email) {
    final RegExp emailRegex =
        RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
    return emailRegex.hasMatch(email);
  }
}
