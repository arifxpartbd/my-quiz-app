import 'package:flutter/material.dart';
import 'package:quizapp/utils/constants.dart';

class ResultBox extends StatelessWidget {
  const ResultBox({
    Key? key,
    required this.startOverButton,
    required this.result,
    required this.questionLength,
    required this.submitResult,
  }) : super(key: key);

  final int result;
  final int questionLength;
  final VoidCallback startOverButton;
  final VoidCallback submitResult;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Padding(
        padding: const EdgeInsets.all(70),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Result",
              style: TextStyle(color: Colors.black, fontSize: 22),
            ),
            const SizedBox(
              height: 20,
            ),
            CircleAvatar(
              // backgroundColor: result == questionLength ? correct : result < questionLength/2 ? incorrect : result == questionLength/2?Colors.yellow : Colors.blue,
              radius: 60,
              child: Text(
                "$result/$questionLength",
                style: const TextStyle(fontSize: 30),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              result == questionLength / 2
                  ? "Almost There"
                  : result < questionLength / 2
                      ? "Try Again ?"
                      : "Great!",
              style: const TextStyle(
                fontSize: 22,
              ),
            ),
            MaterialButton(
              color: Colors.orange,
              onPressed: startOverButton,
              child: const Text(
                "Start Over",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                ),
              ),
            ),
            MaterialButton(
              color: background,
              onPressed: submitResult,
              child: const Text("Submit Result",style: TextStyle(color: Colors.white),),
            )
          ],
        ),
      ),
    );
  }
}
