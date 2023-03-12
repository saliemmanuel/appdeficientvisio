import 'package:flutter/material.dart';

import '../firebase/auth_firebase.dart';

class PageConnexionEnseignant extends StatefulWidget {
  const PageConnexionEnseignant({super.key});

  @override
  State<PageConnexionEnseignant> createState() =>
      _PageConnexionEnseignantState();
}

class _PageConnexionEnseignantState extends State<PageConnexionEnseignant> {
  @override
  Widget build(BuildContext context) {
    var email = TextEditingController();
    var mdp = TextEditingController();
    var auth = Auth();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page connexion enseignant"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
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
                  obscureText: true,
                  controller: mdp,
                  decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.security),
                      hintText: "Mot de passe",
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
                        if (email.text.isNotEmpty || mdp.text.isNotEmpty) {
                          await auth.loginAccount(
                              isAdmin: false,
                              email: email.text,
                              password: mdp.text,
                              context: context);
                        }
                      },
                      child: const Text("Se connecter")),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
