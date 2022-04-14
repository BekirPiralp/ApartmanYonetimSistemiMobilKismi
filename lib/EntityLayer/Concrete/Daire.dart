import '../Concrete/Entity.dart';

class Daire extends Entity{

  int _Apartman =0;
  int _KapiNo =0;

  /*** Get ve set ***/
    int ApartmanGet()=> _Apartman;
    int KapiNoGet()=> _KapiNo;

    void ApartmanSet(int value) => _Apartman = value >0? value:0;
    void KapiNoSet(int value) => _KapiNo = value >0? value:0;
  /*** Get ve set bitiş ***/

  /*** Sınıfa özel yazılacak***/
  @override
  Daire.cevirJsonMapdanNesne(Map<String, dynamic> json):super.cevirJsonMapdanNesne(json) {
    _Apartman = int.parse(json["Apartman"].toString());
    _KapiNo = int.parse(json["KapiNo"].toString());
  }
  @override
  Map<String, dynamic> cevirNesnedenJsonMap() {
    var result = super.cevirNesnedenJsonMap();
    result.addAll({
      "Apartman":_Apartman,
      "KapiNo":_KapiNo
    });

    return result;
  }

  /*** Sınıfa özel yazılacak bitiş***/
}