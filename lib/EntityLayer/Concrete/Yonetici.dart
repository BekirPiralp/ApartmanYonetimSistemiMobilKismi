import '../Concrete/Entity.dart';

class Yonetici extends Entity {
  int _Apartman = 0;
  int _DaireSakini = 0;

  /*** Get ve set ***/
  int ApartmanGet() => _Apartman;

  int DaireSakiniGet() => _DaireSakini;

  void ApartmanSet(int value) => _Apartman = value > 0 ? value : 0;

  void DaireSakiniSet(int value) => _DaireSakini = value > 0 ? value : 0;

  /*** Get ve set bitiş ***/

  /*** Sınıfa özel yazılacak***/
  @override
  Yonetici.cevirJsonMapdanNesne(Map<String, dynamic> json) : super.cevirJsonMapdanNesne(json) {
    _Apartman = int.parse(json["Apartman"].toString());
    _DaireSakini = int.parse(json["DaireSakini"].toString());
  }

  @override
  Map<String, dynamic> cevirNesnedenJsonMap() {
    var result = super.cevirNesnedenJsonMap();
    result.addAll({"Apartman": _Apartman, "DaireSakini": _DaireSakini});
    return result;
  }
/*** Sınıfa özel yazılacak bitiş***/
}
