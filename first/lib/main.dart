import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'second.dart';
import 'dart:io';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid? await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey:"AIzaSyBw976GzSIUzOgcTqa1jC1oUZfKzAsMULg",
      appId: "1:905233028568:android:edcecf7e7844d78e46cead",
      messagingSenderId:'905233028568',
      projectId: "tutormate-20319",
    ),
  ):await Firebase.initializeApp();

  /*if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyC80CHz8zrJI5N1mlsJXCwkSkl1EISCGCo",
        appId: "1:905233028568:web:34596daa5f09224046cead",
        messagingSenderId:"905233028568",
        projectId: "tutormate-20319",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }*/

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
                color: Colors.yellowAccent,
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
                  MaterialPageRoute(builder: (context) => NewPage()),
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