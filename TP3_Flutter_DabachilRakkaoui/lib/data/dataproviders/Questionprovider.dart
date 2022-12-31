import '../models/Question.dart';
import '../repositories/QuestionRepository.dart';

class QuestionProvider {
  final QuestionRepository _repository = QuestionRepository();

  // Ensemble des questions de la collection '/questions'
  Future<List<Question>> getQuestions() async {
    return await _repository.getQuestions().then((data) =>
        data.docs.map((value) => Question.fromJson(value.data() as Map<String,dynamic>)).toList());
  }

  // Liste de questions par thématique récupérée
  Future<List<Question>> getQuestionsByThematic(String thematic) async {
    return await _repository.getQuestionsByThematic(thematic).then((data) =>
        data.docs.map((value) => Question.fromJson(value.data() as Map<String,dynamic>)).toList());
  }


  // Liste des thématiques toute question confondue
  Future<List<String>> getThematics() async {
    return await _repository.getQuestions().then((data) => data.docs
        .map((value) => Question.fromJson(value.data() as Map<String,dynamic>).thematic)
        .toList()
        .toSet()
        .toList());
  }

  // Ajout d'une question servant au formulaire (Fichier: AddQuestion.dart)
  Future<void> addQuestion(Question question) async {
    await _repository.addQuestion(question.toJson());
  }


}
