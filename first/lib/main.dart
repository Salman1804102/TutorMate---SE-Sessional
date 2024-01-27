import 'package:flutter/material.dart';
import 'second.dart'; // Import the second.dart file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TutorMate',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black12, // Set the background color to black
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black12,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'TutorMate',
              style: TextStyle(
                fontSize: 40,
                color: Colors.white,
                fontFamily: 'Sora',
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 5),
            ClipOval(
              child: Container(
                width: 180,
                height: 200,
                child: Image.asset(
                  'assets/images/logo.jpg', // Replace with the path to your oval-shaped image
                ),
              ),
            ),
            SizedBox(height: 80),
            Text(
              'Days Tracker',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontFamily: 'Sora',
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Payment Reminders',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontFamily: 'Sora',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 80),
            ElevatedButton(
              onPressed: () {
                // Handle button press
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewPage()), // Navigate to the NewPage() when the button is pressed
                );
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red), // Change to the desired color
                // You can customize other button properties here
              ),
              child: Text(
                'Get Started',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
