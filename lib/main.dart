import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/screens/home_screen.dart';
import 'package:quizapp/screens/login_screen.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});

  // This widget is the root of your application.

  final FirebaseAuth _auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          elevation: 0
        ),
        primarySwatch: Colors.orange,
      ),
      home: FutureBuilder(
        future: FirebaseAuth.instance.authStateChanges().first,
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Show a loading screen if the authentication state is still loading
            return const CircularProgressIndicator();
          } else {
            // Check if the user is logged in
            if (snapshot.hasData) {
              // User is already logged in, navigate to the home screen
              return const HomeScreen();
            } else {
              // User is not logged in, navigate to the login screen
              return const LoginScreen();
            }
          }
        },
      ),
    );
  }

   Future<bool> _checkIfUserIsLoggedIn()async{
     final currentUser = _auth.currentUser;
     if(currentUser !=null){
       return true;
     }
     return false;
   }
}
