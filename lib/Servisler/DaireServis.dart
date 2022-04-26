import 'dart:convert';
import 'dart:io';

import 'package:apartman_yonetim_sistemi/EntityLayer/WebServisConnection.dart';

import '../EntityLayer/Concrete/DaireSakini.dart';
import '../EntityLayer/Concrete/Daire.dart';
import 'package:http/http.dart' as http;

class DaireServisi {
  Future<bool> DaireTanimlaNesne(int apartman, DaireSakini daireSakini, Daire daire) async {
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
      }else{
        throw SocketException("");
      }
    } on SocketException {
      throw SocketException("Bağlantı hatası oluştu");
    } catch (hata) {
      throw Exception("Daire tanımlanırken hata oluştu "+hata.toString());
    }
    return result;
  }

  Future<bool> DaireTanimlaSno(int apartman, DaireSakini daireSakini, int daireSno) async {
    bool result = false;
    try {
      Map<String, dynamic> queryparams = daireSakini.cevirNesnedenJsonMap();

      queryparams.addAll({
        "apartman": apartman,
        "daireSNO": daireSno
      }); //body den alına bilir duruma göre değişe bilir

      http.Response response = await http.post(
          WebServisConnection.UrlDaireTanimlaSno(queryparams),
          headers: WebServisConnection.baslik);

      if (response.statusCode == ResponseKod.basarili) {
        result = true;
      } else if (response.statusCode == ResponseKod.serverError) {
        throw Exception("Sunucu tarafı hata oluştu. Hata:\n" +
            jsonDecode(response.body).toString());
      }else{
        throw SocketException("");
      }
    } on SocketException {
      throw SocketException("Bağlantı hatası oluştu");
    } catch (hata) {
      throw Exception(
          "Daire tanımlanırken hata oluştu.\n Detay ${hata.toString()}");
    }
    return result;
  }

  Future<List<DaireSakini>?> DaireSakinleriGetir(int apartman) async {
    List<DaireSakini>? result;

    Map<String, dynamic> queryparams = {"apartman": apartman};

    try {
      http.Response response = await http.get(
          WebServisConnection.UrlDaireSakinleriGetir(queryparams),
          headers: WebServisConnection.baslik);
      if (response.statusCode == ResponseKod.basarili) {
        List<Map<String,dynamic>> json = List<Map<String,dynamic>>.from(jsonDecode(response.body));

        if (json.isNotEmpty) {
          result = List<DaireSakini>.from(json.map((e) => DaireSakini.cevirJsonMapdanNesne(e)).toList());
        }
      }else if (response.statusCode == ResponseKod.serverError) {
        throw Exception("Sunucu tarafı hata oluştu. Hata:\n" +
            jsonDecode(response.body).toString());
      }else{
        throw SocketException("");
      }
    } on SocketException {
      throw SocketException("Bağlantı hatası oluştu.");
    } catch (hata) {
      throw Exception("Daire sakinleri getirilirken hata oluştu."+hata.toString());
    }

    return result;
  }
}
