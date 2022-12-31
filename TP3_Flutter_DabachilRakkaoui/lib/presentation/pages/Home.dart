import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../buisness_logic/cubits/ViewCubit.dart';
import '../../data/dataproviders/Questionprovider.dart';
import '../widgets/DropdownThemes.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  final QuestionProvider _provider = QuestionProvider();

  @override
  Widget build(BuildContext context) {
    return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 70, top: 5,left: 50, right: 50),
                  child: Image.asset("images/quizzHome.jpeg", width: 700,
                    height: 200,
                    fit: BoxFit.fill,),
                ),

                const Text(
                  'Quizz Firebase',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 3,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  'CHOIX DE VOTRE CATÉGORIE :',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                    color: Colors.white,
                  ),
                ),
                FutureBuilder<List<String>>(
                    future: _provider.getThematics(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Une erreur est survenue...');
                      } else if (snapshot.hasData) {
                        return Dropdown(thematics: snapshot.data!);
                      } else {
                        //return const Text('Chargement en cours...');
                        return CircularProgressIndicator(color: Colors.blue,);
                      }
                    }),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<ViewCubit>().setValue('quiz');
                    },
                    child: const Text('LANCER UN QUIZ'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<ViewCubit>().setValue('form');
                  },
                  child: const Text('AJOUTER UNE QUESTION'),
                ),
              ],
    );
  }
}
