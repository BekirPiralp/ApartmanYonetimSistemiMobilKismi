import '../Concrete/Entity.dart';

class DaireSakini extends Entity{

  DaireSakini():super();

  int _Apartman=0;
  int _Daire=0;
  String _TC="" ;
  String _Ad="" ;
  String _Soyad="";

  DaireSakini.set({int apartman = 0,int daire = 0,String ad = "",String soyad = "", String tc = ""}){
    this._Apartman = apartman;
    this._Daire = daire;
    this._Ad = ad;
    this._Soyad = soyad;
    this._TC = tc;
  }

  /*** Get ve set ***/
  int ApartmanGet()=> _Apartman;
  int DaireGet()=> _Daire;
  String TCGet()=> _TC;
  String AdGet()=> _Ad;
  String SoyadGet()=> _Soyad;

  void ApartmanSet(int value) => _Apartman = value >0? value:0;
  void DaireSet(int value)=>_Daire =value >0? value:0;
  void TCSet(String value)=>_TC=value;
  void AdSet(String value)=>_Ad=value;
  void SoyadSet(String value)=>_Soyad=value;
  /*** Get ve set bitiş ***/

  /*** Sınıfa özel yazılacak***/
  @override
  DaireSakini.cevirJsonMapdanNesne(Map<String, dynamic> json):super.cevirJsonMapdanNesne(json) {
    _Apartman = int.parse(json["Apartman"].toString());
    _Daire = int.parse(json["Daire"].toString());
    _TC = json["TC"];
    _Ad = json["Ad"];
    _Soyad = json["Soyad"];
  }

  @override
  Map<String, dynamic> cevirNesnedenJsonMap() {
    var result = super.cevirNesnedenJsonMap();
    result.addAll(
      {
        "Apartman": _Apartman,
        "Daire":_Daire,
        "TC":_TC,
        "Ad":_Ad,
        "Soyad":_Soyad
      }
    );
    return result;
  }
  /*** Sınıfa özel yazılacak bitiş***/
}