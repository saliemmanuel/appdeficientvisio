import 'package:appdeficientvisio/page/page_creation_compte_enseignant.dart';
import 'package:appdeficientvisio/widget/widget_route.dart';
import 'package:flutter/material.dart';

import 'page_connexion_enseignant.dart';

class PageEnseignant extends StatelessWidget {
  const PageEnseignant({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page enseignant"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  onPressed: () {
                    pushNewPage(const PageCreationCompteEnseignant(), context);
                  },
                  child: const Text("Créer un compte enseignant")),
              ElevatedButton(
                  onPressed: () {
                    pushNewPage(const PageConnexionEnseignant(), context);
                  },
                  child: const Text("Se connecter à un compte enseignant"))
            ],
          ),
        ),
      ),
    );
  }
}
