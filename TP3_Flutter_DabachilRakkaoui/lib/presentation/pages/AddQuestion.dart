// ignore_for_file: deprecated_member_use

import 'dart:io';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../../buisness_logic/cubits/ImageCubit.dart';
import '../../buisness_logic/cubits/SwitchCubit.dart';
import '../../buisness_logic/cubits/ViewCubit.dart';
import '../../data/dataproviders/Imagesprovider.dart';
import '../../data/dataproviders/Questionprovider.dart';
import '../../data/models/Question.dart';

class FormPage extends StatefulWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  _FormState createState() => _FormState();
}

class _FormState extends State<FormPage> {
  final QuestionProvider _provider = QuestionProvider();
  final ImagesProvider _img_provider = ImagesProvider();
  final TextEditingController _question_controller = TextEditingController();
  final TextEditingController _thematic_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Provider<ImageCubit>(
      create: (context) => ImageCubit(),
      child: BlocBuilder<ImageCubit, File?>(
        builder: (context, image) {
          return Provider<SwitchCubit>(
            create: (context) => SwitchCubit(),
            child: BlocBuilder<SwitchCubit, bool>(builder: (context, value) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'AJOUTEZ VOTRE QUESTION :',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    controller: _question_controller,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: const InputDecoration(
                      hintText: "Saisissez votre question",
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: _thematic_controller,
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                    decoration: const InputDecoration(
                      hintText: "Saisissez une thématique",
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  const Text(
                    'La réponse est vraie ou fausse ?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'FAUX',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Switch(
                        activeColor: Colors.white,
                        value: value,
                        onChanged: (newValue) {
                          context.read<SwitchCubit>().switchValue(newValue);
                        },
                      ),
                      const Text(
                        'VRAI',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _showPicker(context);
                    },
                    child: const Text('AJOUTER UNE IMAGE'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_question_controller.text.isNotEmpty &&
                          _thematic_controller.text.isNotEmpty &&
                          image != null) {
                        String uuid =
                            Uuid().v4() + "." + image.path.split('.').last;
                        Question question = Question(
                            questionText: _question_controller.text,
                            thematic: _thematic_controller.text,
                            isCorrect: value,
                            imagePath: uuid);
                        _img_provider.uploadImage(uuid, image).then((value) =>
                            _provider.addQuestion(question).then((value) {
                              final snackBar = SnackBar(
                                  content:
                                      const Text('La question a été ajoutée !'),
                                  backgroundColor: Colors.green);

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              //context.read<ViewCubit>().setValue('home');
                            }));
                      } else {
                        final snackBar = SnackBar(
                            content: const Text(
                                'Veuillez remplir tous les champs svp'),
                            backgroundColor: Colors.red);

                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: const Text('VALIDER'),
                  ),
                ],
              );
            }),
          );
        },
      ),
    );
  }

  void _imgFromCamera(BuildContext context) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? image = await imagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 100);

    context.read<ImageCubit>().uploadImage(File(image!.path));
    final snackBar = SnackBar(
        content: const Text("L'image a été ajoutée !"),
        backgroundColor: Colors.green.shade900);

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _imgFromGallery(BuildContext context) async {
    ImagePicker imagePicker = ImagePicker();
    XFile? image = await imagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 100);

    context.read<ImageCubit>().uploadImage(File(image!.path));
    final snackBar = SnackBar(
        content: const Text("L'image a été ajoutée !"),
        backgroundColor: Colors.green.shade900);

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void _showPicker(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.photo_library),
                    title: const Text('Galerie'),
                    onTap: () {
                      _imgFromGallery(context);
                      Navigator.of(context).pop();
                    }),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('Caméra'),
                  onTap: () {
                    _imgFromCamera(context);
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        });
  }

  @override
  void dispose() {
    _question_controller.dispose();
    _thematic_controller.dispose();
    super.dispose();
  }
}
