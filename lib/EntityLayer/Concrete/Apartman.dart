import '../Concrete/Entity.dart';

class Apartman extends Entity {
  String? _Ad;
  String? _Ilce;
  String? _Il;
  String? _Ulke;

  /*** Get ve set methodları***/
  String? GetAd() => _Ad;

  String? GetIlce() => _Ilce;

  String? GetIl() => _Il;

  String? GetUlke() => _Ulke;

  void SetAd(String? value) => _Ad = value;

  void SetIlce(String? value) => _Ilce = value;

  void SetIl(String? value) => _Il = value;

  void SetUlke(String? value) => _Ulke = value;

  /*** get ve set methodları bitiş ***/

  /*** Sınıfa özel yazılacak***/
  @override
  Apartman.cevirJsonMapdanNesne(Map<String, dynamic> json) : super.cevirJsonMapdanNesne(json) {
    _Ad = json["Ad"].toString();
    _Ilce = json["Ilce"].toString();
    _Il = json["Il"].toString();
    _Ulke = json["Ulke"].toString();
  }

  @override
  Map<String, dynamic> cevirNesnedenJsonMap() {
    Map<String, dynamic> result = super.cevirNesnedenJsonMap();
    result.addAll({"Ad": _Ad, "Ilce": _Ilce, "Il": _Il, "Ulke": _Ulke});

    return result;
  }
/*** Sınıfa özel yazılacak bitiş***/
}
