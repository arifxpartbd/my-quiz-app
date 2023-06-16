import 'package:flutter/material.dart';
import 'package:quizapp/utils/constants.dart';
class MyAppButton extends StatelessWidget {
   MyAppButton({
    super.key, required this.buttonText,
    required this.onTab
  });
  final String buttonText;
  VoidCallback onTab;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTab,
      style: ElevatedButton.styleFrom(
        backgroundColor: background,
      ),
        child: Text(buttonText,style: TextStyle(color: Colors.white),),
    );
  }
}
