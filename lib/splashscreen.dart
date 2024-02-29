import 'package:flutter/material.dart';
import 'package:proco/authgate.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<splash> {
  @override
  void initState() {
    _goHome();
    super.initState();
  }

  _goHome() async {
    await Future.delayed(const Duration(milliseconds: 3000), () {});
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const AuthGate()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 2, 12, 8),
      body: Center(
        child: Image.asset("assets/images/logoo.png"),
      ),
    );
  }
}
