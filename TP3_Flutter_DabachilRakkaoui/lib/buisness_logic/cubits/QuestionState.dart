import '../../data/models/Question.dart';

class QuestionState{

  final int _index;
  final Question _question;

  QuestionState(this._index,this._question);

  Question get question => _question;
  int get index => _index;


}