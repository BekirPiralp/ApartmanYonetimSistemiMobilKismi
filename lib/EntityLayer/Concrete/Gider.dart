import 'package:decimal/decimal.dart';
import 'package:objectid/objectid.dart';

import '../Concrete/Entity.dart';

class Gider extends Entity{
  int _Apartman = 0;
  Decimal _Tutar = Decimal.zero;
  int _Ay =0;
  int _Yil =0;
  int _Tip =0;

  Gider.set({int apartman=0,Decimal? tutar,int ay =0,int yil=0,int tip = 0,ObjectId? id,int sNo=0,bool silDurum = false}):super.set(id: id,silDurum: silDurum,sNo: sNo){
    this._Apartman = apartman;
    this._Tutar = tutar??Decimal.zero;
    this._Ay =ay;
    this._Yil =yil;
    this._Tip =tip;
  }

  /*** get ve set metodaları***/
  int ApartmanGet()=> _Apartman;
  Decimal TutarGet() => _Tutar;
  int AyGet() => _Ay;
  int YilGet() => _Yil;
  int TipGet() => _Tip;

  void ApartmanSet(int value) => _Apartman = value > 0 ? value:0;
  void TutarSet(Decimal value) => _Tutar = value;
  void AySet(int value) => _Ay = value >= 1 && value<=12 ? value:0; //1 ile 12 de dahil arası değilse
  void YilSet(int value) => _Yil = value;
  void TipSet(int value) => _Tip = value > 0 ? value:0;
  /*** get ve set metodaları bitiş***/

  /*** Sınıfa özel yazılacak***/
  @override
  Gider.cevirJsonMapdanNesne(Map<String, dynamic> json):super.cevirJsonMapdanNesne(json){
    _Apartman = int.parse(json["Apartman"].toString());
    _Tutar = Decimal.fromJson(json["Tutar"].toString());
    _Ay = int.parse(json["Ay"].toString());
    _Yil = int.parse(json["Yil"].toString());
    _Tip = int.parse(json["Tip"].toString());
  }
  @override
  Map<String, dynamic> cevirNesnedenJsonMap() {
    var result = super.cevirNesnedenJsonMap();
    result.addAll({
      "Apartman":_Apartman,
      "Tutar":_Tutar.toJson(),
      "Ay":_Ay,
      "Yil":_Yil,
      "Tip":_Tip
    });
    return result;
  }
  /*** Sınıfa özel yazılacak bitiş***/
}