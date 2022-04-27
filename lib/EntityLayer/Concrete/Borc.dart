import 'package:decimal/decimal.dart';

import 'Entity.dart';

class Borc extends Entity{

  Borc():super();

  int _Apartman =0;
  int _DaireSakini =0;
  Decimal _BorcMiktari = Decimal.zero;
  Decimal _OdemeMiktari = Decimal.zero;
  Decimal _Kalan = Decimal.zero;
  int _Ay = 0;
  int _Yil = 0;

  /*** Get ve set ***/
    int ApartmanGet()=> _Apartman;
    int DaireSakiniGet()=> _DaireSakini;
    Decimal BorcMiktariGet()=> _BorcMiktari;
    Decimal OdemeMiktariGet()=> _OdemeMiktari;
    Decimal KalanGet()=> _Kalan;
    int AyGet()=> _Ay;
    int YilGet()=> _Yil;

    void ApartmanSet(int value) => _Apartman = value >0? value:0;
    void DaireSakiniSet(int value)=> _DaireSakini = value >0? value:0;
    void BorcMiktariSet(Decimal value)=> _BorcMiktari = value;
    void OdemeMiktariSet(Decimal value)=> _OdemeMiktari = value;
    void KalanSet(Decimal value)=> _Kalan = value;
    void AySet(int value)=> _Ay = value >=1 && value<=12 ? value:0;
    void YilSet(int value) => _Yil = value;
  /*** Get ve set bitiş ***/
  
  /*** Sınıfa özel yazılacak***/
  @override
  Borc.cevirJsonMapdanNesne(Map <String,dynamic> json) : super.cevirJsonMapdanNesne(json){
    _Yil = int.parse(json["Yil"].toString());//işimizi sağlama alalım diye sitring sonra int
    _Ay = int.parse(json["Ay"].toString());
    _Apartman = int.parse(json["Apartman"].toString());
    _DaireSakini = int.parse(json["DaireSakini"].toString());
    _OdemeMiktari = Decimal.parse(json["OdemeMiktari"].toString());
    _BorcMiktari = Decimal.parse(json["BorcMiktari"].toString());
    _Kalan = Decimal.parse(json["Kalan"].toString());
  }

  @override
  Map<String, dynamic> cevirNesnedenJsonMap() {
    Map<String, dynamic> result = super.cevirNesnedenJsonMap();
    result.addAll({
      "Yil":_Yil,
      "Ay":_Ay,
      "Apartman":_Apartman,
      "DaireSakini":_DaireSakini,
      "OdemeMiktari":_OdemeMiktari.toJson(),
      "BorcMiktari":_BorcMiktari.toJson(),
      "Kalan":_Kalan.toJson()
    });

    return result;
  }
  /*** Sınıfa özel yazılacak bitiş***/
}