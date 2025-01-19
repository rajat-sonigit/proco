import 'package:flutter/material.dart';

class Contactus extends StatefulWidget {
  const Contactus({super.key});

  @override
  _ContactusState createState() => _ContactusState();
}
class _ContactusState extends State<Contactus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: const Color.fromARGB(255, 153, 203, 231),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              "Contact US",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
            ),
            const Text(
                "Having a Problem! Dont worry we are here to solve contact us."),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: <Widget>[
                  const SizedBox(height: 8),
                  const TextField(
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Name",
                      border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const TextField(
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Email",
                      border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const TextField(
                    maxLines: 7,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: "Message",
                      border: InputBorder.none,
                    ),
                  ),
                  const SizedBox(height: 8),
                  MaterialButton(
                    height: 60,
                    minWidth: double.infinity,
                    color: Colors.black,
                    onPressed: () {},
                    child: const Text(
                      "Sumbit",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
