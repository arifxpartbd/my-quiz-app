import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  MyTextField({
    super.key, this.lableText, required this.textEditingController,
    this.validator,
  });

  final lableText;
  final validator;
  TextEditingController textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      validator: validator,
      decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: lableText
      ),
    );
  }
}
