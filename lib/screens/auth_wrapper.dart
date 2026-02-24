import 'package:flutter/material.dart';
import 'login_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // Later we will check token here
    return const LoginScreen();
  }
}