import 'dart:io';

import 'package:apartman_yonetim_sistemi/EntityLayer/Concrete/Aidat.dart';
import 'package:apartman_yonetim_sistemi/GirenPersonel.dart';
import 'package:apartman_yonetim_sistemi/Servisler/BorcServis.dart';
import 'package:apartman_yonetim_sistemi/Servisler/DaireServis.dart';
import 'package:apartman_yonetim_sistemi/Servisler/TahakkukServis.dart';
import 'package:apartman_yonetim_sistemi/Widgets/DefterEffect.dart';
import 'package:apartman_yonetim_sistemi/Widgets/Tamalandi.dart';
import 'package:apartman_yonetim_sistemi/Widgets/Yukleniyor.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

import '../../EntityLayer/Concrete/DaireSakini.dart';

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
                      const PopupMenuItem(child: ListTile(
                            leading: Icon(Icons.people_alt_outlined),
                            title: Text(
                              "Daire İşlemleri",
                              style: TextStyle(
                                  fontFamily: "OpenDyslexic", fontSize: 20
                              ),
                            ),
                          ),),
                      const PopupMenuDivider(),
                      const PopupMenuItem(child: ListTile(
                            leading: Icon(Icons.home_work_outlined),
                            title: Text(
                              "Tahakkuk",
                              style: TextStyle(
                                  fontFamily: "OpenDyslexic", fontSize: 20
                              ),
                            ),
                          ),),
                      const PopupMenuDivider(),
                      const PopupMenuItem(child: ListTile(
                            leading: Icon(Icons.info_outline),
                            title: Text(
                              "Hakkında",
                              style: TextStyle(
                                  fontFamily: "OpenDyslexic", fontSize: 20
                              ),
                            ),
                          ),
                      ),
                    ]
                ),
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

List<DaireSakini>? _daireSakinleri;
Aidat? _aidat;
int _apartman=GirenPersonel.getYonetici()?.ApartmanGet() ?? 0;

