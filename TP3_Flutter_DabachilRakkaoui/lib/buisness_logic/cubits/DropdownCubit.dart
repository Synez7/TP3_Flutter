import 'package:flutter_bloc/flutter_bloc.dart';

class DropdownCubit extends Cubit<String> {
  DropdownCubit(String initialState) : super(initialState);

  // Mise à jour du Dropdown lors du choix de la thématique fait
  // par l'utilisateur
  setValue(String value) => emit(value);
}
