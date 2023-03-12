import 'package:appdeficientvisio/firebase/auth_firebase.dart';
import 'package:appdeficientvisio/firebase/storage_firebase.dart';
import 'package:flutter/material.dart';

import '../models/user_models.dart';
import '../widget/widget_route.dart';
import '../widget/lecon_card.dart';
import 'page_ajout_lecon.dart';

class PageAccueilEnseignant extends StatefulWidget {
  final Users user;

  const PageAccueilEnseignant({super.key, required this.user});

  @override
  State<PageAccueilEnseignant> createState() => _PageAccueilEnseignantState();
}

class _PageAccueilEnseignantState extends State<PageAccueilEnseignant> {
  var data = [];
  var storage = Storage();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var auth = Auth();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Accueil enseignant"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
                accountName: SizedBox(), accountEmail: SizedBox()),
            widget.user.statut != "actif"
                ? const SizedBox()
                : ListTile(
                    title: const Text("Ajoutez une leçon"),
                    onTap: () {
                      pushNewPage(const PageAjoutLecon(), context);
                    },
                    trailing: const Icon(Icons.login),
                  ),
            ListTile(
              title: const Text("Déconnexion"),
              onTap: () {
                auth.logout(context: context);
              },
              trailing: const Icon(Icons.login),
            ),
          ],
        ),
      ),
      body: widget.user.statut != "actif"
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.red.withOpacity(0.3),
                    child: const Icon(
                      Icons.close,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                      "Votre compte n'est actif contacter un administrateur")
                ],
              ),
            )
          : ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text("Les leçons", style: TextStyle(fontSize: 30.0)),
                ),
                StreamBuilder(
                  stream: storage.firestore.collection("lecon").snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.inbox_outlined),
                              Text('Aucune leçon disponible'),
                            ],
                          ),
                        );
                      } else {
                        return ListView.builder(
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: snapshot.data!.docs.isEmpty
                              ? 0
                              : snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return LeconCard(
                              id: snapshot.data!.docs[index].id,
                              competence: snapshot.data!.docs[index]
                                  ['competence'],
                              contenue: snapshot.data!.docs[index]['contenue'],
                              intitule: snapshot.data!.docs[index]['intitule'],
                              resumer: snapshot.data!.docs[index]['resumer'],
                              idEnseignant: widget.user.id,
                              isTeacherScreen: true,
                            );
                          },
                        );
                      }
                    }
                    return const Center(
                        child: CircularProgressIndicator.adaptive());
                  },
                ),
              ],
            ),
    );
  }
}
