// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:appdeficientvisio/firebase/auth_firebase.dart';
import 'package:appdeficientvisio/firebase/storage_firebase.dart';

import '../models/user_models.dart';

class PageAccueilAdmin extends StatefulWidget {
  final Users user;
  const PageAccueilAdmin({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<PageAccueilAdmin> createState() => _PageAccueilAdminState();
}

class _PageAccueilAdminState extends State<PageAccueilAdmin> {
  var auth = Auth();
  var storage = Storage();
  var data = [];
  @override
  void initState() {
    initData();
    super.initState();
  }

  initData() async {
    data = await storage.getListTeacher();
    setState(() {});
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Page accueil admin"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const UserAccountsDrawerHeader(
                accountName: SizedBox(), accountEmail: SizedBox()),
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
      body: data.isEmpty
          ? const CircularProgressIndicator.adaptive()
          : ListView.builder(
              shrinkWrap: true,
              itemCount: data.isEmpty ? 0 : data.length,
              itemBuilder: (context, index) => Card(
                elevation: 8.0,
                color: data[index]['statut'] == "inactif"
                    ? Colors.red
                    : Colors.green,
                child: ListTile(
                  title: Text(data[index]['email']),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        content: Text(
                            "Statut de l'enseignant actuellement : ${data[index]['statut']} "),
                        actions: [
                          data[index]['statut'] != "inactif"
                              ? ElevatedButton(
                                  onPressed: () async {
                                    var user = Users(
                                        id: data[index]['id'],
                                        email: data[index]['email'],
                                        matricule: data[index]['matricule'],
                                        nomPrenom: data[index]['nomPrenom'],
                                        statut: "inactif");
                                    await storage.updateUserData(
                                      user: user,
                                      context: context,
                                    );
                                    initData();
                                  },
                                  child: const Text("Désactiver"))
                              : ElevatedButton(
                                  onPressed: () async {
                                    var user = Users(
                                        id: data[index]['id'],
                                        email: data[index]['email'],
                                        matricule: data[index]['matricule'],
                                        nomPrenom: data[index]['nomPrenom'],
                                        statut: "actif");
                                    await storage.updateUserData(
                                      user: user,
                                      context: context,
                                    );
                                    initData();
                                  },
                                  child: const Text("Activer")),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
    );
  }
}
