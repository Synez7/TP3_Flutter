import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import '../../buisness_logic/cubits/DropdownCubit.dart';
import '../../buisness_logic/cubits/ViewCubit.dart';
import '../pages/AddQuestion.dart';
import '../pages/Home.dart';
import '../pages/QuizzPage.dart';

class Screen extends StatelessWidget {
  const Screen({Key? key, required this.init}) : super(key: key);

  final Future<FirebaseApp> init;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        alignment: Alignment.center,
        child: FutureBuilder(
          future: init,
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Text('Une erreur est survenue...');
            } else if (snapshot.connectionState == ConnectionState.done) {
              return Provider<DropdownCubit>(
                create: (context) => DropdownCubit('Football mondial'),
                child: BlocBuilder<ViewCubit, String>(
                  builder: (context, view) {
                    if (view == 'form') {
                      return const FormPage();
                    } else if (view == 'quiz') {
                      return BlocBuilder<DropdownCubit, String>(
                        builder: (context, value) {
                          return QuizPage(thematic: value);
                        },
                      );
                    }
                    else {
                      return HomePage();
                    }
                  },
                ),
              );
            } else {
              return Text('Chargement en cours...');
            }
          },
        ),
      ),
    );
  }
}
