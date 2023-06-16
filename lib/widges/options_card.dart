import 'package:flutter/material.dart';
import 'package:quizapp/utils/constants.dart';

class OptionCard extends StatelessWidget{
  const OptionCard({Key? key,required this.option,required this.color}):super(key: key);

  final String option;
  final Color color;
  @override
  Widget build(BuildContext context){
    return Card(
      color: color,
      child: ListTile(
        title: Text(option,style: TextStyle(
          color:  color.red != color.green ? neutral : Colors.black,
          fontSize: 22,
        ),),
      ),
    );
  }
}