import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proco/authservice.dart';
import 'package:proco/chats.dart';
import 'package:proco/firebase_options.dart';
import 'package:proco/home_page.dart';
import 'package:proco/imagetest.dart';
import 'package:proco/login_pag.dart';
import 'package:proco/profile_creation_fire.dart';
import 'package:proco/profilemain.dart';
import 'package:proco/splashscreen.dart';
import 'package:proco/swipe_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => AuthService(),
      child: const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: splash(),
      ),
    );
  }
}
