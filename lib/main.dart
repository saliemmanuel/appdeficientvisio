import 'package:appdeficientvisio/state_management/provider/home_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'page/page_accueil.dart';

Future main() async {
  // initialisation du projet
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // initialisation de l'orientation de l'ecran de l'application
  // qui restera toujours en protrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // la methode runApp pour executer l'application
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => HomeProvider())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // initialisation du nom de l'application
  final String title = 'AppDeficientVisio';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => Consumer<HomeProvider>(
      builder: (context, state, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: title,
            theme: state.themeData,
            // Appel de la page PageAccueil
            home: const PageAccueil(),
          ));
}
