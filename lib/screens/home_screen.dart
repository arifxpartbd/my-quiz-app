import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/screens/add_quiz_screen.dart';
import 'package:quizapp/screens/quiz_form_screen.dart';
import 'package:quizapp/screens/quiz_test_page.dart';
import 'package:quizapp/screens/login_screen.dart';
import 'package:quizapp/utils/myStyle.dart';

import '../widges/home_card_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  //final User? user;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  User? currentUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        currentUser = user;
      });
    });
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut().then((value){
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
          return const LoginScreen();
        }), (route) => false);
      });
      // Perform any additional actions after sign out
      print('Sign out successful');
    } catch (e) {
      // Handle sign out errors
      print('Sign out error: $e');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DashBoard"),
        actions: [
          IconButton(onPressed: (){
            signOut();
          }, icon: const Icon(Icons.logout))
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const CircleAvatar(
                      radius: 40,
                      child: Icon(Icons.person)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(currentUser?.email.toString()??"User Name",style: MyStyle.subTitleStyle(),),
                      const Text("username@mail.com")
                    ],
                  )
                ],
              ),
            ),
          ),
          const SizedBox(height: 8,),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: HomeCardButton(
                  iconData: Icons.area_chart,
                  onTap: (){

                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return AddQuizScreen();
                    }));
                  },
                  cardText: "View Result",
                ),
              ),
              const SizedBox(width: 8,),
              Expanded(
                flex: 1,
                child: HomeCardButton(
                  iconData: Icons.local_offer,
                  onTap: (){},
                  cardText: "View All Quiz",
                ),
              ),



            ],
          ),
          const SizedBox(height: 8,),
          Row(
            children: [
              Expanded(
                flex: 1,
                child: HomeCardButton(
                  iconData: Icons.area_chart,
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return QuizFormScreen();
                    }));
                  },
                  cardText: "View Quiz Result",
                ),
              ),
              const SizedBox(width: 8,),
              Expanded(
                flex: 1,
                child: HomeCardButton(
                  iconData: Icons.local_offer,
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return const QuizTestPage();
                    }));
                  },
                  cardText: "Add Quiz",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

