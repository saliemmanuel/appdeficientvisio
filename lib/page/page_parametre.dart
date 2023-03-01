import 'package:flutter/material.dart';

class PageParametre extends StatefulWidget {
  const PageParametre({super.key});

  @override
  State<PageParametre> createState() => PageParametreState();
}

class PageParametreState extends State<PageParametre> {
  String title = "Paramètre de l'application ";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: ListView(children: [
        Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                height: 70.0,
                width: 70.0,
                color: Colors.yellow,
                child: const Text("A", style: TextStyle(fontSize: 60.0)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                height: 70.0,
                width: 70.0,
                color: Colors.red,
                child: const Text("A", style: TextStyle(fontSize: 60.0)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                height: 70.0,
                width: 70.0,
                color: Colors.black,
                child: const Text("A",
                    style: TextStyle(fontSize: 60.0, color: Colors.white)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                height: 70.0,
                width: 70.0,
                color: Colors.blue,
                child: const Text("A", style: TextStyle(fontSize: 60.0)),
              ),
            ),
          ],
        )
      ]),
    );
  }
}
