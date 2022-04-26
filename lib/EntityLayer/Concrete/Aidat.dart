
import 'dart:ffi';

import 'package:apartman_yonetim_sistemi/EntityLayer/Concrete/Entity.dart';
import 'package:decimal/decimal.dart';

class Aidat extends Entity{

  Aidat():super();

  int _Apartman = 0;
  Decimal _Tutar = Decimal.fromInt(-1);
  int _Ay = 0;
  int _Yil =0;

  Aidat.set({int apartman=0,Decimal? tutar ,int ay =0,int yil = 0}){
    this._Apartman = apartman;
    this._Tutar = tutar ?? Decimal.zero;
    this._Ay = ay;
    this._Yil = yil;
  }
  /*** get ve set metodaları***/
    int ApartmanGet()=> _Apartman;
    Decimal TutarGet() => _Tutar;
    int AyGet() => _Ay;
    int YilGet() => _Yil;

    void ApartmanSet(int value) => _Apartman = value > 0 ? value:0;
    void TutarSet(Decimal value) => _Tutar = value;
    void AySet(int value) => _Ay = value >= 1 && value<=12 ? value:0; //1 ile 12 de dahil arası değilse
    void YilSet(int value) => _Yil = value;
  /*** get ve set metodaları***/

  /*** Sınıfa özel yazılacak***/


  Aidat.cevirJsonMapdanNesne(Map <String,dynamic> json):super.cevirJsonMapdanNesne(json){
    _Apartman = int.parse(json["Apartman"].toString());
    _Ay = int.parse(json["Ay"].toString());
    _Yil = int.parse(json["Yil"].toString());
    _Tutar = Decimal.parse(json["Tutar"].toString());
    //return result;
  }

  @override
  Map<String, dynamic> cevirNesnedenJsonMap() {
    Map<String, dynamic> result = super.cevirNesnedenJsonMap();
    result.addAll({
      "Apartman":_Apartman,
      "Ay":_Ay,
      "Yil":_Yil,
      "Tutar":_Tutar.toJson()
    });

    return result;
  }
  /*** Sınıfa özel yazılacak bitiş***/
}