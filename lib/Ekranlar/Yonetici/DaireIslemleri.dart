import 'dart:io';

import 'package:apartman_yonetim_sistemi/GirenPersonel.dart';
import 'package:apartman_yonetim_sistemi/Servisler/DaireServis.dart';
import 'package:apartman_yonetim_sistemi/Widgets/DefterEffect.dart';
import 'package:apartman_yonetim_sistemi/Widgets/Tamalandi.dart';
import 'package:apartman_yonetim_sistemi/Widgets/Yukleniyor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../EntityLayer/Concrete/DaireSakini.dart';
import '../../Widgets/IconGenisButton.dart';

class DaireIslemleri extends StatefulWidget {
  const DaireIslemleri({Key? key}) : super(key: key);

  @override
  State<DaireIslemleri> createState() => _DaireIslemleriState();
}

class _DaireIslemleriState extends State<DaireIslemleri> {
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
                        "Daire İşlemleri",
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
                            child: ListTile(
                              leading: Icon(Icons.home),
                              title: Text(
                                "Ana Ekran",
                                style: TextStyle(
                                    fontFamily: "OpenDyslexic", fontSize: 20),
                              ),
                              onTap: ()=>Navigator.of(context).pushNamed('/yonetici'),
                            ),
                          ),
                          const PopupMenuDivider(),
                           PopupMenuItem(
                            child: ListTile(
                              leading: Icon(Icons.home_work_outlined),
                              title: Text(
                                "Tahakkuk",
                                style: TextStyle(
                                    fontFamily: "OpenDyslexic", fontSize: 20),
                              ),
                              onTap: ()=>Navigator.of(context).pushNamed('/tahakkuk'),
                            ),
                           ),
                          const PopupMenuDivider(),
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
DaireSakini _daireSakini = DaireSakini();
int _apartman = GirenPersonel.getYonetici()?.ApartmanGet() ?? 0;

class _GovdeState extends State<Govde> {
  initState() {
    super.initState();

    Future.delayed(Duration.zero).then((value){
      setState(() {
        showDialog(context: this.context, builder: (context){
          return Yukleniyor();
        });
      });
    });
    DaireServisi().DaireSakinleriGetir(_apartman).then((value) {
      setState(() {
        Navigator.of(context).pop();
        _daireSakinleri = value;
      });
    }).catchError((hata){
      setState(() {
        Navigator.of(context).pop();
        showDialog(context: context, builder: (context){
          return HataOlustu(messaj: "Daire Sakinleri getirilirken hata oluştu. \n"
              "Lütfen internet bağlantınızı kontrol ediniz. \nDetay:${hata.toString()}",);
        });
      });
    });

  }

