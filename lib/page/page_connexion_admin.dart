import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../firebase/auth_firebase.dart';

class PageConnexionAdmin extends StatefulWidget {
  const PageConnexionAdmin({super.key});

  @override
  State<PageConnexionAdmin> createState() => _PageConnexionAdminState();
}

class _PageConnexionAdminState extends State<PageConnexionAdmin> {
  @override
  Widget build(BuildContext context) {
    var email = TextEditingController();
    var mdp = TextEditingController();
    var auth = Auth();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page connexion admin"),
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
                          if (email.text.toString().contains("admin")) {
                            await auth.loginAccount(
                                isAdmin: true,
                                email: email.text,
                                password: mdp.text,
                                context: context);
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text("Accès denied")));
                          }
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
