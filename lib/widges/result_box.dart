import 'package:flutter/material.dart';
import 'package:quizapp/utils/constants.dart';

class ResultBox extends StatelessWidget {
  const ResultBox({
    Key? key,
    required this.startOverButton,
    required this.result,
    required this.questionLength,
  }) : super(key: key);

  final int result;
  final int questionLength;
  final VoidCallback startOverButton;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Padding(
        padding: EdgeInsets.all(70),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Result",
              style: TextStyle(color: Colors.black, fontSize: 22),
            ),
            SizedBox(
              height: 20,
            ),
            CircleAvatar(
              // backgroundColor: result == questionLength ? correct : result < questionLength/2 ? incorrect : result == questionLength/2?Colors.yellow : Colors.blue,
              radius: 60,
              child: Text(
                "$result/$questionLength",
                style: TextStyle(fontSize: 30),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              result == questionLength / 2
                  ? "Almost There"
                  : result < questionLength / 2
                      ? "Try Again ?"
                      : "Great!",
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            MaterialButton(
              color: Colors.orange,
              onPressed:startOverButton,
              child: Text("Start Over",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),)
          ],
        ),
      ),
    );
  }
}