  void Cikis(BuildContext context) {
    //exit(1);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    void btnKaydet() {
      if (_daireSakini.AdGet().isNotEmpty &&
          _daireSakini.SoyadGet().isNotEmpty &&
          _daireSakini.TCGet().isNotEmpty &&
          _daireSakini.DaireGet() > 0) {
        try {
          setState(() {
            showDialog(
                context: context,
                builder: (context) {
                  return Yukleniyor();
                });
          });
          DaireServisi().DaireTanimlaSno(
              _apartman,
              _daireSakini,
              _daireSakini.DaireGet()).then((value) {
            Navigator.of(context).pop();
            if (value == true) {
              setState(() {
                showDialog(
                  context: context,
                  builder: (context) => Basarili(),
                );
              });
            } else if (value == false)
              setState(() {
                showDialog(context: context, builder: (context) => Basarisiz());
              });
          }).catchError((hata){
            if(hata.runtimeType == SocketException){
              setState(() {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        backgroundColor: Colors.transparent,
                        child: HataOlustu(
                          messaj: hata.toString(),
                        ),
                      );
                    });
              });
            }else
              setState(() {
              Navigator.of(context).pop();
              showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      child: HataOlustu(
                        messaj: hata.toString(),
                      ),
                    );
                  });
            });
            }).timeout(Duration(minutes: 1),onTimeout: (){
            setState(() {
              Navigator.of(context).pop();
              showDialog(
                  context: context,
                  builder: (context) {
                    return Dialog(
                      backgroundColor: Colors.transparent,
                      child: HataOlustu(
                        messaj: "Yeterli sürede cevap gelmedi internet bağlantınızı kontrol ediniz.",
                      ),
                    );
                  });
            });
          });

        } catch (hata) {

          setState(() {
            Navigator.of(context).pop();
            showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    backgroundColor: Colors.transparent,
                    child: HataOlustu(
                      messaj: hata.toString(),
                    ),
                  );
                });
          });
        }
      } else {
        setState(() {
          showDialog(
              context: context,
              builder: (context) => Dialog(
                    child: Container(
                      constraints: BoxConstraints(
                        maxWidth: MediaQuery.of(context).size.width * 2 / 3,
                        minHeight: 200,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.error_outline,
                            color: Colors.red,
                            size: 64,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Flexible(
                              child: Text(
                            "İstenilen Bilgileri Lüften Eksiksiz Giriniz.",
                            style: TextStyle(fontSize: 20),
                            textAlign: TextAlign.center,
                          )),
                          IconGenisButton(
                            "resimler/tamam.png",
                            color: Colors.grey.shade300,
                            onPress: () {
                              Navigator.of(context).pop();
                            },
                            text: Text(
                              "Tamam",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ));
        });
      }
    }

    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          /** Adı Kısmı **/
          SizedBox(
            height: 40,
            child: Container(
              color: Colors.white,
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
                          "Ad:",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                    ),
                  ),
                  /** Ad Alma **/
                  Expanded(
                      child: Container(
                    child: Center(
                        child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: "Adı",
                                labelStyle: TextStyle(
                                    fontSize: 20, color: Colors.grey)),
                            keyboardType: TextInputType.name,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 30),
                            onChanged: (value) {
                              if (value.isNotEmpty && value.length > 1)
                                _daireSakini.AdSet(value);
                              else
                                _daireSakini.AdSet("");
                            },
                          ),
                        ),
                      ],
                    )),
                  )),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          /** Soyadı Kısmı **/
          SizedBox(
            height: 40,
            child: Container(
              color: Colors.blue,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Soyad:",
                          style: TextStyle(color: Colors.blue, fontSize: 30),
                        ),
                      ),
                    ),
                  ),
                  /** Soyad Alma **/
                  Expanded(
                      child: Container(
                    child: Center(
                        child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: "Soyadı",
                                labelStyle: TextStyle(
                                    fontSize: 20, color: Colors.grey.shade200)),
                            keyboardType: TextInputType.name,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 30),
                            onChanged: (value) {
                              if (value.isNotEmpty && value.length > 1)
                                _daireSakini.SoyadSet(value);
                              else
                                _daireSakini.SoyadSet("");
                            },
                          ),
                        ),
                      ],
                    )),
                  )),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          /** Tc Kısmı **/
          SizedBox(
            height: 55,
            child: Container(
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "TC:",
                          style: TextStyle(color: Colors.white, fontSize: 30),
                        ),
                      ),
                    ),
                  ),
                  /** TC Alma **/
                  Expanded(
                      child: Container(
                    child: Center(
                        child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            maxLength: 11,
                            decoration: InputDecoration(
                                labelText: "Kimlik numarası",
                                labelStyle: TextStyle(
                                    fontSize: 20, color: Colors.grey.shade400)),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 30),
                            onChanged: (value) {
                              if (value.isNotEmpty && value.length == 11)
                                _daireSakini.TCSet(value);
                              else
                                _daireSakini.TCSet("");
                            },
                          ),
                        ),
                      ],
                    )),
                  )),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          /** Daire Seçim Kısmı **/
          SizedBox(
            height: 40,
            child: Container(
              color: Colors.transparent,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "Daire:",
                          style: TextStyle(color: Colors.black, fontSize: 30),
                        ),
                      ),
                    ),
                  ),
                  /** Daire Alma **/
                  Expanded(
                      child: Container(
                    child: Center(
                        child: Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: "Daire numarası",
                                labelStyle: TextStyle(
                                    fontSize: 20, color: Colors.grey)),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            keyboardType: TextInputType.number,
                            style: const TextStyle(
                                color: Colors.white, fontSize: 30),
                            onChanged: (value) {
                              if (value.isNotEmpty)
                                _daireSakini.DaireSet(int.parse(value));
                              else
                                _daireSakini.DaireSet(0);
                            },
                          ),
                        ),
                      ],
                    )),
                  )),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          /** Onay Button Kısmı **/
          SizedBox(
            height: 60,
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
                      _daireSakini = DaireSakini();
                      Cikis(context);
                    },
                  ),
                ),
                Expanded(
                  child: IconGenisButton(
                    "resimler/wallet.png",
                    text: const Text(
                      "Kaydet",
                      style: TextStyle(fontSize: 20),
                    ),
                    color: Colors.blue,
                    onPress: btnKaydet,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          /** Borçlu daire sakinleri kısmı **/
          Expanded(
            child: Stack(children: [
              /** Başlık kısmı **/
              Positioned(
                  left: _size.width * 0.43,
                  top: _size.height * 0.02,
                  child: Text(
                    "Daire Sakinleri",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontFamily: "OpenDyslexic"),
                  )),
              /** Daire sakini listesi **/
              Container(
                margin: const EdgeInsets.only(left: 40, top: 0),
                padding: const EdgeInsets.only(left: 40, top: 40),
                decoration: BoxDecoration(
                    //color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(_size.width * 0.35)),
                    border: Border.all(color: Colors.greenAccent, width: 2)),
                child: ListView.builder(
                    itemCount: _daireSakinleri?.length ?? 1,
                    itemBuilder: DaireSakiniListBuilder),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget DaireSakiniListBuilder(BuildContext context, int say) {
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
                      /** Boş veri **/
                      Row(
                        children: [
                          const Text(
                            "Bilgi :\t\t\t\t\t\t\t",
                            style: TextStyle(fontSize: 17.5),
                          ),
                          Flexible(
                            child: Text(
                              "Daire Sakinleri bulunamadı",
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
