import 'dart:io';

import 'package:apartman_yonetim_sistemi/Ekranlar/DaireSakini/Enums.dart';
import 'package:apartman_yonetim_sistemi/Ekranlar/GiderTipleri.dart';
import 'package:apartman_yonetim_sistemi/EntityLayer/Concrete/Aidat.dart';
import 'package:apartman_yonetim_sistemi/EntityLayer/Concrete/DaireSakini.dart';
import 'package:apartman_yonetim_sistemi/GirenPersonel.dart';
import 'package:apartman_yonetim_sistemi/Servisler/BorcServis.dart';
import 'package:apartman_yonetim_sistemi/Servisler/GiderlerServis.dart';
import 'package:apartman_yonetim_sistemi/Servisler/TahakkukServis.dart';
import 'package:apartman_yonetim_sistemi/Widgets/IconGenisButton.dart';
import 'package:apartman_yonetim_sistemi/Widgets/Tamalandi.dart';
import 'package:apartman_yonetim_sistemi/Widgets/Yukleniyor.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../../EntityLayer/Concrete/Gider.dart';
import '../../EntityLayer/Concrete/GiderTip.dart';

class AnaEkran extends StatefulWidget {
  const AnaEkran({Key? key}) : super(key: key);

  @override
  State<AnaEkran> createState() => _AnaEkranState();
}

class _AnaEkranState extends State<AnaEkran> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        setState(() {
        showDialog(context: context, builder: (context){
          return Dialog(
            backgroundColor: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(color: Colors.white,borderRadius: BorderRadius.all(Radius.circular(30))),
              width: 200,
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Center(child: Text("Çıkmak istediğinize eminmisiniz?",
                    style: TextStyle(fontSize: 20), textAlign: TextAlign.center,)),
                  Container(
                    height: 50,
                    child: Row(
                      children: [
                        Expanded(
                          child: IconGenisButton(
                            "resimler/cancel.png",
                            color: Colors.grey.shade300,
                            text: Text(
                              "Hayır",
                              style: TextStyle(fontSize: 20),
                            ),
                            onPress: () {
                              setState(() {
                                Navigator.of(context).pop();
                              });
                            },
                          ),
                        ),
                        Expanded(
                          child: IconGenisButton(
                            "resimler/tamam.png",
                            text: const Text(
                              "Evet",
                              style: TextStyle(fontSize: 20),
                            ),
                            color: Colors.grey.shade300,
                            onPress: () {
                              setState(() {
                                Navigator.of(context).pop();
                                GirenPersonel.temizle();
                                Navigator.of(context).pushNamed("/");
                              });
                            },
                          ),
                        ),
                      ],
                    ),),
                ],
              ),
            ),
          );
        });
        });
        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Center(
                child: Column(
                  children: [
                    UstKisim(),
                    Govde(),
                    AltKisim(),
                  ],
                ),
              ),
            ),
          )),
    );
  }
}

