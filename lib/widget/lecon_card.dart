import 'package:appdeficientvisio/firebase/storage_firebase.dart';
import 'package:flutter/material.dart';

import 'custom_text.dart';

class LeconCard extends StatefulWidget {
  final String? id;
  final String? intitule;
  final String? resumer;
  final String? competence;
  final String? contenue;
  final String? idEnseignant;
  final isTeacherScreen;
  const LeconCard(
      {super.key,
      this.intitule,
      required this.id,
      this.resumer,
      this.competence,
      this.contenue,
      required this.idEnseignant,
      required this.isTeacherScreen});

  @override
  State<LeconCard> createState() => _LeconCardState();
}

class _LeconCardState extends State<LeconCard> {
  @override
  Widget build(BuildContext context) {
    var storage = Storage();
    return Card(
      elevation: 10.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          ListTile(
            title: CustomText("Intitulé de la leçon"),
            subtitle: CustomText(widget.intitule!),
            trailing: widget.isTeacherScreen
                ? IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          content:
                              CustomText("Voulez-vous supprimer cette leçon ?"),
                          actions: [
                            OutlinedButton(
                                onPressed: () async {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Annuler")),
                            ElevatedButton(
                                onPressed: () {
                                  storage
                                      .deleteLecon(
                                          id: widget.id, context: context)
                                      .then((value) {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            backgroundColor: Colors.green,
                                            content: Text(
                                                "Leçon supprimée avec succès")));
                                  });
                                },
                                child: const Text("Supprimer"))
                          ],
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ))
                : const SizedBox(),
          ),
          ListTile(
            title: CustomText("Compétence de la leçon"),
            subtitle: CustomText(widget.competence!),
          ),
          ListTile(
              title: CustomText("Resumé de la leçon"),
              subtitle: CustomText(widget.resumer!)),
          ListTile(
            title: CustomText("Contenue de la leçon"),
            subtitle: CustomText(widget.contenue!),
          ),
        ]),
      ),
    );
  }
}
