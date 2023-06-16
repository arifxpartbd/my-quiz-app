import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/quiz_form_model.dart';

class QuizFormScreen extends StatefulWidget {
  const QuizFormScreen({super.key, required this.mainTitle, required this.description, required this.time});

  final String mainTitle, description, time;

  @override
  _QuizFormScreenState createState() => _QuizFormScreenState();
}

class _QuizFormScreenState extends State<QuizFormScreen> {
  TextEditingController questionController = TextEditingController();
  TextEditingController option1Controller = TextEditingController();
  TextEditingController option2Controller = TextEditingController();
  TextEditingController option3Controller = TextEditingController();
  bool option1Checked = false;
  bool option2Checked = false;
  bool option3Checked = false;
  List<Question> questions = [];

  String questionId = DateTime.now().toString();

  void addQuestion() {
    String question = questionController.text.trim();
    if (question.isNotEmpty) {
      Map<String, bool> options = {
        option1Controller.text.trim(): option1Checked,
        option2Controller.text.trim(): option2Checked,
        option3Controller.text.trim(): option3Checked,
      };

      Question newQuestion = Question(
        mainTitle: widget.mainTitle,
        description: widget.description,
        time: widget.time,
        id: 'question${questions.length + 1}',
        //id: questionId,
        title: question,
        options: options,
      );

      setState(() {
        questions.add(newQuestion);
        questionController.clear();
        option1Controller.clear();
        option2Controller.clear();
        option3Controller.clear();
        option1Checked = false;
        option2Checked = false;
        option3Checked = false;
      });
    } else {
      print('Question field is empty');
    }
  }

  Future<void> uploadToFirestore() async {
    try {
      CollectionReference collection =
          FirebaseFirestore.instance.collection('quizzes');

      for (Question question in questions) {
        await collection.doc(question.id).set(question.toMap());
      }

      print('Questions uploaded to Firestore');
      setState(() {
        questions.clear();
      });
    } catch (e) {
      print('Error uploading questions to Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Question Form'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: questionController,
              decoration: const InputDecoration(labelText: 'Question'),
            ),
            const SizedBox(height: 4.0),
            Row(
              children: [
                Checkbox(
                  value: option1Checked,
                  onChanged: (value) {
                    setState(() {
                      option1Checked = value ?? false;
                    });
                  },
                ),
                Expanded(
                  child: TextFormField(
                    controller: option1Controller,
                    decoration: const InputDecoration(labelText: 'Option 1'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4.0),
            Row(
              children: [
                Checkbox(
                  value: option2Checked,
                  onChanged: (value) {
                    setState(() {
                      option2Checked = value ?? false;
                    });
                  },
                ),
                Expanded(
                  child: TextFormField(
                    controller: option2Controller,
                    decoration: const InputDecoration(labelText: 'Option 2'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4.0),
            Row(
              children: [
                Checkbox(
                  value: option3Checked,
                  onChanged: (value) {
                    setState(() {
                      option3Checked = value ?? false;
                    });
                  },
                ),
                Expanded(
                  child: TextFormField(
                    controller: option3Controller,
                    decoration: const InputDecoration(labelText: 'Option 3'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 4.0),
            Row(
              children: [
                ElevatedButton(
                  onPressed: addQuestion,
                  child: const Text('Add Question'),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed:
                  questions.isNotEmpty ? uploadToFirestore : null,
                  child: const Text('Submit'),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            if (questions.isNotEmpty)
              const Text(
                'Added Questions:',
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),

            Expanded(
              child: ListView.builder(
                itemCount: questions.length,
                itemBuilder: (context, index) {
                  Question question = questions[index];
                  return ListTile(
                    title: Text(question.title),
                    subtitle: Text('Options: ${question.options}'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// void main() {
//   runApp(const MaterialApp(
//     title: 'Quiz App',
//     home: QuizFormScreen(),
//   ));
// }
