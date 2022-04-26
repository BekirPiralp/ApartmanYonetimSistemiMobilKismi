
import 'dart:developer';

import 'package:apartman_yonetim_sistemi/Ekranlar/Hakkinda.dart';
import 'package:apartman_yonetim_sistemi/Ekranlar/UrlAyarla.dart';
import 'package:apartman_yonetim_sistemi/Ekranlar/Yonetici/DaireIslemleri.dart';
import 'package:apartman_yonetim_sistemi/Ekranlar/Yonetici/TahakkukIslemleri.dart';
import 'package:flutter/material.dart';
import 'Ekranlar/DaireSakini/AnaEkran.dart' as dsAna;
import 'Ekranlar/Giris.dart';
import 'Ekranlar/Yonetici/AnaEkran.dart' as yntciAna;

void main() {
  //runApp(const MyApp()); //Şuan içn değiştireceğim
  runApp(MyApp());
    //home:TahakkukIslemleri(),));//yntciAna.AnaEkran()));//TahakkukIslemleri(),));//DaireIslemleri(),));//TahakkukIslemleri(),));//yntciAna.AnaEkran()));//dsAna.AnaEkran()));//home:Giris(),));//Giris());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      navigatorKey: GlobalKey<NavigatorState>(),
      routes: {
        '/':(context)=> const Giris(),
        '/yonetici':(context)=> const yntciAna.AnaEkran(),
        '/tahakkuk':(context)=> const TahakkukIslemleri(),
        '/daire':(context){ return DaireIslemleri();},
        '/daireSakini':(context)=>const dsAna.AnaEkran(),
        '/hakinda':(context)=> const Hakkinda(),
        '/ayarUrl':(context)=> const UrlAyarla(),
      },
      debugShowCheckedModeBanner: false,);
  }
}

