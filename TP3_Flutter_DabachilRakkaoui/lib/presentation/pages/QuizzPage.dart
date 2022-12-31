import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


import '../../buisness_logic/cubits/QuestionCubit.dart';
import '../../buisness_logic/cubits/QuestionState.dart';
import '../../data/dataproviders/Imagesprovider.dart';
import '../../data/dataproviders/Questionprovider.dart';
import '../../data/models/Question.dart';

class QuizPage extends StatelessWidget {
  QuizPage({Key? key, required this.thematic}) : super(key: key);

  final String thematic;
  final QuestionProvider _provider = QuestionProvider();
  final ImagesProvider _imagesProvider = ImagesProvider();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _provider.getQuestionsByThematic(thematic),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text('Une erreur est survenue...');
          } else if (snapshot.hasData) {
            return Provider<QuestionCubit>(
              create: (_) =>
                  QuestionCubit(questions: snapshot.data! as List<Question>),
              child: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[

                    ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: BlocBuilder<QuestionCubit, QuestionState>(
                                builder: (context, state) {
                              return FutureBuilder<String>(
                                future: _imagesProvider
                                    .getImage(state.question.imagePath),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {

                                    // Je fais le choix de fixer une image par défaut pour chaque thématique
                                    // pour que ce soit plus simple
                                    // toutes les photos prises pour chacune des questions ont été faites depuis
                                    // l'AVD même s'il y a pas eu de soucis recontrés pour l'affichage
                                    if(state.question.thematic == "Football mondial"){
                                      return Image.asset("images/worldcup.jpg");
                                    }
                                    if(state.question.thematic == "Capitales Geo"){
                                      return Image.network("https://upload.wikimedia.org/wikipedia/commons/thumb/9/90/Saint-Di%C3%A9-des-Vosges-Capitale_mondiale_de_la_g%C3%A9ographie.jpg/1200px-Saint-Di%C3%A9-des-Vosges-Capitale_mondiale_de_la_g%C3%A9ographie.jpg",);
                                    }
                                    if(state.question.thematic == "Alimentation"){
                                      return Image.network("https://img.freepik.com/photos-gratuite/composition-cuisson-par-lots-plat_23-2148765597.jpg?w=2000",);
                                    }

                                    if(state.question.thematic == "Maths"){
                                      return Image.network("https://i0.wp.com/www.cours-ado.com/wp-content/uploads/2021/11/cours-particuliers-maths.jpg?resize=1170%2C1170&ssl=1",);
                                    }

                                    if(state.question.thematic == "Animaux"){
                                      return Image.network("https://www.raccooncontrol.ca/wp-content/uploads/2020/02/can-raccoons-be-beneficial-.webp",);
                                    }

                                    if(state.question.thematic == "Bio et chimie"){
                                      return Image.network("https://img.freepik.com/free-photo/3d-medical-background-with-dna-strands-virus-cells_1048-7586.jpg?w=2000",);
                                    }

                                    return Image.network(snapshot.data!);
                                    //return Image.asset("images/quizzHome.jpeg");

                                  } else {
                                    return Image.asset('images/quizz.jpg');
                                  }
                                },
                              );
                            }),
                          ),
                      Container(
                        width: 300,
                        height: 150,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.white24),
                            borderRadius:
                                const BorderRadius.all(Radius.circular(15))),
                        child: Center(
                          child: BlocBuilder<QuestionCubit, QuestionState>(
                              builder: (context, state) => Text(
                              state.question.questionText,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                                textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            BlocBuilder<QuestionCubit, QuestionState>(
                                builder: (context, container) {
                                return Padding(
                                  padding: EdgeInsets.all(20),
                                  child: ButtonTheme(
                                    minWidth: 60.0,
                                    height: 35.0,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        context.read<QuestionCubit>().countClick++;
                                        if (context.read<QuestionCubit>().countClick == 1) {
                                          context.read<QuestionCubit>().checkAnswer(
                                              true, context);
                                        }
                                      },
                                      child: const Text('VRAI'),
                                    ),
                                  ),
                                );
                              return const SizedBox(width: 0, height: 0);
                            }),
                            BlocBuilder<QuestionCubit, QuestionState>(
                                builder: (context, container) {
                                return Padding(
                                  padding: EdgeInsets.all(20),
                                  child: ButtonTheme(
                                    minWidth: 60.0,
                                    height: 35.0,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        context.read<QuestionCubit>().countClick++;
                                        if (context.read<QuestionCubit>().countClick == 1) {
                                          context.read<QuestionCubit>().checkAnswer(
                                              false, context);
                                        }
                                      },
                                      child: const Text('FAUX'),
                                    ),
                                  ),
                                );

                            }),
                            BlocBuilder<QuestionCubit, QuestionState>(
                                builder: (context, container) {
                                return Padding(
                                  padding: EdgeInsets.all(20),
                                  child: ButtonTheme(
                                    minWidth: 60.0,
                                    height: 35.0,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (context.read<QuestionCubit>().countClick > 0 &&
                                            context.read<QuestionCubit>().questionNumber <
                                                context.read<QuestionCubit>().numberQuestions) {
                                          context.read<QuestionCubit>().countClick = 0;
                                          context.read<QuestionCubit>().nextQuestion();
                                        }

                                        if(context.read<QuestionCubit>().isFinished){

                                          Alert(
                                              context: context,
                                              title: "Fin du quizz",
                                              desc: "Votre score est : ${context.read<QuestionCubit>().totalRightAnswers}/"
                                                  "${context.read<QuestionCubit>().numberQuestions} !",
                                              buttons: [
                                                DialogButton(
                                                    onPressed: () {
                                                      Navigator.pop(
                                                          context);
                                                    },
                                                    child: const Text(
                                                        "Rejouer",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .white,
                                                            fontSize: 22)))]).show();

                                          context.read<QuestionCubit>().reset();

                                        }


                                      },
                                      child: const Icon(Icons.arrow_forward),
                                    ),
                                  ),
                                );

                            }),
                          ]),
                      BlocBuilder<QuestionCubit, QuestionState>(
                          builder: (context, state) {
                            return Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: context.read<QuestionCubit>().scoreKeeper,));
                          })
                    ]),
              ),
            );
          } else {
            return const CircularProgressIndicator(color: Colors.blue,);
          }
        });
  }
}
