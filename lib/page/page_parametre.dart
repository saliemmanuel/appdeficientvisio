import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../state_management/provider/home_provider.dart';
import '../widget/custom_text.dart';

// interface 4 :
class PageParametre extends StatefulWidget {
  const PageParametre({super.key});

  @override
  State<PageParametre> createState() => PageParametreState();
}

class PageParametreState extends State<PageParametre> {
  String title = "Paramètre de l'application ";
  double v = 19;

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
        ),
        body: ListView(children: [
          Wrap(
            children: [
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    height: 70.0,
                    width: 70.0,
                    color: Colors.yellow,
                    child: const Text("A", style: TextStyle(fontSize: 60.0)),
                  ),
                ),
                onTap: () {
                  Provider.of<HomeProvider>(context, listen: false)
                      .changeTheme(ThemeData(
                    primarySwatch: Colors.yellow,
                    scaffoldBackgroundColor: Colors.yellow.shade50,
                  ));
                },
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    height: 70.0,
                    width: 70.0,
                    color: Colors.red,
                    child: const Text("A", style: TextStyle(fontSize: 60.0)),
                  ),
                ),
                onTap: () {
                  Provider.of<HomeProvider>(context, listen: false)
                      .changeTheme(ThemeData(
                    primarySwatch: Colors.red,
                    scaffoldBackgroundColor: Colors.red.shade50,
                  ));
                },
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    height: 70.0,
                    width: 70.0,
                    color: Colors.blue,
                    child: const Text("A", style: TextStyle(fontSize: 60.0)),
                  ),
                ),
                onTap: () {
                  Provider.of<HomeProvider>(context, listen: false)
                      .changeTheme(ThemeData(
                    primarySwatch: Colors.blue,
                    scaffoldBackgroundColor: Colors.blue.shade50,
                  ));
                },
              ),
              InkWell(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    height: 70.0,
                    width: 70.0,
                    color: Colors.purple,
                    child: const Text("A", style: TextStyle(fontSize: 60.0)),
                  ),
                ),
                onTap: () {
                  Provider.of<HomeProvider>(context, listen: false)
                      .changeTheme(ThemeData(
                    primarySwatch: Colors.purple,
                  ));
                },
              ),
            ],
          ),
          const Divider(thickness: 8.0),
          CustomText("AppDeficientVisuo AppDeficientVisuo AppDeficientVisuo "),
          Slider.adaptive(
              max: 50.0,
              min: 18.0,
              divisions: 10,
              value: v.toDouble(),
              onChanged: (onChanged) {
                v = onChanged;
                Provider.of<HomeProvider>(context, listen: false)
                    .setTextStyle(fontSize: onChanged);
                setState(() {});
              }),
          const Divider(thickness: 8.0),
          // SwitchListTile(value: value, onChanged: onChanged),
          const Divider(thickness: 8.0),
        ]),
      ),
    );
  }
}
