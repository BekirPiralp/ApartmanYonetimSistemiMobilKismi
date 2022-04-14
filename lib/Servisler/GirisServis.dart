import 'dart:convert';

import 'package:apartman_yonetim_sistemi/EntityLayer/Concrete/DaireSakini.dart';
import 'package:apartman_yonetim_sistemi/EntityLayer/Concrete/Yonetici.dart';
import 'package:apartman_yonetim_sistemi/EntityLayer/WebServisConnection.dart';
import 'package:http/http.dart' as http;

class Giris {
  Future<Yonetici?> GetirYonetici(String Tc) async {
    Yonetici? result;

    try {
      http.Response response = await http.get(
          WebServisConnection.UrlGirisYonetici({"TC": Tc}),
          headers: WebServisConnection.baslik);
      if (response.statusCode == ResponseKod.basarili) {
        Map<String, dynamic> json = jsonDecode(response.body);
        result = Yonetici.cevirJsonMapdanNesne(json);
      } else if (response.statusCode == ResponseKod.serverError) {
        throw Exception("Sunucu tarafı hata oluştu. Hata:\n" +
            jsonDecode(response.body).toString());
      } else {
        result = null;
      }
    } catch (hata) {
      throw Exception("Yonetici getirilirken hata oluştu");
    }
    return result;
  }

  Future<DaireSakini?> GetirDaireSakini(String Tc) async {
    DaireSakini? result;
    try {
      http.Response response = await http.get(
          WebServisConnection.UrlGirisDaireSakini({"TC": Tc}),
          headers: WebServisConnection.baslik);
      
      if (response.statusCode == ResponseKod.basarili) {
        Map<String, dynamic> json = jsonDecode(response.body);
        result = DaireSakini.cevirJsonMapdanNesne(json);
      } else if (response.statusCode == ResponseKod.serverError) {
        throw Exception("Sunucu tarafı hata oluştu. Hata:\n" +
            jsonDecode(response.body).toString());
      }
    } catch (hata) {
      throw Exception("Daire Sakini getirilirken hata oluştu");
    }
    return result;
  }
}
