import 'dart:convert';
import 'dart:io';

import 'package:apartman_yonetim_sistemi/EntityLayer/Concrete/DaireSakini.dart';
import 'package:apartman_yonetim_sistemi/EntityLayer/WebServisConnection.dart';
import 'package:decimal/decimal.dart';

import '../EntityLayer/Concrete/Borc.dart';
import 'package:http/http.dart' as http;

class BorcServis {
  Future<List<Borc>?> BorcOdenmemis(int apartman, int daireSakini) async {
    List<Borc>? result;
    try {
      http.Response response = await http.get(
          WebServisConnection.UrlBorcOdenmemis(
              {"Apartman": apartman, "DaireSakini": daireSakini}),
          headers: WebServisConnection.baslik);

      if (response.statusCode == ResponseKod.basarili) {
        List responseJson = jsonDecode(response.body);
        if (responseJson.isNotEmpty) {
          result = responseJson
              .map((json) => Borc.cevirJsonMapdanNesne(json))
              .toList();
        }
      } else if (response.statusCode == ResponseKod.serverError) {
        throw Exception("Sunucu tarafı hata oluştu. Hata:\n" +
            jsonDecode(response.body).toString());
      }else{
        throw SocketException("");
      }
    } on SocketException
    {
      throw SocketException("Bağlantı hatası oluştu");
    }catch (hata) {
      throw Exception("Ödenmemiş borçlar getirilirken hata oluştu");
    }
    return result;
  }

  Future<List<Borc>?> BorcHepsi(int apartman, int daireSakini) async {
    List<Borc>? result;
    try {
      http.Response response = await http.get(
          WebServisConnection.UrlBorcHepsi(
              {"Apartman": apartman, "DaireSakini": daireSakini}),
          headers: WebServisConnection.baslik);

      if (response.statusCode == ResponseKod.basarili) {
        List responseJson = jsonDecode(response.body);
        if (responseJson.isNotEmpty) {
          result = responseJson.toList().cast();
        }
      } else if (response.statusCode == ResponseKod.serverError) {
        throw Exception("Sunucu tarafı hata oluştu. Hata:\n" +
            jsonDecode(response.body).toString());
      }else{
        throw SocketException("");
      }
    } on SocketException
    {
      throw SocketException("Bağlantı hatası oluştu");
    }catch (hata) {
      throw Exception("Ödenmemiş borçlar getirilirken hata oluştu");
    }
    return result;
  }

  Future<List<DaireSakini>?> BorcBorclular(int apartman) async {
    List<DaireSakini>? result;
    try {
      http.Response response = await http.get(
          WebServisConnection.UrlBorcBorclular({"Apartman": apartman}),
          headers: WebServisConnection.baslik);

      if (response.statusCode == ResponseKod.basarili) {
        List responseJson = jsonDecode(response.body);
        if (responseJson.isNotEmpty) {
          result = responseJson
              .map((jsonObj) => DaireSakini.cevirJsonMapdanNesne(jsonObj))
              .toList();
        }
      } else if (response.statusCode == ResponseKod.serverError) {
        throw Exception("Sunucu tarafı hata oluştu. Hata:\n" +
            jsonDecode(response.body).toString());
      }else{
        throw SocketException("");
      }
    } on SocketException
    {
      throw SocketException("Bağlantı hatası oluştu");
    }catch (hata) {
      throw Exception("Borclular getirilirken hata oluştu");
    }
    return result;
  }

  Future<Decimal> BorcToplam(int apartman, int daireSakini) async {
    Decimal result = Decimal.zero;
    try {
      http.Response response = await http.get(WebServisConnection.UrlBorcToplam(
          {"Apartman": apartman, "DaireSakini": daireSakini}),
          headers: WebServisConnection.baslik);

      if (response.statusCode == ResponseKod.basarili) {
        var json = jsonDecode(response.body);
        result = Decimal.fromJson(json);
      } else if (response.statusCode == ResponseKod.serverError) {
        throw Exception("Sunucu tarafı hata oluştu. Hata:\n" +
            jsonDecode(response.body).toString());
      }else{
        throw SocketException("");
      }
    } on SocketException
    {
      throw SocketException("Bağlantı hatası oluştu");
    }catch (hata) {
      throw Exception("Toplam borç getirilirken hata oluştu");
    }
    return result;
  }

  Future<bool> BorcOde(Decimal odemeTutari, int apartman,
      int daireSakini) async {
    bool result = false;
    try {
      var queryparams = {
        "OdemeTutari": odemeTutari,
        "Apartman": apartman,
        "DaireSakini": daireSakini
      };
      http.Response response = await http.post(
          WebServisConnection.UrlBorcOde(queryparams),
          headers: WebServisConnection.baslik);

      if (response.statusCode == ResponseKod.basarili) {
        result = true;
      } else if (response.statusCode == ResponseKod.serverError) {
        throw Exception("Sunucu tarafı hata oluştu. Hata:\n" +
            jsonDecode(response.body).toString());
      }else{
        throw SocketException("");
      }
    }on SocketException
    {
      throw SocketException("Bağlantı hatası oluştu");
    }catch (hata) {
      throw Exception("Borç ödeme esnasında hata oluştu");
    }
    return result;
  }
}
