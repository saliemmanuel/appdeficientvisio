import 'package:animate_do/animate_do.dart';
import 'package:appdeficientvisio/page/page_cours.dart';
import 'package:appdeficientvisio/page/page_parametre.dart';
import 'package:appdeficientvisio/widget/widget_route.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  String welcomText =
      "Bonjours bienvenue sur App deficient visio, Nous allons commencer par configurer ensemble l'application.";
  String welcomText2 =
      "Taper en haut à droit pour acceder au parmètre de l'application, taper deux fois pour passer à la page suivante, où taper une fois pour que je me repète";

  @override
  void initState() {
    super.initState();
    ftts();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: const Text('Appdeficientvisio'),
          actions: [
            IconButton(
                onPressed: () {
                  pushNewPage(const PageParametre(), context);
                },
                icon: const Icon(Icons.settings))
          ],
        ),
        body: InkWell(
          onDoubleTap: () => pushNewPage(const CoursScreen(), context),
          onTap: () => ftts(),
          child: ListView(
            children: [
              AvatarGlow(
                animate: true,
                endRadius: 50,
                glowColor: Theme.of(context).primaryColor,
                child: FloatingActionButton(
                  onPressed: ftts,
                  child: const Icon(Icons.record_voice_over_rounded, size: 36),
                ),
              ),
              FadeInUp(
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text.rich(
                    TextSpan(
                        style: TextStyle(fontSize: 18.0),
                        text: "Bonjours",
                        children: [
                          TextSpan(text: " bienvenue sur"),
                          TextSpan(
                              text: " App deficient visuo",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(
                              text:
                                  ", Nous allons commencer par configurer ensemble l'application"),
                        ]),
                  ),
                ),
              ),
              FadeInUp(
                delay: const Duration(seconds: 3),
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      style: const TextStyle(fontSize: 18.0),
                      welcomText2,
                    )),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: ElevatedButton(
                  onPressed: () {
                    pushNewPage(const CoursScreen(), context);
                  },
                  child: const Text("Page suivante")),
            )
          ],
        ),
      );

  ftts() async {
    var flutterTts = FlutterTts();
    flutterTts.stop();
    await flutterTts.setLanguage('fr-FR');
    await flutterTts.setPitch(0.9);
    await flutterTts.speak("$welcomText; $welcomText2");
  }
}
