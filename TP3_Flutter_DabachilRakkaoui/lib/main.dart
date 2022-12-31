import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'buisness_logic/cubits/ViewCubit.dart';
import 'presentation/screens/Screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _init = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return Provider<ViewCubit>(
      create: (context) => ViewCubit('home'),
      child: BlocBuilder<ViewCubit, String>(builder: (context, view) {
        return MaterialApp(
          title: 'Questions/Réponses',
          theme: ThemeData(
            primarySwatch: Colors.deepPurple,
          ),
          home: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text('Questions/Réponses'),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  context.read<ViewCubit>().setValue('home');
                },
              ),
            ),
            backgroundColor: Color(0xff64517c),
            body: Screen(init: _init),
          ),
          debugShowCheckedModeBanner:false,
        );
      }),
    );
  }
}
