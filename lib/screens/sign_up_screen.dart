
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/screens/home_screen.dart';
import 'package:quizapp/widges/my_app_button.dart';
import 'package:quizapp/widges/my_text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';


class SignUpPage extends StatefulWidget {
   const SignUpPage({Key? key, required this.loginUser}) : super(key: key);

   final String loginUser;
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool _isLoading = false;

  Future<User?> signUpWithEmailAndPassword(String email, String password) async {
    _isLoading = true;
    setState(() {

    });
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      String userId = userCredential.user!.uid;
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'name': userNameET.text,
        'role':widget.loginUser,
        'createdat':DateTime.now().toString(),
        'uid': userId
        // 'phone': phone,
      });
      _isLoading = false;
      setState(() {

      });
      print(user);
      return user;
    } catch (e) {
      print(e.toString());
      _isLoading = false;
      setState(() {

      });
      return null;
    }
  }

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final TextEditingController emailET = TextEditingController();
  final TextEditingController passwordET = TextEditingController();
  final TextEditingController userNameET = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Join With Us"),
      ),
      body: Form(
        key: _globalKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            MyTextField(
              validator: (value){
                if(value!.isEmpty){
                  return "Please type user name";
                }
                return null;
              },
              textEditingController: userNameET,
              lableText: "${widget.loginUser} Name",
            ),
            const SizedBox(
              height: 8,
            ),
             MyTextField(
               validator: (value){
                 if(value!.isEmpty){
                   return "Please type valid email address";
                 }
                 return null;
               },
               textEditingController: emailET,
              lableText: "Email address",
            ),
            const SizedBox(
              height: 8,
            ),
             MyTextField(
               validator: (value){
                 if(value!.isEmpty){
                   return "Please type password";
                 }else if(passwordET.text.length <6){
                   return "Password length must be 6";
                 }
                 return null;
               },

               textEditingController: passwordET,
              lableText: "Create Password",
            ),
            const SizedBox(
              height: 8,
            ),

            _isLoading?const Center(child: (CircularProgressIndicator())):
            MyAppButton(buttonText: "Submit", onTab: () async{
              if(_globalKey.currentState!.validate()){
                User? user = await signUpWithEmailAndPassword(emailET.text, passwordET.text);
                if(user !=null){
                  print('User email: ${user.email}');
                  print('User ID: ${user.uid}');

                  if(mounted){
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
                      return const HomeScreen();
                    }), (route) => false);
                  }
                }
              }
            })
          ],
        ),
      ),
    );
  }
}
