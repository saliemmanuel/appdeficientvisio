import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class PageListeCours extends StatefulWidget {
  const PageListeCours({super.key});

  @override
  State<PageListeCours> createState() => _PageListeCoursState();
}

class _PageListeCoursState extends State<PageListeCours> {
  String title = "Liste des cours";
  @override
  void initState() {
    super.initState();
    ftts();
  }

  ftts() async {
    var flutterTts = FlutterTts();
    flutterTts.stop();
    await flutterTts.setLanguage('fr-FR');
    await flutterTts.setPitch(1);
    await flutterTts.speak(title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.settings))
        ],
      ),
    );
  }
}
