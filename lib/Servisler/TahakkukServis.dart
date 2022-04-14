import 'dart:convert';

import 'package:apartman_yonetim_sistemi/EntityLayer/Concrete/Aidat.dart';
import 'package:apartman_yonetim_sistemi/EntityLayer/WebServisConnection.dart';
import 'package:decimal/decimal.dart';
import 'package:http/http.dart' as http;

class TahakkukServisi {
  Future<Aidat?> AidatGetir(int apartman) async {
    Aidat? result;

    try {
      var response = await http.get(
          WebServisConnection.UrlTahakkukAidatGetir({"apartman": apartman}),
          //+"?apartman=${apartman}",
          headers: WebServisConnection.baslik);
      if (response.statusCode == ResponseKod.basarili) {
        List decode = jsonDecode(response.body);
        result = decode
            .map((json) => Aidat.cevirJsonMapdanNesne(json))
            .toList()
            .first; // aidat üründe bir veya birçok nesne gelecek

      } else if (response.statusCode == ResponseKod.serverError) {
        throw Exception("Sunucu tarafı hata oluştu. Hata:\n" +
            jsonDecode(response.body).toString());
      }
    } catch (hata) {
      throw Exception("veri getirilirken hata oluştu");
    }
    return result;
  }

  Future<bool> AidatTanimla(int apartman, Decimal tutar) async {
    bool result = false;
    try {
      http.Response response = await http.get(
          WebServisConnection.UrlTahakkukAidatTanimla(
              {"apartman": apartman, "tutar": tutar}),
          //+"?apartman=${apartman}&tutar=${tutar}",
          headers: WebServisConnection.baslik);
      if (response.statusCode == ResponseKod.basarili) {
        result = true;
      } else if (response.statusCode == ResponseKod.serverError) {
        throw Exception("Sunucu tarafı hata oluştu. Hata:\n" +
            jsonDecode(response.body).toString());
      }
    } catch (hata) {
      throw Exception("Aidat Tanımlanırken bir hata oluştu");
    }
    return result;
  }

  Future<bool> Gerceklestir(int apartman) async {
    bool result = false;
    try {
      http.Response response = await http.get(
          WebServisConnection.UrlTahakkukGerceklestir({"apartman": apartman}),
          //+ "?apartman=${apartman}",
          headers: WebServisConnection.baslik);
      if (response.statusCode == ResponseKod.basarili) {
        result = true;
      } else if (response.statusCode == ResponseKod.serverError) {
        throw Exception("Sunucu tarafı hata oluştu. Hata:\n" +
            jsonDecode(response.body).toString());
      }
    } catch (hata) {
      throw Exception("Tahakkuk olusturulurken hata olustu");
    }
    return result;
  }
}
