import 'dart:developer';
import 'dart:io';

import 'package:apartman_yonetim_sistemi/Ekranlar/GiderTipleri.dart';
import 'package:apartman_yonetim_sistemi/EntityLayer/Concrete/Aidat.dart';
import 'package:apartman_yonetim_sistemi/GirenPersonel.dart';
import 'package:apartman_yonetim_sistemi/Servisler/GiderlerServis.dart';
import 'package:apartman_yonetim_sistemi/Servisler/TahakkukServis.dart';
import 'package:apartman_yonetim_sistemi/Widgets/DefterEffect.dart';
import 'package:apartman_yonetim_sistemi/Widgets/Tamalandi.dart';
import 'package:apartman_yonetim_sistemi/Widgets/Yukleniyor.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../EntityLayer/Concrete/Gider.dart';
import '../../EntityLayer/Concrete/GiderTip.dart';
import '../../Widgets/IconGenisButton.dart';

class TahakkukIslemleri extends StatefulWidget {
  const TahakkukIslemleri({Key? key}) : super(key: key);

  @override
  State<TahakkukIslemleri> createState() => _TahakkukIslemleriState();
}

BuildContext? _context;
class _TahakkukIslemleriState extends State<TahakkukIslemleri> {
  @override
  Widget build(BuildContext context) {
    _context = context;
    var Size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.grey.shade500,
      body: SingleChildScrollView(
        child: SizedBox(
          height: Size.height,
          width: Size.width,
          child: Container(
            child: Column(
              children: [
                UstKisim(),
                Govde(),
                /** Değişiklilleri onaylama kısmı **/
                AltKisim(),
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
                        "Tahakkuk İşlemleri",
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
                child: PopupMenuButton(
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 40,
                    ),
                    itemBuilder: (context) => <PopupMenuEntry>[
                          PopupMenuItem(
                            child: ListTile(
                              leading: Icon(Icons.home),
                              title: Text(
                                "Ana Ekran",
                                style: TextStyle(
                                    fontFamily: "OpenDyslexic", fontSize: 20),
                              ),
                              onTap: () {
                                Navigator.pushNamed(
                                    context,
                                    "/yonetici");
                              },
                            ),

                          ),
                          const PopupMenuDivider(),
                          PopupMenuItem(
                            child: ListTile(
                              leading: Icon(Icons.people_alt_outlined),
                              title: Text(
                                "Daire İşlemleri",
                                style: TextStyle(
                                    fontFamily: "OpenDyslexic", fontSize: 20),
                              ),
                              onTap: ()=>Navigator.of(context).pushNamed("/daire"),
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

Aidat? _aidat;
Aidat _aidatKayit = Aidat();
Gider _giderKayit = Gider();
List<GiderTip>? _giderTipleri;
List<Gider>? _giderler;
int _apartman = GirenPersonel.getYonetici()?.ApartmanGet() ?? 0;

class _GovdeState extends State<Govde> {
  GiderTip? _dropdownValue;

  initState() {
    _giderTipleri = GiderTipleri.getir;
    _dropdownValue = _giderTipleri![0];
    super.initState();
    /** Aidat Bilgisinin alınması **/
    /** İlk Yükleniyor efekti**/
    yukleniyor();
    TahakkukServisi().AidatGetir(_apartman).then((value) {
      setState(() {
        Navigator.of(context).pop();
        _aidat = value;
      });
    }).catchError((hata) {
      setState(() {
        Navigator.of(context).pop();
      });
      hataOldu("Aidat bilgisi getirilirken hata oluştu.", hata);
    });

    /** Gider Tipleri bilgisi getirme **/
    //yukleniyor();
    // Bu uygulama temel düzey olduğu için şimdilik boş bırakıyorum uygulama içi sabit de yapılabilir
    // veya gider getirme için web servise yazmak gerek

    /** Giderler bilgisi getirme**/
   // yukleniyor();
    GiderlerServis().GiderGetir(_apartman).then((value) {
      setState(() {
        _giderler = value;
      });
    }).catchError((hata) {
      hataOldu("Giderler getirilirken hata oluştu.", hata);
    });
  }

  /** Yükleniyor efekti ve hata göstergesi
   * Not:init state içerisi için**/
  void yukleniyor() {
    Future.delayed(Duration.zero).then((value) {
      setState(() {
        showDialog(
            context: context,
            builder: (context) {
              return Yukleniyor();
            });
      });
    });
  }

  void hataOldu(String mesaj, hata) {
    setState(() {
      if (hata.runtimeType == SocketException) {
        showDialog(
            context: context,
            builder: (context) {
              return HataOlustu(
                messaj:
                    "${mesaj} Detay:\nLütfen internet bağlantınızı kontrol ediniz. Detay:\n${hata.toString()}",
              );
            });
      } else {
        showDialog(
            context: context,
            builder: (context) {
              return HataOlustu(
                messaj: "${mesaj} Detay:\n${hata.toString()}",
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Expanded(
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          /** Aidat Görme Kısmı **/
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
                                  _aidat?.TutarGet().toString() ??
                                      "Bilinmiyor...",
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
          SizedBox(
            height: 5,
          ),
          /** Aidat Tanımlama Kısmı **/
          SizedBox(
            height: 40,
            child: Container(
              color: Colors.black,
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
                          "Aidat:",
                          style: TextStyle(color: Colors.black, fontSize: 30),
                        ),
                      ),
                    ),
                  ),
                  /** Aidat Giriş **/
                  Expanded(
                      child: Container(
                    child: Center(
                        child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.only(left: 8),
                            child: TextField(
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25),
                              decoration: InputDecoration(
                                  labelText: "_ _ . _",
                                  labelStyle: TextStyle(
                                      color: Colors.white, fontSize: 30)),
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r"[.0123456789]")),
                              ],
                              onChanged: (value) {
                                /** gerekli işlem **/
                                setState(() {
                                  if (value.isNotEmpty &&
                                      Decimal.fromJson(value) > Decimal.zero)
                                    _aidatKayit.TutarSet(
                                        Decimal.fromJson(value));
                                  else
                                    _aidatKayit.TutarSet(Decimal.zero);
                                });
                              },
                            ),
                          ),
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
          SizedBox(
            height: 5,
          ),
          /** Gider Tanımlama Kısmı **/
          SizedBox(
            height: 40,
            child: Container(
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xffffd700),
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: "Gider Tutarı",
                                labelStyle: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp(r"[.0123456789]")),
                              ],
                              style: TextStyle(fontSize: 25),
                              onChanged: (value) {
                                setState(() {
                                  if (value.isNotEmpty &&
                                      Decimal.fromJson(value) >
                                          Decimal.fromInt(0))
                                    _giderKayit.TutarSet(
                                        Decimal.fromJson(value));
                                  else {
                                    _giderKayit.TutarSet(Decimal.zero);

                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return HataOlustu(
                                            messaj:
                                                "Tutar sıfırdan büyük olmalı",
                                          );
                                        });
                                  }
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  /** Gider Tip Seçimi **/
                  Expanded(
                    child: Container(
                        child: Center(
                      child: DropdownButton(
                        icon: const Icon(
                          Icons.arrow_drop_down_circle_outlined,
                          color: Colors.black,
                        ),
                        elevation: 30,
                        dropdownColor: Colors.white,
                        style: TextStyle(color: Colors.black, fontSize: 22),
                        underline: Container(
                          width: 2,
                          color: Colors.blue,
                        ),
                        value: _dropdownValue,
                        items: _giderTipleri!
                            .map<DropdownMenuItem<GiderTip>>((value) {
                          return DropdownMenuItem<GiderTip>(
                            value: value,
                            child: Text(value.AdGet()),
                          );
                        }).toList(),
                        onChanged: (GiderTip? value) {
                          //seçili gider ayarlaması yapılacak
                          //şeçili idye bir nesne oluşturulacak.
                          _giderKayit.TipSet(value?.SNoGet() ?? 0);
                          setState(() {
                            _dropdownValue = value;
                          });
                          // sısıfırıncı seçili ise duruma göre  gider eklendirile bilir
                        },
                      ),
                    )),
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),

          /** Giderleri Görme kısmı **/
          Expanded(
            child: Stack(children: [
              /** Başlık kısmı **/
              Positioned(
                  left: _size.width * 0.33,
                  top: _size.height * 0.025,
                  child: Text(
                    "Giderler",
                    style: TextStyle(
                        fontSize: 22,
                        color: Colors.white,
                        fontFamily: "OpenDyslexic"),
                  )),
              /** Giderler listesi **/
              Container(
                margin: const EdgeInsets.only(left: 40, top: 10),
                padding: const EdgeInsets.only(left: 40, top: 40),
                decoration: BoxDecoration(
                    //color: Colors.white.withOpacity(0.8),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(_size.width * 0.35)),
                    border: Border.all(color: Colors.greenAccent, width: 2)),
                child: ListView.builder(
                    itemCount: _giderler?.length ?? 1,
                    itemBuilder: GiderListBuilder),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget GiderListBuilder(BuildContext context, int say) {
    if (_giderler == null) {
      //Şuan biraz üşengeçliğim tuutu o yüzden kopyala yapıştır ;)
      //Normalde yeni bir lochal method oluşturup sadece değişenkısmı ayarlamam lazım lakin ....
      return Padding(
        padding: const EdgeInsets.only(bottom: 8, top: 0, right: 10),
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
                      /** Bilgi **/
                      Row(
                        children: [
                          const Text(
                            "Bilgi :\t\t\t\t\t\t\t",
                            style: TextStyle(fontSize: 17.5),
                          ),
                          Flexible(
                            child: Text(
                              "Giderlerin Bilgisine Ulaşılamadı",
                              style: const TextStyle(
                                  fontFamily: "OpenDyslexic", fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      Cizgi(),
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

    try {
      _giderler!.forEach((element) {
        for (var item in _giderTipleri!) {
          if (item.SNoGet() == element.TipGet()) {
            break;
          } else if (item == _giderTipleri!.last) {
            throw new Exception("Hata verilerde uyumsuzluk");
          }
        }
      });
    } catch (_) {
      // hata tanımları ve uyarılar ve  işlemleri
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 0, right: 10),
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
                            "${_giderTipleri!.where((p) => p.SNoGet() == _giderler?[say].TipGet()).first.AdGet()}",
                            style: const TextStyle(
                                fontFamily: "OpenDyslexic", fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    Cizgi(),
                    /** Tutar **/
                    Row(
                      children: [
                        const Text(
                          "Tutar : ",
                          style: TextStyle(fontSize: 17.5),
                        ),
                        Flexible(
                          child: Text(
                            "${_giderler![say].TutarGet()} TL",
                            style: const TextStyle(
                                fontFamily: "OpenDyslexic", fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    Cizgi(),
                    /** Ay/ Yıl **/
                    Row(
                      children: [
                        const Text(
                          "Ay / Yıl : \t\t\t",
                          style: TextStyle(fontSize: 17.5),
                        ),
                        Text(
                          "${_giderler![say].AyGet()} / ${_giderler![say].YilGet()}",
                          style: const TextStyle(
                              fontFamily: "OpenDyslexic", fontSize: 20),
                        ),
                      ],
                    ),
                    Cizgi(),
                    /** Açıklama **/
                    Row(
                      children: [
                        const Text(
                          "Açıklama : \t\t\t",
                          style: TextStyle(fontSize: 17.5),
                        ),
                        Flexible(
                          child: Text(
                            "${_giderTipleri!.where((p) => p.SNoGet() == _giderler![say].TipGet()).first.AciklamaGet()}",
                            style: const TextStyle(
                                fontFamily: "OpenDyslexic", fontSize: 20),
                          ),
                        ),
                      ],
                    ),
                    Cizgi(),
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

class AltKisim extends StatefulWidget {
  const AltKisim({Key? key}) : super(key: key);

  @override
  State<AltKisim> createState() => _AltKisimState();
}

class _AltKisimState extends State<AltKisim> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
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
                "Kaydet",
                style: TextStyle(fontSize: 20),
              ),
              color: Colors.blue,
              onPress: () {
                setState(() {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Yukleniyor();
                      });
                });
                if (_aidatKayit.TutarGet() > Decimal.zero ||
                    _giderKayit.TutarGet() > Decimal.zero) {
                  if (_aidatKayit.TutarGet() > Decimal.zero) {

                    TahakkukServisi()
                        .AidatTanimla(_apartman, _aidatKayit.TutarGet())
                        .then((value) {
                      setState(() {
                        Navigator.of(context).pop();
                        if (value == true) {
                          showDialog(
                              context: context,
                              builder: (context) => Basarili());
                          _aidat = _aidatKayit;
                          _aidatKayit = Aidat();
                        } else
                          showDialog(
                              context: context,
                              builder: (context) => Basarisiz());
                      });
                    }).catchError((hata) {
                      setState(() {
                        Navigator.of(context).pop();
                        if (hata.runtimeType == SocketException) {
                          showDialog(
                              context: context,
                              builder: (context) => HataOlustu(
                                    messaj:
                                        "Lütfen internet bağlantınızı kontrol ediniz. Detay:\n${hata.toString()}",
                                  ));
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) => HataOlustu(
                                    messaj:
                                        "Aidat tanımlamada hataoluştu. Detay:\n${hata.toString()}",
                                  ));
                        }
                      });
                    });
                  }

                  if (_giderKayit.TutarGet() > Decimal.zero) {
                    GiderlerServis()
                        .Olustur(_apartman, _giderKayit.TutarGet(),
                            _giderKayit.TipGet())
                        .then((value) {
                      setState(() {
                        Navigator.of(context).pop();
                        if (value) {
                          showDialog(
                              context: context,
                              builder: (context) => Basarili());
                          _giderler ??= <Gider>[];
                          _giderler?.add(_giderKayit);
                        } else
                          showDialog(
                              context: context,
                              builder: (context) => Basarisiz());
                      });
                    }).catchError((hata) {
                      setState(() {
                        Navigator.of(context).pop();
                        if (hata.runtimeType == SocketException) {
                          showDialog(
                              context: context,
                              builder: (context) => HataOlustu(
                                    messaj:
                                        "Lütfen internet bağlantınızı kontrol ediniz. Detay:\n${hata.toString()}",
                                  ));
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) => HataOlustu(
                                    messaj:
                                        "Gider kaydetmede hataoluştu. Detay:\n${hata.toString()}",
                                  ));
                        }
                      });
                    });
                  }
                } else {
                  setState(() {
                    Navigator.of(context).pop();
                    showDialog(
                        context: context,
                        builder: (context) {
                          return HataOlustu(
                              messaj: "Lütfen parametreleri eksiksiz giriniz");
                        });
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void Cikis(BuildContext context) {
    //exit(1);
    Navigator.pop(context);
  }
}
