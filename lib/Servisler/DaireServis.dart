import 'dart:convert';

import 'package:apartman_yonetim_sistemi/EntityLayer/WebServisConnection.dart';

import '../EntityLayer/Concrete/DaireSakini.dart';
import '../EntityLayer/Concrete/Daire.dart';
import 'package:http/http.dart' as http;

class DaireServisi {
  Future<bool> DaireTanimlaNesne(
      int apartman, DaireSakini daireSakini, Daire daire) async {
    bool result = false;
    try {
      Map<String, dynamic> queryparams = {"apartman": apartman};
      queryparams.addAll(daireSakini
          .cevirNesnedenJsonMap()); //body den alına bilir duruma göre değişe bilir
      queryparams.addAll(daire.cevirNesnedenJsonMap()); //body den alına bilir
      http.Response response = await http.post(
          WebServisConnection.UrlDaireTanimlaNesne(queryparams),
          headers: WebServisConnection.baslik);

      if (response.statusCode == ResponseKod.basarili) {
        result = true;
      } else if (response.statusCode == ResponseKod.serverError) {
        throw Exception("Sunucu tarafı hata oluştu. Hata:\n" +
            jsonDecode(response.body).toString());
      }
    } catch (hata) {
      throw Exception("Daire tanımlanırken hata oluştu");
    }
    return result;
  }

  Future<bool> DaireTanimlaSno(
      int apartman, DaireSakini daireSakini, int daireSno) async {
    bool result = false;
    try {
      Map<String, dynamic> queryparams = {
        "apartman": apartman,
        "daireSNO": daireSno
      };
      queryparams.addAll(daireSakini
          .cevirNesnedenJsonMap()); //body den alına bilir duruma göre değişe bilir

      http.Response response = await http.post(
          WebServisConnection.UrlDaireTanimlaSno(queryparams),
          headers: WebServisConnection.baslik);

      if (response.statusCode == ResponseKod.basarili) {
        result = true;
      } else if (response.statusCode == ResponseKod.serverError) {
        throw Exception("Sunucu tarafı hata oluştu. Hata:\n" +
            jsonDecode(response.body).toString());
      }
    } catch (hata) {
      throw Exception("Daire tanımlanırken hata oluştu");
    }
    return result;
  }
}
