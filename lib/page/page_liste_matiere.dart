import 'package:appdeficientvisio/models/lecon_models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

import '../firebase/storage_firebase.dart';
import '../state_management/provider/home_provider.dart';
import '../widget/custom_text.dart';
import '../widget/widget_route.dart';
import 'page_lecon.dart';
import 'page_parametre.dart';

// interface 3 :
class PageListeMetiere extends StatefulWidget {
  final bool syntheseIsActive;
  const PageListeMetiere({super.key, required this.syntheseIsActive});

  @override
  State<PageListeMetiere> createState() => _PageListeMetiereState();
}

class _PageListeMetiereState extends State<PageListeMetiere> {
  String title = "Liste des matière";
  var data = [];
  var storage = Storage();

  @override
  void initState() {
    Provider.of<HomeProvider>(context, listen: false)
        .setsynthesIsActive(widget.syntheseIsActive);
    Provider.of<HomeProvider>(context, listen: false).ftts(
        "$title, taper deux fois sur l'ecran pour passer d'une matière a l'autre, puis taper une fois pour selectionner.");
    initData();
    super.initState();
  }

  initData() async {
    data = await storage.getListLesson();

    setState(() {});
  }

  int counter = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<HomeProvider>(context, listen: false).stopFtts();
        return true;
      },
      child: Scaffold(
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
          onDoubleTap: () => choixMatiere(),
          onTap: () => pushNewPage(
              PageLecon(
                leconModels: LeconModels(
                    id: data[counter]["id"],
                    intitule: data[counter]["intitule"],
                    competence: data[counter]["competence"],
                    contenue: data[counter]["contenue"],
                    resumer: data[counter]["resumer"],
                    idEnseignant: data[counter]["idEnseignant"]),
              ),
              context),
          child: data.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: data
                      .map((e) => Card(
                            elevation: 12.0,
                            child: ListTile(
                              title: CustomText(e['intitule']!),
                              onTap: () => pushNewPage(
                                  PageLecon(
                                    leconModels: LeconModels(
                                        id: data[counter]["id"],
                                        intitule: data[counter]["intitule"],
                                        competence: data[counter]["competence"],
                                        contenue: data[counter]["contenue"],
                                        resumer: data[counter]["resumer"],
                                        idEnseignant: data[counter]
                                            ["idEnseignant"]),
                                  ),
                                  context),
                            ),
                          ))
                      .toList(),
                ),
        ),
      ),
    );
  }

  choixMatiere() {
    counter++;
    Provider.of<HomeProvider>(context, listen: false)
        .ftts(data[counter]['intitule']!);
    if (counter == data.length) counter = 0;
  }
}
