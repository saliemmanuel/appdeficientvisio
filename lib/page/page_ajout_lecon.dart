import 'package:appdeficientvisio/firebase/auth_firebase.dart';
import 'package:appdeficientvisio/firebase/storage_firebase.dart';
import 'package:appdeficientvisio/models/lecon_models.dart';
import 'package:appdeficientvisio/models/user_models.dart';
import 'package:flutter/material.dart';

import '../widget/widget_route.dart';
import 'page_accueil_enseignant.dart';
import 'page_connexion_enseignant.dart';

class PageAjoutLecon extends StatelessWidget {
  const PageAjoutLecon({super.key});

  @override
  Widget build(BuildContext context) {
    var intitule = TextEditingController();
    var competence = TextEditingController();
    var contenue = TextEditingController();
    var resume = TextEditingController();
    var storage = Storage();
    var auth = Auth();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ajout leçon"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: intitule,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      hintText: "Intitulé de la leçon",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: resume,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.mail),
                      hintText: "resumé de la leçon",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: competence,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.code),
                      hintText: "Compétence de la leçon",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  maxLines: 10,
                  controller: contenue,
                  decoration: InputDecoration(
                      hintText: "Conténue de la leçon",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                ),
              ),
              const SizedBox(height: 15.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  ElevatedButton(
                      onPressed: () async {
                        if (intitule.text.isNotEmpty ||
                            resume.text.isNotEmpty ||
                            competence.text.isNotEmpty ||
                            contenue.text.isNotEmpty) {
                          var lecon = LeconModels(
                              id: '',
                              intitule: intitule.text,
                              competence: competence.text,
                              contenue: contenue.text,
                              resumer: resume.text,
                              idEnseignant: auth.currentUser!.uid);

                          storage
                              .saveLessondata(
                                  context: context, leconModels: lecon)
                              .then((value) {
                            Navigator.of(context).pop();
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: Colors.green,
                                    content:
                                        Text("Leçon ajouter avec succès")));
                            intitule.clear();
                            resume.clear();
                            competence.clear();
                            contenue.clear();
                          });
                        }
                      },
                      child: const Text("Ajouter")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
