import 'package:flutter/material.dart';

class aboutus extends StatefulWidget {
  const aboutus({super.key});

  @override
  _AboutusState createState() => _AboutusState();
}

class _AboutusState extends State<aboutus> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color.fromARGB(255, 207, 239, 238),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "About Us",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 60),
            ),
            SizedBox(height: 10),
            Text(
              "ProCo",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            ),
            SizedBox(height: 5),
            Text(
                " ----- ProCo addresses the challenge students face in finding reliable project collaborators by facilitating connections through a matching platform and fostering meaningful communication with a seamless messaging feature."),
            SizedBox(height: 3),
            Text(
                "   -  Users can sign up via email or Discord, swipe through profiles for potential matches, and utilize profile editing tools to customize their information, enhancing the collaborative experience in educational projects."),
            SizedBox(height: 6),
            Text(
              "Developed By -",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            SizedBox(height: 5),
            Text(
              "Complaier Crew",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(height: 5),
            Text("Members -",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30)),
            SizedBox(height: 2),
            Text("Rajat Soni"),
            SizedBox(height: 2),
            Text("Divy Singhvi "),
            SizedBox(height: 2),
            Text("Chirag Gupta "),
            SizedBox(height: 2),
            Text("Harshul Dashora"),
          ],
        ),
      ),
    );
  }
}
