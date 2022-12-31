import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';

class ImageCubit extends Cubit<File?> {
  ImageCubit() : super(null);

  // upload de l'image pour une question ajoutée selon la thématique
  uploadImage(File? image) => emit(image);
}
