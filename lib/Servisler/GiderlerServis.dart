import 'dart:convert';

import 'package:apartman_yonetim_sistemi/EntityLayer/WebServisConnection.dart';
import 'package:decimal/decimal.dart';
import 'package:http/http.dart' as http;

import '../EntityLayer/Concrete/Gider.dart';

class GiderlerServis {
  Future<bool> Olustur(int apartman, Decimal tuttar, int tip) async {
    bool result = false;
    try {
      http.Response response = await http.post(
          WebServisConnection.UrlGiderOlustur(
              {"apartman": apartman, "tutar": tuttar, "tip": tip}),
          headers: WebServisConnection.baslik);

      if (response.statusCode == ResponseKod.basarili) {
        result = true;
      } else if (response.statusCode == ResponseKod.serverError) {
        throw Exception("Sunucu tarafı hata oluştu. Hata:\n" +
            jsonDecode(response.body).toString());
      }
    } catch (hata) {
      throw Exception("Gider oluştururken hata oluştu");
    }
    return result;
  }

  /// return = {response ok == ture error or notfound vs. == false}
  Future<bool> OlusturOzel(int apartman, Decimal tutar, String aciklama) async {
    bool result = false;
    try {
      http.Response response = await http.post(
          WebServisConnection.UrlGiderOlusturOzel(
              {"apartman": apartman, "tutar": tutar, "aciklama": aciklama}),
          headers: WebServisConnection.baslik);

      if (response.statusCode == ResponseKod.basarili) {
        result = true;
      } else if (response.statusCode == ResponseKod.serverError) {
        throw Exception("Sunucu tarafı hata oluştu. Hata:\n" +
            jsonDecode(response.body).toString());
      }
    } catch (hata) {
      throw new Exception("Gider oluştururken hata oluştu");
    }
    return result;
  }

  Future<List<Gider>?> GiderGetir(int apartman) async {
    List<Gider>? result;
    try {
      http.Response response = await http.get(
          WebServisConnection.UrlGiderGetir({"apartman": apartman}),
          headers: WebServisConnection.baslik);

      if (response.statusCode == ResponseKod.basarili) {
        List listJson = jsonDecode(response.body); //dinamic liste
        if (listJson.isNotEmpty) {
          result = listJson.map(_cevirici(json)).toList().cast();
        }
      } else if (response.statusCode == ResponseKod.serverError) {
        throw Exception("Sunucu tarafı hata oluştu. Hata:\n" +
            jsonDecode(response.body).toString());
      } //result null olacağı için tekrar atamaya gerek yok
    } catch (hata) {
      throw new Exception("Giderler gietirilirken hata oluştu");
    }
    return result;
  }

  Future<List<Gider>?> GiderGetirDonem(int apartman, int ay, int yil) async {
    List<Gider>? result;
    try {
      http.Response response = await http.get(
          WebServisConnection.UrlGiderDonemGetir(
              {"apartman": apartman, "ay": ay, "yil": yil}),
          headers: WebServisConnection.baslik);

      if (response.statusCode == ResponseKod.basarili) {
        List listJson = jsonDecode(response.body); //dinamic liste
        if (listJson.isNotEmpty) {
          result = listJson.map(_cevirici(json)).toList().cast();
        }
      } else if (response.statusCode == ResponseKod.serverError) {
        throw Exception("Sunucu tarafı hata oluştu. Hata:\n" +
            jsonDecode(response.body).toString());
      } //result null olacağı için tekrar atamaya gerek yok
    } catch (hata) {
      throw new Exception("Giderler gietirilirken hata oluştu");
    }
    return result;
  }

  dynamic _cevirici(json) =>
      Gider.cevirJsonMapdanNesne(json); // gider nesnesi oluştur
}
