// ignore_for_file: use_build_context_synchronously

import 'package:appdeficientvisio/firebase/auth_firebase.dart';
import 'package:appdeficientvisio/firebase/storage_firebase.dart';
import 'package:appdeficientvisio/models/user_models.dart';
import 'package:flutter/material.dart';

import '../widget/widget_route.dart';
import 'page_accueil_enseignant.dart';
import 'page_connexion_enseignant.dart';

class PageCreationCompteEnseignant extends StatelessWidget {
  const PageCreationCompteEnseignant({super.key});

  @override
  Widget build(BuildContext context) {
    var nomPrenom = TextEditingController();
    var email = TextEditingController();
    var matricule = TextEditingController();
    var mdp = TextEditingController();
    var cmdp = TextEditingController();
    var storage = Storage();
    var auth = Auth();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Création compte enseignant"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: nomPrenom,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      hintText: "Nom et prenom",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.mail),
                      hintText: "E-mail",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: matricule,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.code),
                      hintText: "Matricule",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  obscureText: true,
                  controller: mdp,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.security),
                      hintText: "Mot de passe",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  obscureText: true,
                  controller: cmdp,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.security),
                      hintText: "confirmer le mot de passe",
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
                        if (email.text.isNotEmpty ||
                            nomPrenom.text.isNotEmpty ||
                            cmdp.text.isNotEmpty ||
                            matricule.text.isNotEmpty) {
                          var response = await auth.createAccount(
                              email: email.text,
                              password: cmdp.text,
                              context: context);
                          if (response != null) {
                            var user = Users(
                                id: response.user.uid,
                                nomPrenom: nomPrenom.text,
                                email: email.text,
                                matricule: matricule.text,
                                statut: "inactif");
                            await storage
                                .saveUserdata(user: user, context: context)
                                .then((value) {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      backgroundColor: Colors.green,
                                      content:
                                          Text("Compte créer avec succès")));
                              pushNewPageRemoveUntil(
                                  const PageConnexionEnseignant(), context);
                            });
                          }
                        }
                      },
                      child: const Text("Enregistrer")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
