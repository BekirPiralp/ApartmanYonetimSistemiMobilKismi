
import 'dart:io';

import 'package:apartman_yonetim_sistemi/GirenPersonel.dart';
import 'package:apartman_yonetim_sistemi/Servisler/GirisServis.dart';
import 'package:apartman_yonetim_sistemi/Widgets/Tamalandi.dart';
import 'package:apartman_yonetim_sistemi/Widgets/Yukleniyor.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../Widgets/GenisButton.dart';
import '../Widgets/IconGenisButton.dart';
import '../Widgets/ResimButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

double ustBosluk = 25;
const double ikonSize = 32;
String? _girenSakinTc;

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

    return WillPopScope(
       //Geriye bastığında gitmeyecek
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
                                 exit(0);//Sıfır normal kapatma
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
      child: Stack(
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
                                        GenisButton("Giriş", () {
                                          if(_girenSakinTc != null){
                                            if(status) {
                                              /** Yönetici giriş **/
                                              setState(() {
                                                showDialog(context: context, builder: (context)=>Yukleniyor());
                                              });
                                              GirisServisi().GetirYonetici(
                                                  _girenSakinTc!).then((value) {
                                                    setState(() {
                                                      Navigator.of(context).pop();
                                                    });
                                                if (value != null) {
                                                  GirenPersonel.temizle();
                                                  GirenPersonel.setYonetici(
                                                      value);
                                                  Navigator.of(context)
                                                      .pushNamed("/yonetici");
                                                } else {
                                                  setState((){
                                                    showDialog(context: context, builder: (context)=>HataOlustu(messaj: "Aradığınız TC'li bir kayıt bulunamadı",));
                                                  });
                                                }
                                              }).catchError((hata) {
                                                setState(() {
                                                  Navigator.of(context).pop();
                                                });
                                                if(hata.runtimeType == SocketException){
                                                  setState((){
                                                    showDialog(context: context, builder: (context)=>HataOlustu(messaj: "Lütfen internet bağlantınızı kontrol ediniz.",));
                                                  });
                                                }else{
                                                  setState((){
                                                    showDialog(context: context, builder: (context)=>HataOlustu(messaj: "Yöneticinin bilgileri getirilirken hata oluştu. Detay:\n${hata.toString()}",));
                                                  });
                                                }
                                              });
                                            }else{
                                              /** Daire Sakini giriş **/
                                              setState(() {
                                                showDialog(context: context, builder: (context)=>Yukleniyor());
                                              });
                                              GirisServisi().GetirDaireSakini(_girenSakinTc!).then((value){
                                                setState(() {
                                                  Navigator.of(context).pop();
                                                });
                                                if(value != null){
                                                  GirenPersonel.temizle();
                                                  GirenPersonel.setDaireSakini(value);
                                                  Navigator.of(context).pushNamed("/daireSakini");
                                                }else{
                                                  setState((){
                                                    showDialog(context: context, builder: (context)=>HataOlustu(messaj: "Aradığınız TC'li bir kayıt bulunamadı",));
                                                  });
                                                }
                                              }).catchError((hata){
                                                setState(() {
                                                  Navigator.of(context).pop();
                                                });
                                                if(hata.runtimeType == SocketException){
                                                  setState((){
                                                    showDialog(context: context, builder: (context)=>HataOlustu(messaj: "Lütfen internet bağlantınızı kontrol ediniz.",));
                                                  });
                                                }else{
                                                  setState((){
                                                    showDialog(context: context, builder: (context)=>HataOlustu(messaj: "Daire sakininin bilgileri getirilirken hata oluştu. Detay:\n${hata.toString()}",));
                                                  });
                                                }
                                              });
                                            }
                                          }else{
                                            setState((){
                                              showDialog(context: context, builder: (context)=>HataOlustu(messaj: "Lütfen bilgleri eksiksiz giriniz.(Geçerli bir TC kimlik numarası giriniz.)",));
                                            });
                                          }
                                        },),
                                        const Expanded(flex: 2, child: SizedBox())
                                      ],
                                    ),
                                  ))
                            ],
                          )),
                      _altKisim(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _uStKisim() => Column(children: [
        /*SizedBox(
          height: ustBosluk,
        ),*/
        SizedBox(
          height: ikonSize*2,
          child: Row(
            children: [
              Container(
                  padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: IconButton(
                    icon: Icon(Icons.info_outline,color: Colors.white,size: ikonSize,),
                    onPressed: (){
                      Navigator.of(context).pushNamed('/hakinda');
                    },
                  )),
              Expanded(
                child: Container(
                    //color: Colors.red.withOpacity(0.5),
                    ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: ResimButton('resimler/ayarlar_32px.png',onTap: (){
                    Navigator.of(context).pushNamed("/ayarUrl");
                  },),
              ),
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
              await launchUrlString("https://tr-tr.facebook.com/bekir.piralp.9");
            },
          ),
          const Expanded(child: SizedBox()),
          ResimButton(
            'resimler/instagram.png',
            onTap: () async {
              await launchUrlString("https://www.instagram.com/bekir01piralp/");
            },
          ),
          const Expanded(child: SizedBox()),
          ResimButton(
            'resimler/linkedin.png',
            onTap: () async {
              await launchUrlString("https://tr.linkedin.com/in/bekir-piralp-26bbab171");
            },
          ),
          const Expanded(child: SizedBox()),
          ResimButton(
            'resimler/github.png',
            onTap: () async {
              await launchUrlString("https://github.com/BekirPiralp");
            },
          ),
          const Expanded(child: SizedBox())
        ],
      ));


  _girdi(String deger) {
    if(deger.isNotEmpty&&deger.length==11){
      _girenSakinTc = deger;
    }else {
      _girenSakinTc=null;
    }
  }
}
