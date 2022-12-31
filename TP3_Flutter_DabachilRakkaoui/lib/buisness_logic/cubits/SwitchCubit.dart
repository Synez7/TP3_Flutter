import 'package:flutter_bloc/flutter_bloc.dart';

class SwitchCubit extends Cubit<bool> {
  SwitchCubit() : super(false);

  // mise à jour de la réponse d'une question ajoutée
  // switch (vers la gauche => false, vers la droite => true)
  switchValue(bool value) => emit(value);
}
