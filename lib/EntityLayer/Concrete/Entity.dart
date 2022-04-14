import '../Abstract/IEntity.dart';
import 'package:objectid/objectid.dart';

class Entity implements IEntity{
  ObjectId ?_id ; //? işareti null olabilir demek
  int _SNo = 0; // default sıfır lakin normalda 0> olması lazım //_ işareti private
  bool _SilDurum = false;

  /** Get ve set methodları **/
    ObjectId? IDGet()=> _id;
    void IDSet({ObjectId? value})=> _id = value;

    int SNoGet()=> _SNo;
    void SNoSet({int value = 0})=> _SNo = value;

    bool SilDurumGet()=>_SilDurum;
    void SilDurumSet({bool value = false}) => _SilDurum = value;
  /** Get ve Set bitiş **/

  Entity();
  Entity.cevirJsonMapdanNesne(Map <String,dynamic> json) { // hepsinde olacak
    _id = ObjectId.fromHexString(json["_id"].toString());
    _SNo = int.parse(json["SNo"].toString());
    _SilDurum = json["SilDurum"].toString().toLowerCase() == (true).toString().toLowerCase();
  }

  @override
  Map<String, dynamic> cevirNesnedenJsonMap() {
    return {"_id":_id,
    "SNo":_SNo,
    "SilDurum":_SilDurum};
  }
}