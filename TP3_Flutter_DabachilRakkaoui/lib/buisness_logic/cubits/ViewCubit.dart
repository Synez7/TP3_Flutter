import 'package:flutter_bloc/flutter_bloc.dart';

class ViewCubit extends Cubit<String> {
  ViewCubit(String initialState) : super(initialState);

  // Cubit utilisé pour la navigation inter interfaces
  // Home vers Quizz et vice-verse ou Home vers le formulaire d'ajout à une question
  setValue(String value) => emit(value);
}
