import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state_management/provider/home_provider.dart';
import '../widget/custom_text.dart';
import '../widget/widget_route.dart';
import 'page_liste_matiere.dart';
import 'page_parametre.dart';

class PageConfiguration extends StatefulWidget {
  const PageConfiguration({super.key});

  @override
  State<PageConfiguration> createState() => _PageConfigurationState();
}

class _PageConfigurationState extends State<PageConfiguration> {
  String title = 'Configuration AppDeficientVisuo';
  String choix =
      "Taper une fois sur l'écran pour continuer avec la synthèse vocale, ou taper deux fois pour continuer sans la synthèse vocale.";
  @override
  void initState() {
    super.initState();
    Provider.of<HomeProvider>(context, listen: false).ftts(choix);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Provider.of<HomeProvider>(context, listen: false).stopFtts();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: [
            IconButton(
                onPressed: () {
                  pushNewPage(const PageParametre(), context);
                },
                icon: const Icon(Icons.settings))
          ],
        ),
        body: InkWell(
          onDoubleTap: () => pushNewPage(
              const PageListeMetiere(syntheseIsActive: false), context),
          onTap: () => pushNewPage(
              const PageListeMetiere(syntheseIsActive: true), context),
          child: ListView(
            children: [
              Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            height: 250.0,
                            color: Colors.amber,
                          ),
                          const SizedBox(height: 10.0),
                          CustomText("Vocal")
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            height: 250.0,
                            color: Colors.red,
                          ),
                          const SizedBox(height: 10.0),
                          CustomText("Texte")
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomText(choix, textAlign: TextAlign.center),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
