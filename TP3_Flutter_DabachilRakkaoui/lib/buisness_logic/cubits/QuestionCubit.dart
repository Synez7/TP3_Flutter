import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/Question.dart';
import 'QuestionState.dart';

class QuestionCubit extends Cubit<QuestionState> {

  late final List<Question> questions;
  final List<Widget> scoreKeeper = [];

  bool _isFinished = false;
  int countClick = 0;
  int _questionNumber = 0;
  int _totalRightAnswers = 0;
  late Question _question;

  QuestionCubit({required this.questions})
      : super(QuestionState(0,
      Question(questionText: questions[0].questionText,
          isCorrect: false,
      thematic: "",
      imagePath: questions[0].imagePath))) {
    _question = questions[_questionNumber];
  }


  List<Question> get _questions => questions;
  bool get isFinished => _isFinished;
  int get questionNumber => _questionNumber;
  int get totalRightAnswers => _totalRightAnswers;
  int get numberQuestions => questions.length;
  Question get question => _question;

  set isFinished(bool number){
    _isFinished = number;
    emit(QuestionState(_questionNumber,_question));
    }



  checkAnswer(bool userChoice, BuildContext context) {
    // Cas d'une réponse correcte choisie par l'utilisateur
    if (questions[_questionNumber].isCorrect == userChoice) {
      _totalRightAnswers = _totalRightAnswers + 1;
      scoreKeeper.add(const Icon(Icons.check, color: Colors.green));
      emit(QuestionState(_questionNumber, _question));

    }
    // Cas contraire
    else {
      scoreKeeper.add(const Icon(Icons.close, color: Colors.red));
      emit(QuestionState(_questionNumber, _question));

    }

  }


  nextQuestion() {
    if (_questionNumber < _questions.length - 1) {
      _questionNumber++;
      _question = _questions[_questionNumber];
      emit(QuestionState(_questionNumber, _question));

    } else {
      isFinished = true;
      emit(QuestionState(_questionNumber, _question));
    }

  }

  reset(){
    _questionNumber = 0;
    _question = _questions[_questionNumber];
    emit(QuestionState(_questionNumber, _question));
    _totalRightAnswers = 0;
    countClick = 0;
    _isFinished = false;
    scoreKeeper.clear();


  }


}