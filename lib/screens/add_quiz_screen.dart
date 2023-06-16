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

  TextEditingController titleET = TextEditingController(text: "");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Quiz Info"),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          MyTextField(
            textEditingController: titleET,
            lableText: "Title",
          ),
          const SizedBox(height: 8,),

          MyTextField(
            textEditingController: titleET,
            lableText: "Time",
          ),

          const SizedBox(height: 8,),
          MyTextField(
            maxLine: 5,
            textEditingController: titleET,
            lableText: "Description",
          ),
          SizedBox(height: 8,),
          MyAppButton(buttonText: "Next", onTab: (){
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return QuizFormScreen();
            }));
          })
        ],
      ),
    );
  }
}
