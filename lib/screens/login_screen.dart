import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/screens/home_screen.dart';
import 'package:quizapp/screens/sign_up_screen.dart';
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
  String loginUser = "Student";
  String buttonText = "Teacher Login";

  bool _isTeacher = false;
  bool _isLoading = false;

  TextEditingController emailET = TextEditingController(text: "");
  TextEditingController passwordET = TextEditingController(text: "");

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  myErrorDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Login Failed'),
          content: const Text('Incorrect username or password.'),
          actions: [
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    _isLoading = true;
    setState(() {

    });
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      _isLoading = false;
      setState(() {

      });
      if (user != null) {
        // Login successful, navigate to the home screen or perform any desired actions
        print('Login successful: ${user.email}');
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const HomeScreen(),
          ),
        );
      } else {
        _isLoading = false;
        setState(() {

        });
        myErrorDialog();
        // User is null, show dialog for incorrect username or password
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("User Name or password incorrect")));
      }
    } catch (e) {
      _isLoading = false;
      setState(() {

      });
      myErrorDialog();
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Login Error $e")));
      // Handle login errors
      print('Login error: $e');
    }
  }


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
            child: Form(
              key: _globalKey,
              child: Column(
                children: [
                  Text(
                    "Welcome To Quiz App \n$loginUser Login Portal",
                    style: MyStyle.titleTextStyle(),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                   MyTextField(
                     validator: (value){
                       if(emailET.text.isEmpty){
                         return "Please type your email";
                       }
                       return null;
                     },
                     textEditingController: emailET,
                    lableText: "Email Address",
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                   MyTextField(
                     validator: (value){
                       if(passwordET.text.isEmpty){
                         return "Please type password";
                       }
                       return null;
                     },
                     textEditingController: passwordET,
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
                  _isLoading?const Center(child: CircularProgressIndicator(),):
                  SizedBox(
                    width: double.infinity,
                    child: MyAppButton(
                      onTab: () async{
                        // if(_globalKey.currentState!.validate()){
                        //   User? user = await signUpWithEmailAndPassword(emailET.text, passwordET.text);
                        //   if(user !=null){
                        //     print('User email: ${user.email}');
                        //     print('User ID: ${user.uid}');
                        //
                        //     if(mounted){
                        //       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context){
                        //         return const HomeScreen();
                        //       }), (route) => false);
                        //     }
                        //   }
                        // }
                        if(_globalKey.currentState!.validate()){
                          loginWithEmailAndPassword(emailET.text, passwordET.text);
                        }
                      },
                      buttonText: "Login",
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return SignUpPage(loginUser: loginUser);
                          }));

                        },
                        child: const Text("Create New Account"),
                      ),

                      _isTeacher? TextButton(
                        onPressed: () {
                          loginUser = "Teacher";
                          _isTeacher = false;
                          buttonText = "Student Login";
                          setState(() {

                          });
                        },
                        child:  Text(buttonText),
                      ):TextButton(onPressed: (){
                        loginUser = "Student";
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
      ),
    );
  }
}
