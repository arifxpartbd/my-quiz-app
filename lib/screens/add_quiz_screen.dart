import 'package:flutter/material.dart';
import 'package:quizapp/screens/quiz_form_screen.dart';
import 'package:quizapp/widges/my_app_button.dart';
import 'package:quizapp/widges/my_text_field_widget.dart';

class AddQuizScreen extends StatefulWidget {
  const AddQuizScreen({Key? key}) : super(key: key);

  @override
  State<AddQuizScreen> createState() => _AddQuizScreenState();
}

class _AddQuizScreenState extends State<AddQuizScreen> {

  TextEditingController mainTitleET = TextEditingController(text: "");
  TextEditingController descriptionED = TextEditingController(text: "");
  TextEditingController timeET = TextEditingController(text: "");
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Quiz Info"),
      ),
      body: Form(
        key: _globalKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            MyTextField(
              validator: (value){
                if(mainTitleET.text.isEmpty){
                  return "Please type title";
                }
                return null;
              },
              textEditingController: mainTitleET,
              lableText: "Title",
            ),
            const SizedBox(height: 8,),

            MyTextField(
              validator: (value){
                if(timeET.text.isEmpty){
                  return "Please type time";
                }
                return null;
              },
              textEditingController: timeET,
              lableText: "Time",
            ),

            const SizedBox(height: 8,),
            MyTextField(
              validator: (value){
                if(descriptionED.text.isEmpty){
                  return "Please type description";
                }
                return null;
              },
              maxLine: 5,
              textEditingController: descriptionED,
              lableText: "Description",
            ),
            const SizedBox(height: 8,),
            MyAppButton(buttonText: "Next", onTab: (){

              if(_globalKey.currentState!.validate()){
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return QuizFormScreen(mainTitle: mainTitleET.text,description: descriptionED.text,
                    time: timeET.text,);
                }));
              }
            })
          ],
        ),
      ),
    );
  }
}
