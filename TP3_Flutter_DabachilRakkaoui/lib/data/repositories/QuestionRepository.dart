import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/Question.dart';

// Repository pour le chargement en mémoire des questions depuis la DB Firebase
class QuestionRepository {
  final _questions = FirebaseFirestore.instance.collection('questions');

  Future<QuerySnapshot> getQuestions() {
    return _questions.get();
  }

  Future<QuerySnapshot> getQuestionsByThematic(String thematic) {
    return _questions.where('thematic', isEqualTo: thematic).get();
  }

  Future<DocumentReference> addQuestion(Map<String, dynamic> question) {
    return _questions.add(question);
  }

}
