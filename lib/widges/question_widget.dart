import 'package:flutter/material.dart';
import 'package:quizapp/utils/constants.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget(
      {Key? key,
      required this.questions,
      required this.totalQuestions,
      required this.indexAction})
      : super(key: key);

  final String questions;
  final int indexAction;
  final int totalQuestions;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        "Question ${indexAction + 1}/$totalQuestions: $questions",
        style: TextStyle(
            fontWeight: FontWeight.bold, fontSize: 24, color: neutral),
      ),
    );
  }
}
