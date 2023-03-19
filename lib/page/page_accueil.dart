import 'package:animate_do/animate_do.dart';
import 'package:appdeficientvisio/firebase/auth_firebase.dart';
import 'package:appdeficientvisio/page/page_parametre.dart';
import 'package:appdeficientvisio/widget/widget_route.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state_management/provider/home_provider.dart';
import '../widget/custom_text.dart';
import 'page_configuration.dart';
import 'page_connexion_admin.dart';
import 'page_enseignant.dart';

// première interface, la page d'accueil qui permet de
// dire le mot de bienvenue dans l'application
class PageAccueil extends StatefulWidget {
  const PageAccueil({super.key});

  @override
  PageAccueilState createState() => PageAccueilState();
}

class PageAccueilState extends State<PageAccueil> {
  String welcomText = "Bienvenue sur App deficient visio";
  String welcomText2 =
      "Taper en haut à droit pour acceder au parmètre de l'application taper deux fois pour passer à la page suivante où taper une fois pour que je me repète";

  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false)
        .ftts("$welcomText; $welcomText2");
  }

  String title = 'AppDeficientVisuo';
  var auth = Auth();

  @override
  Widget build(BuildContext context) => Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              const UserAccountsDrawerHeader(
                  accountName: SizedBox(), accountEmail: SizedBox()),
              ListTile(
                title: const Text("Enseignant"),
                onTap: () {
                  pushNewPage(const PageEnseignant(), context);
                },
                trailing: const Icon(Icons.login),
              ),
              ListTile(
                title: const Text("Admin"),
                onTap: () {
                  pushNewPage(const PageConnexionAdmin(), context);
                },
                trailing: const Icon(Icons.login),
              )
            ],
          ),
        ),
        appBar: AppBar(
          title: CustomText(title),
          actions: [
            IconButton(
                onPressed: () {
                  pushNewPage(const PageParametre(), context);
                },
                icon: const Icon(Icons.settings))
          ],
        ),
        body: InkWell(
          onDoubleTap: () => pushNewPage(const PageConfiguration(), context),
          onTap: () => Provider.of<HomeProvider>(context, listen: false)
              .ftts("$welcomText; $welcomText2"),
          child: ListView(
            children: [
              AvatarGlow(
                animate: true,
                endRadius: 50,
                glowColor: Theme.of(context).primaryColor,
                child: FloatingActionButton(
                  onPressed: () =>
                      Provider.of<HomeProvider>(context, listen: false)
                          .ftts("$welcomText; $welcomText2"),
                  child: const Icon(Icons.record_voice_over_rounded, size: 36),
                ),
              ),
              FadeInUp(
                child: const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text.rich(
                    TextSpan(
                        style: TextStyle(fontSize: 36.0),
                        text: "Bienvenue sur",
                        children: [
                          TextSpan(
                              text: " App Deficient Visuo",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ]),
                  ),
                ),
              ),
              FadeInUp(
                delay: const Duration(seconds: 3),
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      style: const TextStyle(fontSize: 18.0),
                      welcomText2,
                    )),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const SizedBox(),
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: ElevatedButton(
                  onPressed: () {
                    pushNewPage(const PageConfiguration(), context);
                  },
                  child: CustomText("Page suivante")),
            )
          ],
        ),
      );
}
