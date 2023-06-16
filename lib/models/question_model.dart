// class Question {
//   final String id;
//   //every question will have a title, it's question itself
//   final String title;
// //every question have options
//   final Map<String, bool> options;
// //options will be like -{'1':true, 2:false}
//
// //create constructor
//   Question({required this.id, required this.title, required this.options});
//
// //override the toString method to print the question on consol e
//
//   @override
//   String toString() {
//     return 'Question(id: $id, title: $title, options: $options)';
//   }
// }



import 'package:cloud_firestore/cloud_firestore.dart';

class Question {
  final String id;
  final String title;
  final Map<String, bool> options;

  Question({
    required this.id,
    required this.title,
    required this.options,
  });

  factory Question.fromFirestore(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    Map<String, dynamic> data = snapshot.data()!;
    return Question(
      id: snapshot.id,
      title: data['title'],
      options: Map<String, bool>.from(data['options']),
    );
  }
}