class UstKisim extends StatelessWidget {
  const UstKisim({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).padding.top,
        ),
        SizedBox(
          height: 60,
          width: Size.infinite.width,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(40)),
            ),
            padding: EdgeInsets.fromLTRB(10, 1, 10, 1),
            child: /*Container(color: Colors.green,),*/
                Row(
              children: [
                Expanded(
                    child: Center(
                        child: Text(
                  "Daire Sakini",
                  style: TextStyle(
                    fontSize: 26,
                    fontFamily: "OpenDyslexicMono",
                  ),
                ))),
                /*Image(
              image: AssetImage(""), //duruma göre değişecek
            ),*/
                /*IconButton(onPressed: (){}, icon: Icon(Icons.zoom_out,color: Colors.blue,size: 32,)),*/
                // açılır menü amblemi
                PopupMenuButton(
                    icon: Icon(Icons.more_vert),
                    itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                          //PopupMenuItem(child: Text("deneme")),
                          PopupMenuItem(
                            child: ListTile(
                              leading: Icon(Icons.info_outline),
                              title: Text(
                                "Hakkında",
                                style: TextStyle(
                                    fontFamily: "OpenDyslexic", fontSize: 20),
                              ),
                              onTap: ()=>Navigator.of(context).pushNamed('/hakinda'),
                            ),
                          ),
                          PopupMenuItem(
                        child: ListTile(
                          leading: Icon(Icons.exit_to_app,color: Colors.red,),
                          title: Text(
                            "Çıkış",
                            style: TextStyle(
                                fontFamily: "OpenDyslexic", fontSize: 20),
                          ),
                          onTap: (){
                            GirenPersonel.temizle();
                            Navigator.of(context).pushNamed('/');
                          },
                        ),
                      )
                        ]),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Govde extends StatefulWidget {
  Govde({Key? key}) : super(key: key);

  @override
  State<Govde> createState() => _Govde();
}

List<Gider>? _giderler;
Aidat? _aidat;
DaireSakini? _daireSakini;
int _apartman = 0;
Decimal? _borc;
List<GiderTip>? _giderTipleri;

GiderDonem _donem = GiderDonem.donem;

class _Govde extends State<Govde> {
  _Govde() : super() {
    _daireSakini = GirenPersonel.getDaireSakini();
    _apartman = GirenPersonel.getDaireSakini()?.ApartmanGet() ?? 0;
  }

  @override
  void initState() {
    _giderTipleri = GiderTipleri.getir;
    DateTime zaman = DateTime.now();

    super.initState();

    // setState içi olacak
    setState(() {
      TahakkukServisi()
          .AidatGetir(_apartman)
          .then((value) {setState(() {
            _aidat = value;
          });
          })
          .catchError((hata) {
        setState(() {
          if (hata.runtimeType == SocketException)
            showDialog(
                context: context,
                builder: (context) => HataOlustu(
                    messaj:
                        "<-Aidat bilgisi->\n\nLütfen internet bağlantınız kontrol ediniz. Detay:\n${hata.toString()}"));
          else
            showDialog(
                context: context,
                builder: (context) => HataOlustu(
                    messaj:
                        "Aidat bilgisi getirilirken hata oluştu. Detay:\n${hata.toString()}"));
        });
      });
      BorcServis()
          .BorcToplam(_apartman, _daireSakini?.SNoGet() ?? 0)
          .then((value) { setState(() {
            _borc = value;
          });
          })
          .catchError((hata) {
        setState(() {
          if (hata.runtimeType == SocketException)
            showDialog(
                context: context,
                builder: (context) => HataOlustu(
                    messaj:
                        "<-Borç bilgisi->\n\nLütfen internet bağlantınız kontrol ediniz. Detay:\n${hata.toString()}"));
          else
            showDialog(
                context: context,
                builder: (context) => HataOlustu(
                    messaj:
                        "Borç bilgisi getirilirken hata oluştu. Detay:\n${hata.toString()}"));
        });
      });

      GiderlerServis()
          .GiderGetirDonem(_apartman, zaman.month, zaman.year)
          .then((value) {setState(() {
            _giderler = value;
          });})
          .catchError((hata) {
        setState(() {
          if (hata.runtimeType == SocketException)
            showDialog(
                context: context,
                builder: (context) => HataOlustu(
                    messaj:
                        "<-Giderler bilgisi->\n\nLütfen internet bağlantınız kontrol ediniz. Detay:\n${hata.toString()}"));
          else
            showDialog(
                context: context,
                builder: (context) => HataOlustu(
                    messaj:
                        "Giderler bilgisi getirilirken hata oluştu. Detay:\n${hata.toString()}"));
        });
      });
    });
  }

  void yuklen() {
    setState(() {
      showDialog(context: context, builder: (context) => Yukleniyor());
    });
  }

  void geri() {
    setState(() {
      Navigator.of(context).pop();
    });
  }

  void giderDonem() {
    setState(() {
      yuklen();
      GiderlerServis()
          .GiderGetirDonem(_apartman, DateTime.now().month, DateTime.now().year)
          .then((value) => setState(() {
                geri();
                _giderler = value;
                if (value != null && value.isEmpty) {
                  _giderler = null;
                } else
                  _giderler = value;
              }))
          .catchError((hata) {
        setState(() {
          geri();
          if (hata.runtimeType == SocketException) {
            showDialog(
                context: context,
                builder: (context) => HataOlustu(
                      messaj: "Lütfen internet bağlantınızı kontrol ediniz.",
                    ));
          } else {
            showDialog(
                context: context,
                builder: (context) => HataOlustu(
                      messaj: "Giderler getirilirken hata oluştu. Detay:\n" +
                          hata.toString(),
                    ));
          }
        });
      });
    });
  }

  void giderTumDonem() {
    setState(() {
      yuklen();
      GiderlerServis()
          .GiderGetir(
            _apartman,
          )
          .then((value) => setState(() {
                geri();
                _giderler = value;
                if (value != null && value.isEmpty) {
                  _giderler = null;
                } else
                  _giderler = value;
              }))
          .catchError((hata) {
        setState(() {
          geri();
          if (hata.runtimeType == SocketException) {
            showDialog(
                context: context,
                builder: (context) => HataOlustu(
                      messaj: "Lütfen internet bağlantınızı kontrol ediniz.",
                    ));
          } else {
            showDialog(
                context: context,
                builder: (context) => HataOlustu(
                      messaj: "Giderler getirilirken hata oluştu. Detay:\n" +
                          hata.toString(),
                    ));
          }
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          /** Ad soyad kısmı **/
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Container(
              margin: EdgeInsets.only(top: 8, right: 8, bottom: 8),
              padding: EdgeInsets.symmetric(vertical: 8),
              decoration: BoxDecoration(
                  color: Colors.grey.shade300, //Color(0xEBBCFFFF),
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(60),
                    topRight: Radius.circular(10),
                    //topLeft: Radius.circular(60),
                    //bottomLeft: Radius.circular(10)
                  )),
              child: Center(
                child: Text(
                  "${_daireSakini?.AdGet() ?? "Bilinmiyor..."} ${_daireSakini?.SoyadGet()}",
                  style: TextStyle(fontSize: 30, fontFamily: "Caveman"),
                ),
              ),
            ),
          ),
          /** Aidat ve Borç kısmı **/
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: EdgeInsets.only(left: 15, top: 15, bottom: 15, right: 4),
              margin: EdgeInsets.only(left: 10, top: 8, bottom: 8),
              decoration: BoxDecoration(
                color: Colors.brown.shade300,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(60),
                  topLeft: Radius.circular(10),
                ),
              ),
              child: Row(
                children: [
                  /** Aidat kısmı **/
                  Text(
                    " Aidat: ",
                    style: const TextStyle(
                        fontSize: 21,
                        fontFamily: "BitstreamCyber",
                        fontWeight: FontWeight.bold),
                  ),
                  Flexible(
                    child: Text(
                      "${_aidat?.TutarGet() ?? "Bilinmiyor..."}",
                      style: const TextStyle(
                          fontSize: 21,
                          fontFamily: "BitstreamCyber",
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    "TL",
                    style: const TextStyle(
                        fontSize: 21,
                        fontFamily: "BitstreamCyber",
                        fontWeight: FontWeight.bold),
                  ),
                  /** Borç kısmı **/
                  Text(
                    " Borç: ",
                    style: const TextStyle(
                        fontSize: 21,
                        fontFamily: "OpenDyslexic",
                        fontWeight: FontWeight.normal),
                  ),
                  Flexible(
                    child: Text(
                      "${_borc?.toString() ?? "Bilinmiyor..."}",
                      style: const TextStyle(
                          fontSize: 21,
                          fontFamily: "BitstreamCyber",
                          fontWeight: FontWeight.bold),
                      maxLines: 3,
                      //overflow: TextOverflow.visible,
                    ),
                  ),
                  Text(
                    "TL",
                    style: const TextStyle(
                        fontSize: 21,
                        fontFamily: "BitstreamCyber",
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
          /** Gider Dönemi Seçim **/
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  style: styleDonem(GiderDonem.donem),
                  onPressed: () {
                    setState(() {
                      giderDonem();
                      _donem = GiderDonem.donem;
                    });

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Bu dönemin verileri getirilmiştir."),
                      duration: Duration(milliseconds: 400),
                    ));
                  },
                  child: Text("Dönem")),
              Container(
                  height: 40,
                  child: VerticalDivider(
                    color: Colors.black,
                    thickness: 2,
                    width: 20,
                    indent: 2,
                    endIndent: 5,
                  )),
              TextButton(
                  style: styleDonem(GiderDonem.tumDonem),
                  onPressed: () {
                    setState(() {
                      giderTumDonem();
                      _donem = GiderDonem.tumDonem;
                    });

                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Tüm dönemlerin verileri getirilmiştir."),
                      duration: Duration(milliseconds: 400),
                    ));
                  },
                  child: Text("Tümü"))
            ],
          ),
          /** Giderler ekranı Liste **/
          Expanded(
            child: Container(
              margin: EdgeInsets.all(8),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.teal.shade300,
                  borderRadius: BorderRadius.circular(40)),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Text(
                        "Giderler:",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: _giderler?.length ?? 1,
                        itemBuilder: (context, sayi) => insaat(context, sayi)),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /** oDnem butonunda seçime göre ki sitilleri **/
  ButtonStyle styleDonem(GiderDonem buttonDonem) {
    return (_donem == buttonDonem
        ? ButtonStyle(
            textStyle: MaterialStateTextStyle.resolveWith(
                (states) => TextStyle(fontSize: 20)),
            backgroundColor: MaterialStateColor.resolveWith(
                (states) => Colors.grey.shade400))
        : ButtonStyle(
            textStyle: MaterialStateTextStyle.resolveWith(
                (states) => TextStyle(fontSize: 15)),
            backgroundColor: MaterialStateColor.resolveWith(
                (states) => Colors.grey.shade100)));
  }

  dynamic insaat(BuildContext context, int sayi) {
    /*if (sayi == 10)
      return Card(
          child: SizedBox(
              height: 64,
              child: Image(
                image: AssetImage("resimler/user64.png"),
              )));*/

    if (_giderler == null || (_giderler != null && _giderler!.isEmpty))
      return Column(
        children: [
          Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(40)),
                color: Colors.white,
              ),
              child: Center(
                child: SizedBox(
                    //height: MediaQuery.of(context).size.width / 5,
                    child: Column(
                  children: [
                    Text(
                      "Yok veya Bilinmiyor",
                      style: TextStyle(
                          fontFamily: "OpenDyslexic",
                          fontStyle: FontStyle.normal,
                          //fontWeight: FontWeight.bold,
                          fontSize: 25),
                    ),
                    Text(
                      "Açıklama : Giderlerin bilgisine ulaşılamadı.",
                      textAlign: TextAlign.left,
                      textDirection: TextDirection.ltr,
                      style: TextStyle(
                        fontFamily: "TimeseNewRoman",
                        fontStyle: FontStyle.normal,
                        //fontWeight: FontWeight.bold,
                        fontSize: 18.5,
                      ),
                    ),
                  ],
                )),
              )),
          Divider(
            height: 20,
            color: Colors.amberAccent,
            thickness: 2,
            indent: 40,
            endIndent: 40,
          )
        ],
      );

    return Column(
      children: [
        Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(40)),
              color: Colors.white,
            ),
            child: Center(
              child: SizedBox(
                  //height: MediaQuery.of(context).size.width / 5,
                  child: Column(
                children: [
                  Text(
                    _giderTipleri?[_giderler?[sayi].TipGet() ?? 0].AdGet() ??
                        "Diğer",
                    style: TextStyle(
                        fontFamily: "OpenDyslexic",
                        fontStyle: FontStyle.normal,
                        //fontWeight: FontWeight.bold,
                        fontSize: 25),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Tutar: ",
                        style: TextStyle(
                            fontFamily: "OpenDyslexic",
                            fontStyle: FontStyle.italic,
                            //fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Text(
                        _giderler?[sayi].TutarGet().toString() ??
                            "Bilinmiyor...",
                        style: TextStyle(
                            fontFamily: "OpenDyslexic",
                            fontStyle: FontStyle.italic,
                            //fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      Text(
                        "Tl",
                        style: TextStyle(
                            fontFamily: "OpenDyslexic",
                            fontStyle: FontStyle.italic,
                            //fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ],
                  ),
                  Text(
                    "Açıklama : " +
                        (_giderTipleri?[_giderler?[sayi].TipGet() ?? 0]
                                .AciklamaGet() ??
                            ""),
                    textAlign: TextAlign.left,
                    textDirection: TextDirection.ltr,
                    style: TextStyle(
                      fontFamily: "TimeseNewRoman",
                      fontStyle: FontStyle.normal,
                      //fontWeight: FontWeight.bold,
                      fontSize: 18.5,
                    ),
                  ),
                ],
              )),
            )),
        Divider(
          height: 20,
          color: Colors.amberAccent,
          thickness: 2,
          indent: 40,
          endIndent: 40,
        )
      ],
    );
  }
}

Decimal? _tutar;

class AltKisim extends StatefulWidget {
  AltKisim({Key? key}) : super(key: key);

  @override
  State<AltKisim> createState() => _AltKisim();
}

class _AltKisim extends State<AltKisim> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Container(
            //color: Colors.red,
            child: Row(
              children: [
                Expanded(
                  child: IconGenisButton(
                    "resimler/cancel.png",
                    color: Colors.grey.shade300,
                    text: Text(
                      "Çıkış",
                      style: TextStyle(fontSize: 20),
                    ),
                    onPress: () {
                      Cikis(context);
                    },
                  ),
                ),
                Expanded(
                  child: IconGenisButton(
                    "resimler/wallet.png",
                    text: const Text(
                      "Öde",
                      style: TextStyle(fontSize: 20),
                    ),
                    color: Colors.blue,
                    onPress: () {
                      odeme(context);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  void odeme(BuildContext context) {
    showDialog<void>(
      context: context,
      builder: (value) => AlertDialog(
        title: Center(child: Text("Ödeme")),
        content: Row(
          children: [
            Text("Tutar : "),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "***.**",
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r"[.0123456789]")),
                  //FilteringTextInputFormatter.deny(RegExp(r'[a-z]')),
                  //FilteringTextInputFormatter.deny(RegExp(r'[A-Z]')),
                ],
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    try {
                      _tutar = Decimal.fromJson(value);
                    } catch (e) {
                      _tutar = null;
                    }
                  }
                },
              ),
            ),
            Text("Tl")
          ],
        ),
        actions: [
          Row(
            children: [
              Expanded(
                  child: IconGenisButton(
                "resimler/cancel.png",
                text: const Text(
                  "İptal",
                  style: TextStyle(fontSize: 20),
                ),
                color: Colors.grey.shade300,
                onPress: () {
                  setState(() {
                    _tutar = null;
                    Navigator.pop(context);
                  });
                },
              )),
              Expanded(
                  child: IconGenisButton(
                "resimler/tamam.png",
                text: const Text(
                  "Onayla",
                  style: TextStyle(fontSize: 20),
                ),
                color: Colors.grey.shade300,
                onPress: () {
                  setState(() {
                    showDialog(context: context, builder: (context)=>Yukleniyor());
                    if (_tutar != null &&
                        _daireSakini != null &&
                        _daireSakini!.SNoGet() > 0 &&
                        _apartman > 0) {
                      BorcServis()
                          .BorcOde(_tutar!, _apartman, _daireSakini!.SNoGet())
                          .then((value) {
                        setState(() {
                          Navigator.of(context).pop();
                          if (value) {
                            showDialog(
                                context: context,
                                builder: (context){_borc=(_borc! - _tutar!); return Basarili();});
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) => Basarisiz());
                          }
                        });
                      }).catchError((hata) {
                        setState(() {
                          Navigator.of(context).pop();
                          if (hata.runtimeType == SocketException) {
                            showDialog(
                                context: context,
                                builder: (context) => HataOlustu(
                                      messaj: "Ödeme işleminde hata oluştu\n"
                                          "Lütfen internet bağlantınızı kontrol ediniz.",
                                    ));
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) => HataOlustu(
                                      messaj:
                                          "Ödeme işleminde hata oluştu. Detay:\n" +
                                              hata.toString(),
                                    ));
                          }
                        });
                      });
                    } else {
                      Navigator.of(context).pop();
                      showDialog(
                          context: context,
                          builder: (context) => HataOlustu(
                                messaj: "Lüfen bilgileri eksiksiz giriniz.",
                              ));
                    }
                  });
                },
              )),
            ],
          )
        ],
      ),
    );
  }

  void Cikis(BuildContext context) {
    //exit(1);
    Navigator.pop(context);
  }
}
