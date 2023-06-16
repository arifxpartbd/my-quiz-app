import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizapp/utils/constants.dart';
import 'package:quizapp/widges/next_button.dart';
import 'package:quizapp/widges/options_card.dart';
import 'package:quizapp/widges/question_widget.dart';
import 'package:quizapp/widges/result_box.dart';

import '../models/question_model.dart';

class QuizTestPage extends StatefulWidget {
  const QuizTestPage({Key? key}) : super(key: key);

  @override
  State<QuizTestPage> createState() => _QuizTestPageState();
}

class _QuizTestPageState extends State<QuizTestPage> {

  User? currentUser;

  List<Question> _questions = [
    Question(id: "10", title: "Question", options: {"5": false, "6": true}),
  ];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchQuestionsFromFirestore();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      setState(() {
        currentUser = user;
      });
    });
  }

  Future<void> fetchQuestionsFromFirestore() async {

    _isLoading = false;
    setState(() {

    });
    try {
      QuerySnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance.collection('quizzes').get();
      List<Question> fetchedQuestions = snapshot.docs.map((doc) {
        return Question.fromFirestore(doc);
      }).toList();

      setState(() {
        _questions = fetchedQuestions;
        _isLoading = false;
      });
    } catch (e) {
      _isLoading = false;
      setState(() {

      });
      print('Error fetching questions: $e');
    }
  }


  Future<void> saveStudentResult(String email, int score) async {
    try {
      // Access the Firestore collection where you want to save the results
      CollectionReference resultsCollection = FirebaseFirestore.instance.collection('results');

      // Create a new document with a unique ID
      DocumentReference resultDoc = resultsCollection.doc();

      // Set the document data with the student's email and score
      await resultDoc.set({
        'email': email,
        'score': score,
      });

      print('Student result saved successfully!');
    } catch (e) {
      print('Error saving student result: $e');
    }
  }

  int score = 0;
  int index = 0;
  bool isPressed = false;
  bool isAlreadySelected = false;

  void startOver(){
    setState(() {
      index = 0;
      score = 0;
      isPressed = false;
      isAlreadySelected = false;
    });
    Navigator.pop(context);
  }

  void nextQuestion() async{
    if (index == _questions.length -1) {
      //this is the block where the questions end.
      showDialog(
          barrierDismissible: false,
          context: context, builder: (ctx)=>ResultBox(result: score,questionLength: _questions.length,
        startOverButton: startOver,
      submitResult: (){
            saveStudentResult(currentUser?.email.toString()??"", score).then((value){
              return Navigator.pop(context);
            });
      },
      ));
      return;
    } else {
      if (isPressed) {
        setState(() {
          index++;
          isPressed = false;
          isAlreadySelected = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please select any options"),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(vertical: 20),
        ));
      }
    }
  }

  void checkAnswerAndUpdate(bool value){
    if(isAlreadySelected){
      return;
    }else{
      if(value == true){
        score++;
      }
      setState(() {
        isPressed = true;
        isAlreadySelected = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(
        backgroundColor: background,
        title: const Text("Quiz Test Page"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("Score: $score",style: const TextStyle(fontSize: 18, color: Colors.white),),
          )
        ],
      ),
      body: _isLoading?const Center(child: CircularProgressIndicator(),): Container(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        width: double.infinity,
        child: Column(
          children: [
            QuestionWidget(
                questions: _questions[index].title,
                totalQuestions: _questions.length,
                indexAction: index),
            const Divider(
              color: neutral,
              thickness: 2,
            ),
            const SizedBox(
              height: 25,
            ),
            for (int i = 0; i < _questions[index].options.length; i++)
              GestureDetector(
                onTap: () => checkAnswerAndUpdate(_questions[index].options.values.toList()[i]),
                child: OptionCard(
                  option: _questions[index].options.keys.toList()[i],
                  //we neet to check if the anser is correct or not
                  //web need this value

                  color: isPressed
                      ? _questions[index].options.values.toList()[i] == true
                      ? correct
                      : incorrect
                      : neutral,
                ),
              ),
          ],
        ),
      ),

      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: NextButton(
          nextQuestion: nextQuestion,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
