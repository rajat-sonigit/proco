import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:proco/aboutus.dart';
import 'package:proco/authservice.dart';
import 'package:proco/chats.dart';
import 'package:proco/contact.dart';
import 'package:proco/imagetest.dart';
import 'package:proco/login_pag.dart';
import 'package:proco/profile_creation_fire.dart';
import 'package:proco/splashscreen.dart';
import 'package:provider/provider.dart';

class ProfileSc extends StatelessWidget {
  String name;
  ProfileSc({Key? key, required this.name}) : super(key: key);
  void signOut(BuildContext context) async {
    final authService = Provider.of<AuthService>(context, listen: false);
    await FirebaseAuth.instance.signOut();
    // Add any additional sign-out logic if needed
    // For example, clear user session, remove tokens, etc.

    // Navigate back to the splash screen
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => splash(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple[50],
      // AppBor
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset("assets/images/av.png")),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(name == "" ? "Chirag" : name,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
                const Text("I am a Designer and Web Developer",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfileCreationPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        side: BorderSide.none,
                        shape: const StadiumBorder()),
                    child: const Text("EditProfile",
                        style: TextStyle(
                            color: Color.fromARGB(255, 248, 246, 246))),
                  ),
                ),
                const SizedBox(height: 30),
                const Divider(),
                const SizedBox(height: 10),
                ProfileMenuWidget(
                    title: "contact us",
                    icon: LineAwesomeIcons.cog,
                    endIcon: true,
                    onpress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Contactus()),
                      );
                    }),
                ProfileMenuWidget(
                    title: "Manage",
                    icon: LineAwesomeIcons.user_friends,
                    endIcon: true,
                    onpress: () {}),
                const SizedBox(height: 10),
                ProfileMenuWidget(
                    title: "Information",
                    icon: LineAwesomeIcons.info,
                    onpress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => aboutus()),
                      );
                    }),
                ProfileMenuWidget(
                    title: "Logout",
                    icon: LineAwesomeIcons.alternate_sign_out,
                    textcolor: Colors.red,
                    endIcon: false,
                    onpress: () => signOut(context)),
              ],
              // Column// Container
            ),
          ), // SingleChildScrollView
        ),
      ),
    );
  }
}

class ProfileMenuWidget extends StatelessWidget {
  const ProfileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onpress,
    this.endIcon = true,
    this.textcolor,
  }) : super(key: key);

  final String title;
  final IconData icon;
  final VoidCallback onpress;
  final bool endIcon;
  final Color? textcolor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onpress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color.fromARGB(235, 0, 0, 0),
        ), // BoxDecoration
        child: Icon(icon, color: const Color.fromARGB(255, 238, 226, 226)),
      ),
      title: Text(title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color:
                    const Color.fromARGB(255, 255, 250, 250).withOpacity(0.1),
              ),
              child: const Icon(LineAwesomeIcons.angle_right,
                  size: 18.0, color: Color.fromARGB(255, 18, 16, 16)))
          : null,
      // Container
    );
  }
}
