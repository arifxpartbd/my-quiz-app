
import 'package:flutter/material.dart';
import 'package:quizapp/utils/constants.dart';

class NextButton extends StatelessWidget{
  const NextButton({Key? key, required this.nextQuestion}): super(key: key);

  final VoidCallback nextQuestion;
  @override
  Widget build(BuildContext context){
    return  GestureDetector(
      onTap: nextQuestion,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: neutral,
          borderRadius: BorderRadius.circular(10)
        ),
        width: double.infinity,
        child: Text("Next Question",textAlign: TextAlign.center,),
      ),
    );
  }
}