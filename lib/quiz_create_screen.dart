import 'package:flutter/material.dart';
import 'package:quizapp/widges/my_text_field_widget.dart';

class QuizCreateScreen extends StatefulWidget {
  const QuizCreateScreen({Key? key}) : super(key: key);

  @override
  State<QuizCreateScreen> createState() => _QuizCreateScreenState();
}

class _QuizCreateScreenState extends State<QuizCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Quiz Page"),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          MyTextField(textEditingController: TextEditingController(),
          lableText: 'Quiz Title',
          ),
          SizedBox(height: 8,),
          MyTextField(textEditingController: TextEditingController(),
          lableText: 'Quiz Time',
          ),
          SizedBox(height: 8,),
          MyTextField(textEditingController: TextEditingController(),
          lableText: 'Quiz Description',
          ),

        ],
      ),
    );
  }
}
