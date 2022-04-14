import 'package:apartman_yonetim_sistemi/main.dart';
import 'package:flutter/cupertino.dart';

class Istikametler{
  BuildContext? context; // context bağlam
  var _istikametler = {
    '/main':(context) => MyApp(),//ilerde değişecek
  };

  String _baslaticiIstikamet = "/";

  Istikametler(BuildContext context){
    this.context = context;
  }

  Map get()=> _istikametler;

  String initialGet()=>_baslaticiIstikamet;
}