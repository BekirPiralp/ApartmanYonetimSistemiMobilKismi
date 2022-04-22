import 'package:objectid/objectid.dart';

import '../Concrete/Entity.dart';

class GiderTip extends Entity{

  GiderTip.set({String ad = "Diğer",String aciklama = "Açıklama",ObjectId? id,int sNo=0,bool silDurum = false}):super.set(id: id,sNo: sNo,silDurum: silDurum){
    this._Ad = ad;
    this._Aciklama = aciklama;
  }

  String _Ad ="";
  String _Aciklama ="";
  /*** get ve set metodaları***/
  String AdGet()=>_Ad;
  String AciklamaGet()=>_Aciklama;

  void AdSet(String value) => _Ad = value;
  void AciklamaSet(String value) => _Aciklama = value;
  /*** get ve set metodaları bitiş***/

  /*** Sınıfa özel yazılacak***/
  @override
  GiderTip.cevirJsonMapdanNesne(Map<String, dynamic> json):super.cevirJsonMapdanNesne(json) {
    _Ad = json["Ad"];
    _Aciklama = json["Aciklama"];
  }

  @override
  Map<String, dynamic> cevirNesnedenJsonMap() {
    var result = super.cevirNesnedenJsonMap();
    result.addAll({
      "Ad":_Ad,
      "Aciklama":_Aciklama
    });
    return result;
  }
  /*** Sınıfa özel yazılacak bitiş***/
}