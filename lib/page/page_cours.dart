import 'package:appdeficientvisio/page/page_liste_cours.dart';
import 'package:appdeficientvisio/widget/widget_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_tts/flutter_tts.dart';

class CoursScreen extends StatefulWidget {
  const CoursScreen({super.key});

  @override
  State<CoursScreen> createState() => _CoursScreenState();
}

class _CoursScreenState extends State<CoursScreen> {
  String title = "Informatique";
  String competence = "Compétence attendu définir Informatique";
  String resumer =
      "Résumer : L'informatique est la science du traitement automatique";
  String contenue =
      "Contenue : L'information est la science du traitement automatique et rationnel de l'information, l'outil utitliser est l'ordinateur";
  String exercice = "Exercice : Définir l'informatique";

  @override
  void initState() {
    super.initState();
    ftts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: InkWell(
        onTap: () {
          ftts();
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Card(
                color: Colors.blue,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 30.0),
                  child: ListTile(
                    title: const Text("Compétence"),
                    subtitle: Text(
                      competence,
                      style: const TextStyle(color: Colors.white),
                    ),
                    onTap: () {
                      pushNewPage(const PageListeCours(), context);
                    },
                  ),
                ),
              ),
              Card(
                color: Colors.yellow,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 30.0),
                  child: ListTile(
                    title: const Text("Résumer"),
                    subtitle: Text(resumer),
                  ),
                ),
              ),
              Card(
                color: Colors.green,
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10, right: 10, bottom: 30.0),
                  child: ListTile(
                    title: const Text("Contenue"),
                    subtitle: Text(
                      contenue,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 10, right: 10, bottom: 30.0),
                child: Card(
                  color: Colors.red,
                  child: ListTile(
                    title: const Text("Exercice"),
                    subtitle: Text(exercice),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ftts() async {
    var flutterTts = FlutterTts();
    flutterTts.stop();
    await flutterTts.setLanguage('fr-FR');
    await flutterTts.setPitch(0.9);
    flutterTts
        .speak(
            "Cours $title, $competence, $resumer; $contenue, $exercice. Taper deux fois pour passer à la leçon suivante ou taper une fois pour je me repète")
        .asStream();
  }
}
