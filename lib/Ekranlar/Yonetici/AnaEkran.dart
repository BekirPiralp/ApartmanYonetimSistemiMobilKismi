import 'package:flutter/material.dart';

class AnaEkran extends StatefulWidget {
  const AnaEkran({Key? key}) : super(key: key);

  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  @override
  Widget build(BuildContext context) {
    var Size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: SizedBox(
          height: Size.height,
          width: Size.width,
          child: Container(
            child: Column(
              children: [
                UstKisim(),
                Govde(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class UstKisim extends StatefulWidget {
  const UstKisim({Key? key}) : super(key: key);

  @override
  State<UstKisim> createState() => _UstKisimState();
}

class _UstKisimState extends State<UstKisim> {
  @override
  Widget build(BuildContext context) {
    final EdgeInsets _padding = MediaQuery.of(context).padding;
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(
          height: _padding.top,
        ),
        SizedBox(
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: Container(
                    margin: EdgeInsets.only(right: _size.width * 0.05),
                    padding: EdgeInsets.only(right: _size.width * 0.05),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            bottomRight: Radius.circular(40))),
                    child: const Center(
                      child: Text(
                        "Yönetici",
                        style: TextStyle(
                            fontFamily: "OpenDyslexicMono",
                            fontSize: 30,
                            fontStyle: FontStyle.italic),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                //color: Colors.white,
                child: PopupMenuButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 40,
                    ),
                    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                          PopupMenuItem(
                            child: PopupMenuButton(
                              itemBuilder: (BuildContext context) => [
                                const PopupMenuItem(child: Text("Deneme")),
                              ],
                            ),
                          ),
                          const PopupMenuItem(child: Text("Deneme")),
                          const PopupMenuItem(child: Text("Deneme2")),
                          const PopupMenuItem(child: Text("Deneme3")),
                          const PopupMenuItem(child: Text("Deneme"))
                        ]),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class Govde extends StatefulWidget {
  const Govde({Key? key}) : super(key: key);

  @override
  State<Govde> createState() => _GovdeState();
}

class _GovdeState extends State<Govde> {
  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          SizedBox(
            height: 40,
            child: Container(
              color: Color(0xffffd700),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Aidat:",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                      child: Container(
                        child: Center(
                            child: Text(
                              "112.25 TL",
                              style: TextStyle(color: Colors.white, fontSize: 30),
                            )
                        ),
                      )
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned(left:_size.width*0.33,top: _size.height*0.035,child: Text("Borçlu Daire Sakinleri",style: TextStyle(fontSize: 22,color: Colors.white,fontFamily: "OpenDyslexic"),)),
                Container(
                  margin: const EdgeInsets.only(left: 40, top: 20),
                  padding: const EdgeInsets.only(left: 40, top: 40),
                  decoration: BoxDecoration(
                    //color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(_size.width * 0.35)),
                      border: Border.all(color: Colors.greenAccent, width: 2)),
                  child: Center(
                    child: Column(
                      children: [

                        Expanded(child: Container(color: Colors.red,))
                      ],
                    ),
                  ),
                ),
              ]
            ),
          ),
        ],
      ),
    );
  }
}
