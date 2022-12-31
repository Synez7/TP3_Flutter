// ignore_for_file: file_names

class Question {
  late String questionText;
  late bool isCorrect;
  late String thematic;
  late String imagePath;

  Question(
      {required this.questionText,
      required this.isCorrect,
      required this.thematic,
      required this.imagePath});

  // Extraction de données json récupérées depuis la DB Firebase
  Question.fromJson(Map<String, dynamic> json) {
    questionText = json['questionText'] ?? '';
    isCorrect = json['isCorrect'] ?? true;
    thematic = json['thematic'] ?? '';
    imagePath = json['imagePath'] ?? '';
  }

  Map<String, dynamic> toJson() {
    return {
      'questionText': questionText,
      'isCorrect': isCorrect,
      'thematic': thematic,
      'imagePath': imagePath,
    };
  }
}
