import 'dart:ffi';

import '../Widgets/GenisButton.dart';
import '../Widgets/ResimButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

double ustBosluk = 25;
const double ikonSize = 32;

class Giris extends StatefulWidget {
  const Giris({Key? key}) : super(key: key);

  @override
  State<Giris> createState() => _GirisState();
}

class _GirisState extends State<Giris> {
  bool status = false;
  @override
  Widget build(BuildContext context) {
    ustBosluk = MediaQuery.of(context).size.height * 0.045;

    return Stack(
      children: [
        Image(image: AssetImage('resimler/giris.jpeg'),height: MediaQuery.of(context).size.height,),
        SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height-MediaQuery.of(context).padding.top,
                child: Column(

                  children: <Widget>[
                    _uStKisim(),
                    const Expanded(flex: 1, child: SizedBox()),
                    Expanded(
                        flex: 11,
                        child: Row(
                          children: [
                            /** Ekranı dikeylemesine ayrıma boşluk **/
                            const Expanded(flex: 1, child: SizedBox()),
                            /** İçerik kısmı**/
                            Expanded(
                                flex: 3,
                                child: Container(
                                  margin: const EdgeInsets.all(5),
                                  //dış boşluk
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 57, horizontal: 8),
                                  //iç boşluk
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                            MediaQuery.of(context).size.height *
                                                0.20),
                                        topRight: const Radius.circular(10),
                                        bottomRight: const Radius.circular(50)),
                                    //borderRadius: BorderRadius.circular(300),
                                    color: Colors.white.withOpacity(0.25),
                                  ),
                                  //child: Container(color: Colors.red,),
                                  //color: Colors.white.withOpacity(0.25),
                                  child: Column(
                                    children: [
                                      const Expanded(
                                          flex: 2, child: SizedBox()),
                                      /** Soru ve switch **/
                                      Row(
                                        children: [
                                          const Expanded(child: SizedBox()),
                                          const Text(
                                            "Yönetici mi ..?",
                                            style: TextStyle(
                                              fontFamily: 'OpenDyslexic',
                                              fontWeight: FontWeight.bold,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 18,
                                              color: Colors.black,
                                            ),
                                          ),
                                          Switch(
                                              value: status,
                                              onChanged: (value) {
                                                setState(() {
                                                  status = value;
                                                });
                                              }),
                                          const Expanded(child: SizedBox()),
                                        ],
                                      ),
                                      /** TC kimlik bilgisi alanı **/
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            5, 0, 25, 0),
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.9),
                                          borderRadius:
                                          const BorderRadius.horizontal(
                                              left: Radius.circular(45),
                                              right: Radius.circular(45)),
                                        ),
                                        child: Row(
                                          children: [
                                            const Image(
                                              image: AssetImage(
                                                  "resimler/user64.png"),
                                            ),
                                            Expanded(
                                              child: TextFormField(
                                                decoration:
                                                const InputDecoration(
                                                  //icon: Image(image: AssetImage("resimler/user64.png"),),
                                                  labelText: "TC kimlik no:",
                                                ),
                                                keyboardType:
                                                TextInputType.number,
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .digitsOnly
                                                ],
                                                maxLength: 11,
                                                onChanged: _girdi,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Expanded(child: SizedBox()),
                                      /** Giriş butonu **/
                                      GenisButton("Giriş", () {},),
                                      /*Container(
                                            height: MediaQuery.of(context).size.height*0.07,
                                            width: MediaQuery.of(context).size.width*0.70,
                                            decoration: const BoxDecoration(
                                              color: Colors.green,
                                              borderRadius:  BorderRadius.horizontal(
                                                left: Radius.circular(45),
                                                right: Radius.circular(45)
                                              )
                                            ),
                                            child: TextButton(
                                                onPressed: () {},
                                                child: const Text("Giriş",style: TextStyle(color: Colors.white,
                                                fontSize: 14,),)),
                                          ),*/
                                      const Expanded(flex: 2, child: SizedBox())
                                    ],
                                  ),
                                ))
                          ],
                        )),
                    _altKisim()

                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _uStKisim() => Column(children: [
        /*SizedBox(
          height: ustBosluk,
        ),*/
        SizedBox(
          height: ikonSize,
          child: Row(
            children: [
              Expanded(
                child: Container(
                    //color: Colors.red.withOpacity(0.5),
                    ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: ResimButton('resimler/ayarlar_32px.png')), //ayarlar_32px.png'),
            ],
          ),
        )
      ]);

  Widget _altKisim() => Expanded(
          child: Row(
        children: [
          const Expanded(child: SizedBox()),
          ResimButton(
            'resimler/facebook.png',
            onTap: () async {
              await launch("https://tr-tr.facebook.com/bekir.piralp.9");
            },
          ),
          const Expanded(child: SizedBox()),
          ResimButton(
            'resimler/instagram.png',
            onTap: () async {
              await launch("https://www.instagram.com/bekir01piralp/");
            },
          ),
          const Expanded(child: SizedBox()),
          ResimButton(
            'resimler/linkedin.png',
            onTap: () async {
              await launch("https://tr.linkedin.com/in/bekir-piralp-26bbab171");
            },
          ),
          const Expanded(child: SizedBox()),
          ResimButton(
            'resimler/github.png',
            onTap: () async {
              await launch("https://github.com/BekirPiralp");
            },
          ),
          const Expanded(child: SizedBox())
        ],
      ));

  facebook() {
    () async {
      await launch("www.google.com");
    };
  }

  _girdi(deger) {}
}
