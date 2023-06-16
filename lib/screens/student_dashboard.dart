import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/screens/add_quiz_screen.dart';
import 'package:quizapp/screens/quiz_test_page.dart';
import 'package:quizapp/screens/login_screen.dart';
import 'package:quizapp/screens/result_board.dart';
import 'package:quizapp/utils/myStyle.dart';
import '../widges/home_card_button.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({Key? key}) : super(key: key);

  //final User? user;

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {

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
        title: const Text("Student DashBoard"),
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

          //this row for teacher
          // Row(
          //   children: [
          //     Expanded(
          //       flex: 1,
          //       child: HomeCardButton(
          //         iconData: Icons.area_chart,
          //         onTap: (){
          //
          //           Navigator.push(context, MaterialPageRoute(builder: (context){
          //             return const AddQuizScreen();
          //           }));
          //         },
          //         cardText: "Add Quiz",
          //       ),
          //     ),
          //     const SizedBox(width: 8,),
          //     Expanded(
          //       flex: 1,
          //       child: HomeCardButton(
          //         iconData: Icons.local_offer,
          //         onTap: (){
          //           Navigator.push(context, MaterialPageRoute(builder: (context){
          //             return ResultBoardScreen();
          //           }));
          //         },
          //         cardText: "View Result",
          //       ),
          //     ),
          //
          //
          //
          //   ],
          // ),
          // const SizedBox(height: 8,),

          //this row for student
          Row(
            children: [
              Expanded(
                flex: 1,
                child: HomeCardButton(
                  iconData: Icons.area_chart,
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context){
                      return ResultBoardScreen();
                    }));
                  },
                  cardText: "Result Board",
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
                  cardText: "Quiz Test",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

