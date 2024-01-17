import 'package:flutter/material.dart';
import 'package:loginapp/views/onboarding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Login Demo',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const OnboardingScreen(),
    );
  }
}
