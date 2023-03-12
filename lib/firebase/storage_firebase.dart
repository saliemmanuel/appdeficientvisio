import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../models/lecon_models.dart';
import '../models/user_models.dart';

class Storage {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  FirebaseFirestore get firestore => _firestore;

  saveUserdata({Users? user, BuildContext? context}) async {
    dialogue(context: context);
    try {
      return _firestore.collection("users").doc(user!.id).set(user.toMap());
    } catch (e) {
      print(e);
    }
  }

  getUsersData({String? id}) async {
    try {
      var collection = _firestore.collection('users');
      var docSnapshot = await collection.doc(id).get();
      if (docSnapshot.exists) {
        return docSnapshot;
      }
    } catch (e) {}
  }

  dialogue({required BuildContext? context}) {
    return showDialog(
        barrierDismissible: false,
        context: context!,
        builder: (_) {
          return const Center(child: CircularProgressIndicator.adaptive());
        });
  }

  getListTeacher() async {
    var response = await _firestore.collection("users").get();
    var listUser = [];
    for (var element in response.docs) {
      if (!element.data()['email'].toString().contains("admin")) {
        listUser.add(element.data());
      }
    }
    return listUser;
  }

  updateUserData({Users? user, required BuildContext? context}) {
    dialogue(context: context);
    try {
      _firestore
          .collection('users')
          .doc(user!.id)
          .update(user.toMap())
          .then((value) {
        Navigator.pop(context!);
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.green,
            content: Text("Modification effectué avec succès")));
      });
    } catch (e) {
      ScaffoldMessenger.of(context!).showSnackBar(
          SnackBar(backgroundColor: Colors.red, content: Text(e.toString())));
    }
  }

  saveLessondata({LeconModels? leconModels, BuildContext? context}) async {
    dialogue(context: context);
    try {
      return _firestore.collection("lecon").add(leconModels!.toMap());
    } catch (e) {
      print(e);
    }
  }

  getListLesson() async {
    var response = await _firestore.collection("lecon").get();
    var listLesson = [];
    print("object");
    for (var element in response.docs) {
      listLesson.add({
        "id": element.id,
        "competence": element.data()['competence'],
        "contenue": element.data()['contenue'],
        "idEnseignant": element.data()['idEnseignant'],
        "intitule": element.data()['intitule'],
        "resumer": element.data()['resumer']
      });
    }
    print(listLesson);

    return listLesson;
  }

  deleteLecon({var id, BuildContext? context}) {
    dialogue(context: context);
    print(id);
    return _firestore.collection('lecon').doc(id).delete();
  }
}
