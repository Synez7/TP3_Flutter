import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

// Repository servant à stocker chaque image uploadée lors de l'ajout d'une question
// Un id UUID est générée automatiquement pour chaque image uploadée
// c'est une sorte d'index pour nous
class ImagesRepository {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Reference getImage(String imagePath) {
    return _storage.ref(imagePath);
  }

  Future<void> uploadImage(String uuid, File image) async {
    await _storage.ref(uuid).putFile(image);
  }
}
