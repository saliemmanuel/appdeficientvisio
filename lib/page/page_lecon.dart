import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/lecon_models.dart';
import '../state_management/provider/home_provider.dart';
import '../widget/lecon_card.dart';

// Interface 2 :
class PageLecon extends StatefulWidget {
  final LeconModels leconModels;
  const PageLecon({super.key, required this.leconModels});

  @override
  State<PageLecon> createState() => _PageLeconState();
}

class _PageLeconState extends State<PageLecon> {
  @override
  void initState() {
    super.initState();
    ftts();
  }

  @override
  Widget build(BuildContext context) {
    String title = widget.leconModels.intitule!;
    return WillPopScope(
      onWillPop: () async {
        Provider.of<HomeProvider>(context, listen: false).stopFtts();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: InkWell(
          onTap: () => ftts(),
          onDoubleTap: () => Navigator.pop(context),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: [
                LeconCard(
                  id: widget.leconModels.id,
                  intitule: widget.leconModels.intitule,
                  competence: widget.leconModels.competence,
                  contenue: widget.leconModels.contenue,
                  resumer: widget.leconModels.resumer,
                  idEnseignant: widget.leconModels.idEnseignant,
                  isTeacherScreen: false,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  ftts() {
    Provider.of<HomeProvider>(context, listen: false).ftts(
        "Cours ${widget.leconModels.intitule}, ${widget.leconModels.competence}, ${widget.leconModels.resumer}, ${widget.leconModels.contenue}. Taper deux fois pour rentrez à la page des leçon ou taper une fois pour je me repète");
  }
}
