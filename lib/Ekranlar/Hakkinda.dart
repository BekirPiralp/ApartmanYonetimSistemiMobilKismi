import 'package:flutter/material.dart';

class Hakkinda extends StatefulWidget {
  const Hakkinda({Key? key}) : super(key: key);

  @override
  State<Hakkinda> createState() => _HakkindaState();
}

class _HakkindaState extends State<Hakkinda> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
        appBar: AppBar(
          actions: [
            Container(
              color: Colors.grey,
              width: 64,
              height: 64,
            )
          ],
          leading: Container(
            color: Colors.amberAccent,
            width: 64,
            height: 64,
            child: ElevatedButton(
              onPressed: () => {},
              child: Icon(
                Icons.west,
                color: Colors.red,
              ),
            ),
          ),
          title: Text("H A K K I N D A"),
          centerTitle: true,
        ),
        body: Center(
            child: Container(
              color: Color(0xFFC9E3C6), //3BFF4FBF
              child: Expanded(
                  //flex:2,
                  child: Center(child: Column(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                            "Selçuk Üniversitesi'nin Bilgisayar Mühendisliği Bölümün de vermiş oldukları Staj 1 Dersi kapsamında yapılmıştır."),
                      ),
                    ],
                  ))),
            )
        ),
      ),
    );
  }
}
