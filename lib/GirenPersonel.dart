import 'package:apartman_yonetim_sistemi/EntityLayer/Concrete/DaireSakini.dart';
import 'package:apartman_yonetim_sistemi/EntityLayer/Concrete/Yonetici.dart';

class GirenPersonel{
  GirenPersonel._();
  static Yonetici? _yonetici;
  static DaireSakini? _daireSakini;
  static setYonetici(Yonetici yonetici){
    _yonetici = yonetici;
  }
  static setDaireSakini(DaireSakini daireSakini){
    _daireSakini = daireSakini;
  }

  static Yonetici? getYonetici()=>_yonetici;
  static DaireSakini? getDaireSakini() => _daireSakini;
}