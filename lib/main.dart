import 'package:appdeficientvisio/state_management/provider/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'page/page_accueil.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MultiProvider(
    providers: [ChangeNotifierProvider(create: (context) => HomeProvider())],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  final String title = 'Appdeficientvisio';

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => Consumer<HomeProvider>(
      builder: (context, state, child) => MaterialApp(
            debugShowCheckedModeBanner: false,
            title: title,
            theme: state.themeData,
            home: const HomePage(),
          ));
}
