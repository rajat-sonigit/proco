import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proco/chats.dart';

class Person {
  final String name;
  final String imageUrl;
  final String description;
  final List<String> keywords;

  Person({
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.keywords,
  });
}
class MatchingScreen extends StatefulWidget {
  @override
  _MatchingScreenState createState() => _MatchingScreenState();
}
class _MatchingScreenState extends State<MatchingScreen> {
  // Dummy list of persons (for demonstration purposes)
  List<Person> persons = [
    Person(
      name: 'Raghav',
      imageUrl: 'assets/images/th.jpg', // Assuming this is your image URL
      description: 'Software Engineer',
      keywords: ['Java', 'Coding', 'Flutter'],
    ),
    Person(
      name: 'Anita',
      imageUrl: 'assets/images/ee.jpg',
      description: 'Web Developer',
      keywords: ['Java', 'HTML', 'coding'],
    ),
    Person(
      name: 'Arun',
      imageUrl: 'assets/images/yb.jpg',
      description: 'Web Developer',
      keywords: ['Photography', 'HTML', 'CSS'],
    ),
    Person(
      name: 'Shreya',
      imageUrl: 'assets/images/js.jpg',
      description: 'Web Developer',
      keywords: ['flutter', 'sketching', 'Dancing'],
    ),
    Person(
      name: 'Anuj',
      imageUrl: 'assets/images/ow.jpg',
      description: 'Web Developer',
      keywords: ['Java', 'HTML', 'coding'],
    ),
    Person(
      name: 'Sristi',
      imageUrl: 'assets/images/yb.jpg',
      description: 'Web Developer',
      keywords: ['Photography', 'HTML', 'CSS'],
    ),
    Person(
      name: 'jaypal',
      imageUrl: 'assets/images/js.jpg',
      description: 'Web Developer',
      keywords: ['flutter', 'sketching', 'Dancing'],
    ),
    Person(
      name: 'Riya',
      imageUrl: 'assets/images/ow.jpg',
      description: 'Web Developer',
      keywords: ['Java', 'HTML', 'coding'],
    ),
    Person(
      name: 'Samriddhi',
      imageUrl: 'assets/images/dd.jpg',
      description: 'Web Developer',
      keywords: ['flutter', 'sketching', 'Dancing'],
    ),
    Person(
      name: 'yash',
      imageUrl: 'assets/images/cc.jpg',
      description: 'Web Developer',
      keywords: ['Photography', 'HTML', 'CSS'],
    ),
  ];

  void _removePerson(int index) {
    setState(() {
      persons.removeAt(index);
    });
  }

  int currindex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 146, 162, 209),
      body: Stack(
        children: [
          // Cards
          for (var i = 0; i < persons.length; i++)
            Draggable(
              feedback: SizedBox.shrink(),
              childWhenDragging: SizedBox.shrink(),
              onDragEnd: (details) {
                if (details.offset.dx < -100) {
                  _removePerson(i);
                } else if (details.offset.dx > 100) {
                  // Handle like action
                  _removePerson(i);
                }
              },
              child: PersonCard(person: persons[i]),
            ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.transparent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ElevatedButton(
            //   onPressed: () {
            //     // Dislike Action
            //     _removePerson(0);
            //   },
            //   style: ElevatedButton.styleFrom(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(30.0),
            //     ),
            //     backgroundColor: Color.fromARGB(255, 224, 202, 218),
            //   ),
            //   child: Padding(
            //     padding: const EdgeInsets.all(15),
            //     child: Icon(Icons.close),
            //   ),
            // ),
            ElevatedButton(
              onPressed: () {
                // Like Action
                FirebaseAuth inst = FirebaseAuth.instance;
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Chats(
                            receiverUserEmail: inst.currentUser!.email!,
                            receiverUserId: inst.currentUser!.uid)));
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                backgroundColor: Color.fromARGB(255, 224, 202, 218),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Text("Chat"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PersonCard extends StatelessWidget {
  final Person person;

  const PersonCard({Key? key, required this.person}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.asset(
                  person.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                person.name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              child: Wrap(
                spacing: 5,
                runSpacing: -5,
                children: person.keywords
                    .map(
                      (keyword) => Chip(
                        label: Text(keyword),
                      ),
                    )
                    .toList(),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MatchingScreen(),
  ));
}
