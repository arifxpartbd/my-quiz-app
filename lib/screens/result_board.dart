import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ResultBoardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Results'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('results').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          List<DocumentSnapshot> resultDocs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: resultDocs.length,
            itemBuilder: (context, index) {
              Map<String, dynamic> resultData = resultDocs[index].data()! as Map<String, dynamic>;

              String email = resultData['email'];
              int score = resultData['score'];

              return ListTile(
                subtitle: Text('Email: $email'),
                title: Text('Score: $score'),
                leading: const CircleAvatar(
                  child: Icon(Icons.person),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
