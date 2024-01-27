import 'package:flutter/material.dart';
import 'signup_page.dart';
import 'login_page.dart';
class NewPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TutorMate'),
      ),
      backgroundColor: Colors.black54,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'TutorMate',
              style: TextStyle(
                  fontSize: 40,
                  color: Colors.yellowAccent,
                  fontFamily: 'Sora',
                  fontWeight: FontWeight.bold

              ),
            ),
            SizedBox(height: 10), // Added gap between the image and the buttons
            ClipOval(
              child: Container(
                width: 250,
                height: 200,
                child: Image.asset(
                  'assets/images/logo.jpg', // Replace with the path to your oval-shaped image
                ),
              ),
            ),
            SizedBox(height: 50), // Added gap between the image and the buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.redAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: SizedBox(
                width: 120,
                height: 30,// Adjust the width as needed
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('Sign Up', style: TextStyle(fontSize: 24, color: Colors.white70)),
                ),
              ),
            ),
            SizedBox(height: 10), // Added gap between the buttons
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              child: SizedBox(
                width: 100, // Adjust the width as needed
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text('Login', style: TextStyle(fontSize: 24, color: Colors.white70)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}











