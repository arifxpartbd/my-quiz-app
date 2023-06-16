import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  MyTextField({
    super.key, this.lableText, required this.textEditingController,
    this.validator, this.maxLine
  });

  final lableText;
  final validator;
  final maxLine;
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLine,
      controller: textEditingController,
      validator: validator,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: lableText
      ),
    );
  }
}
