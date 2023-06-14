import 'package:flutter/material.dart';
import 'package:quizapp/screens/home_screen.dart';

import '../utils/myStyle.dart';
import '../widges/my_app_button.dart';
import '../widges/my_text_field_widget.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isChecked = false;
  String loginUser = "Student Login";
  String buttonText = "Student Login";

  bool _isTeacher = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Login Screen"),
      // ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text(
                  "Welcome To Quiz App \n$loginUser Portal",
                  style: MyStyle.titleTextStyle(),
                ),
                const SizedBox(
                  height: 16,
                ),
                const MyTextField(
                  lableText: "Email Address",
                ),
                const SizedBox(
                  height: 16,
                ),
                const MyTextField(
                  lableText: "Password",
                ),
                const SizedBox(
                  height: 8,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Checkbox(value: _isChecked, onChanged: (bool? value){
                          setState(() {
                            _isChecked = value!;
                          });
                        }),
                        const Text("Remember Me"),

                      ],
                    ),
                    TextButton(onPressed: (){

                    }, child: const Text("Forget Password"))
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: MyAppButton(
                    onTab: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context){
                        return HomeScreen();
                      }));
                    },
                    buttonText: "Login",
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: const Text("Create New Account"),
                    ),

                    _isTeacher? TextButton(
                      onPressed: () {
                        loginUser = "Teacher Login";
                        _isTeacher = false;
                        buttonText = "Student Login";
                        setState(() {

                        });
                      },
                      child:  Text(buttonText),
                    ):TextButton(onPressed: (){
                      loginUser = "Student Login";
                      buttonText = "Teacher Login";
                      _isTeacher = true;
                      setState(() {

                      });
                    }, child: Text(buttonText))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
