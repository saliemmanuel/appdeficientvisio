// ignore_for_file: use_build_context_synchronously

import 'package:appdeficientvisio/firebase/storage_firebase.dart';
import 'package:appdeficientvisio/models/lecon_models.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/user_models.dart';
import '../page/page_accueil.dart';
import '../page/page_accueil_admin.dart';
import '../page/page_accueil_enseignant.dart';
import '../widget/widget_route.dart';

class Auth {
  final FirebaseAuth _firebase = FirebaseAuth.instance;
  final storage = Storage();
  final currentUser = FirebaseAuth.instance.currentUser;
  get firebase => _firebase;

  createAccount({String? email, String? password, required var context}) async {
    try {
      return await _firebase.createUserWithEmailAndPassword(
          email: email!, password: password!);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red, content: Text(e.message!)));
    }
  }

  loginAccount(
      {String? email,
      String? password,
      BuildContext? context,
      required bool isAdmin}) async {
    try {
      dialogue(context: context);
      var response = await _firebase
          .signInWithEmailAndPassword(email: email!, password: password!)
          .then((value) async {
        var user;
        if (value.user != null) {
          print(value.user!.uid);
          var userData = await storage.getUsersData(id: value.user!.uid);
          if (userData != null) {
            Map<String, dynamic>? data = userData.data();
            if (isAdmin) {
              user = Users(
                  id: value.user!.uid,
                  email: data!["email"],
                  matricule: data["matricule"],
                  nomPrenom: data["nomPrenom"],
                  statut: data["statut"]);
              print(user);

              ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text("Connexion éffectué avec succès")));
              pushNewPageRemoveUntil(PageAccueilAdmin(user: user), context);
            } else {
              ScaffoldMessenger.of(context!).showSnackBar(const SnackBar(
                  backgroundColor: Colors.green,
                  content: Text("Connexion éffectué avec succès")));
              user = Users(
                id: value.user!.uid,
                email: data!["email"],
                matricule: data["matricule"],
                nomPrenom: data["nomPrenom"],
                statut: data["statut"],
              );
              print(user);

              pushNewPageRemoveUntil(
                  PageAccueilEnseignant(user: user), context);
            }
          }
        }
      });
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context!);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(backgroundColor: Colors.red, content: Text(e.message!)));
    }
  }

  logout({BuildContext? context}) {
    dialogue(context: context);
    _firebase.signOut().then((value) {
      Navigator.pop(context!);
      pushNewPage(const PageAccueil(), context);
    });
  }

  dialogue({BuildContext? context}) {
    return showDialog(
        barrierDismissible: false,
        context: context!,
        builder: (_) {
          return const Center(child: CircularProgressIndicator.adaptive());
        });
  }
}