class _GovdeState extends State<Govde> {
  initState() {
    _daireSakinleri = <DaireSakini>[
      DaireSakini.set(
          ad: "Bekir", soyad: "Piralp", tc: "12345678910", daire: 10),
      DaireSakini.set(
          ad: "Deneme ad 2",
          soyad: "Deneme soyad 3",
          tc: "12345678911",
          daire: 20),
      DaireSakini.set(
          ad: "Deneme ad 3",
          soyad: "Deneme soyad 4",
          tc: "12345678912",
          daire: 30),
      DaireSakini.set(
          ad: "Deneme ad 4",
          soyad: "Deneme soyad 5",
          tc: "12345678913",
          daire: 40),
      DaireSakini.set(
          ad: "Deneme ad 5",
          soyad: "Deneme soyad 6",
          tc: "12345678914",
          daire: 50)
    ];
    _aidat = Aidat.set(tutar: Decimal.fromJson("129.9900000000000001"));
    super.initState();
    /** Aidat bilgisi alma yeri**/
    showDialog(context: context,builder: (context)=> Yukleniyor());
    TahakkukServisi().AidatGetir(_apartman).then((value)=> setState(() {
         Navigator.of(context).pop();
         _aidat=value;
       })).catchError((hata)=> setState(() {
        Navigator.of(context).pop();
        if(hata.runtimeType == SocketException)
          showDialog(context: context, builder: (context)=>HataOlustu(messaj: "Lütfen internet bağlantınızı kontrol ediniz.",));
        else
          showDialog(context: context, builder: (context)=>HataOlustu(messaj: "Aidat bilgisi getirilirken hata oluştu. Detay:\n${hata.toString()}",));
      }));

    /** Borçlu daire sakinleri alma kısmı **/
    showDialog(context: context, builder: (conetxt)=>Yukleniyor());
    BorcServis().BorcBorclular(_apartman).then((value)=> setState(() {
        Navigator.of(context).pop();
        _daireSakinleri = value;
      })).catchError((hata)=> setState(() {
        Navigator.of(context).pop();
        if(hata.runtimeType == SocketException)
          showDialog(context: context, builder: (context)=>HataOlustu(messaj: "Lütfen internet bağlantınızı kontrol ediniz.",));
        else
          showDialog(context: context, builder: (context)=>HataOlustu(messaj: "Borçlu daire sakinleri getirilirken hata oluştu. Detay:\n${hata.toString()}",));
      }));
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          /** Aidat Kısmı **/
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
                  /** Aidat **/
                  Expanded(
                      child: Container(
                    child: Center(
                        child: Row(
                      children: [
                        Expanded(
                          child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                Text(
                                  _aidat?.TutarGet().toString()??"Bilinmiyor...",
                                  style: const TextStyle(
                                      color: Colors.white, fontSize: 30),
                                ),
                              ]),
                        ),
                        Text(
                          " TL",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ],
                    )),
                  )),
                ],
              ),
            ),
          ),
          /** Borçlu daire sakinleri kısmı **/
          Expanded(
            child: Stack(children: [
              /** Başlık kısmı **/
              Positioned(
                  left: _size.width * 0.33,
                  top: _size.height * 0.035,
                  child: Text(
                    "Borçlu Daire Sakinleri",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontFamily: "OpenDyslexic"),
                  )),
              /** Daire sakini listesi **/
              Container(
                margin: const EdgeInsets.only(left: 40, top: 20),
                padding: const EdgeInsets.only(left: 40, top: 40),
                decoration: BoxDecoration(
                    //color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(_size.width * 0.35)),
                    border: Border.all(color: Colors.greenAccent, width: 2)),
                child: ListView.builder(
                    itemCount: _daireSakinleri?.length,
                    itemBuilder: BorcListBuilder),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget BorcListBuilder(BuildContext context, int say) {

    if(_daireSakinleri == null){
      return Padding(
        padding: const EdgeInsets.only(bottom: 8, top: 8, right: 10),
        child: Container(
          padding: EdgeInsets.only(left: 20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(50),
                bottomLeft: Radius.circular(50),
              )),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  child: Column(
                    children: [
                      /** Bilgilendirme **/
                      Row(
                        children: [
                          const Text(
                            "Bilgi :\t\t\t\t\t\t\t",
                            style: TextStyle(fontSize: 17.5),
                          ),
                          Flexible(
                            child: Text(
                              "Daire sakinlerinin bilgilerine erişilmedi.",
                              style: const TextStyle(
                                  fontFamily: "OpenDyslexic", fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.black,
                        thickness: 2,
                      ),
                    ],
                  ),
                ),
              ),
              /** Defter efecti **/
              SizedBox(
                width: 30,
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(child: Container()),
                    DefterEffectSag(
                      width: 20,
                      height: 20,
                    ),
                    Expanded(child: Container()),
                    DefterEffectSag(
                      width: 20,
                      height: 20,
                    ),
                    Expanded(child: Container()),
                    DefterEffectSag(
                      width: 20,
                      height: 20,
                    ),
                    Expanded(child: Container()),
                    DefterEffectSag(
                      width: 20,
                      height: 20,
                    ),
                    Expanded(child: Container()),
                    DefterEffectSag(
                      width: 20,
                      height: 20,
                    ),
                    Expanded(child: Container()),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 8, right: 10),
      child: Container(
        padding: EdgeInsets.only(left: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              bottomLeft: Radius.circular(50),
            )),
        child: Row(
          children: [
            Expanded(
              child: SizedBox(
                child: Column(
                  children: [
                    /** Ad **/
                    Row(
                      children: [
                        const Text(
                          "Adı :\t\t\t\t\t\t\t",
                          style: TextStyle(fontSize: 17.5),
                        ),
                        Flexible(
                          child: Text(
                            "${_daireSakinleri?[say].AdGet()}",
                            style: const TextStyle(
                                fontFamily: "OpenDyslexic", fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 2,
                    ),
                    /** Soyad **/
                    Row(
                      children: [
                        const Text(
                          "Soyadı : ",
                          style: TextStyle(fontSize: 17.5),
                        ),
                        Flexible(
                          child: Text(
                            "${_daireSakinleri?[say].SoyadGet()}",
                            style: const TextStyle(
                                fontFamily: "OpenDyslexic", fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 2,
                    ),
                    /** Daire no **/
                    Row(
                      children: [
                        const Text(
                          "Daire : \t\t\t",
                          style: TextStyle(fontSize: 17.5),
                        ),
                        Flexible(
                          child: Text(
                            "${_daireSakinleri?[say].DaireGet()}",
                            style: const TextStyle(
                                fontFamily: "OpenDyslexic", fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            /** Defter efecti **/
            SizedBox(
              width: 30,
              height: 200,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(child: Container()),
                  DefterEffectSag(
                    width: 20,
                    height: 20,
                  ),
                  Expanded(child: Container()),
                  DefterEffectSag(
                    width: 20,
                    height: 20,
                  ),
                  Expanded(child: Container()),
                  DefterEffectSag(
                    width: 20,
                    height: 20,
                  ),
                  Expanded(child: Container()),
                  DefterEffectSag(
                    width: 20,
                    height: 20,
                  ),
                  Expanded(child: Container()),
                  DefterEffectSag(
                    width: 20,
                    height: 20,
                  ),
                  Expanded(child: Container()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
