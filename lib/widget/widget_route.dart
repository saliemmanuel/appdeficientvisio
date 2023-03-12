import 'package:flutter/material.dart';

// methode pour la navigation entre pages
pushNewPage(Widget page, BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) {
    return page;
  }));
}

// methode pour la navigation entre pages
pushNewPageRemoveUntil(Widget page, BuildContext context) {
  Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (BuildContext context) {
    return page;
  }), (Route route) => false);
}
