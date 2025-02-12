import 'package:flutter/material.dart';
import 'package:proco/login_pag.dart';
import 'package:proco/signup_page.dart';

class AuthenticationPage extends StatefulWidget {
  const AuthenticationPage({super.key});
  @override
  State<AuthenticationPage> createState() => _AuthenticationPageState();
}
class _AuthenticationPageState extends State<AuthenticationPage> {
  bool showLoginPage = true;
  void togglePages() {
    setState(() {
      
      
      showLoginPage = !showLoginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(name: "");
    } else {
      return const SignupPage();
    }
  }
}
