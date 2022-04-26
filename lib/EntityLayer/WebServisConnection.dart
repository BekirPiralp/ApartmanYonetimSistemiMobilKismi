import 'dart:developer';

class WebServisConnection {
  static const String _scheme = "http://";
  static int _port = 80;
  static String _host = "127.0.0.1";

  static String get Url {
    return _port >= 1 && _port < 65535
        ? _scheme + _host + "/"
        : _scheme + _host + ":" + _port.toString() + "/";
  }

  /// value >0 < 65535
  set port(int value) {
    _port = value;
  }

  /// value = lochalhost or deneme.com or abc.net.org ...
  set host(String value) => _host = value;

  static String getAddPath(String path) {
    return _port > 0 && _port < 65535
        ? _scheme + _host + "/" + path
        : _scheme + _host + ":" + _port.toString() + "/" + path;
  }

  static const Map<String, String> baslik = {
    "Contetnt-Type": "application/json",
  };

  static String get Tahakkuk => Url + "tahakkuk/";

  //static get UrlTahakkukAidatTanimla => {Uri.parse(Tahakkuk + "aidat/tanimla")};
  static Uri UrlTahakkukAidatTanimla(Map<String, dynamic>? queryparams) {
    return _uri(queryparams, Uri.parse(Tahakkuk + "aidat/tanimla"));
  }

  static Uri UrlTahakkukAidatGetir(Map<String, dynamic>? queryparams) {
    return _uri(queryparams, Uri.parse(Tahakkuk + "aidat/getir"));
  }

  //static get UrlTahakkukAidatGetir => {Uri.parse(Tahakkuk + "aidat/getir")};

  static Uri UrlTahakkukGerceklestir(Map<String, dynamic>? queryparams) {
    return _uri(queryparams, Uri.parse(Tahakkuk + "gerceklestir"));
  }

  static String get Giris => Url + "giris/";

  static Uri UrlGirisYonetici(Map<String, dynamic>? queryparams) =>
      _uri(queryparams, Uri.parse(Giris + "getir/yonetici"));

  static Uri UrlGirisDaireSakini(Map<String, dynamic>? queryparams) =>
      _uri(queryparams, Uri.parse(Giris + "getir/daire_sakini"));

  static String get Gider => Url + "gider/";

  static Uri UrlGiderOlustur(Map<String, dynamic>? queryparams) =>
      _uri(queryparams,Uri.parse(Gider + "olustur"));

  static Uri UrlGiderOlusturOzel(Map<String, dynamic>? queryparams) =>
      _uri(queryparams,Uri.parse(Gider + "olustur_ozel"));

  static Uri UrlGiderGetir(Map<String, dynamic>? queryparams) =>
      _uri(queryparams,Uri.parse(Gider + "getir"));

  static Uri UrlGiderDonemGetir(Map<String, dynamic>? queryparams) =>
  _uri(queryparams,Uri.parse(Gider + "donem_getir"));

  static String get Daire => Url + "daire/";

  static Uri UrlDaireTanimlaNesne(Map<String, dynamic>? queryparams) =>
      _uri(queryparams,Uri.parse(Daire + "tanimla/nesne"));

  static Uri UrlDaireTanimlaSno(Map<String, dynamic>? queryparams) =>
      _uri(queryparams,Uri.parse(Daire.toString() + "tanimla/sno"));

  static Uri UrlDaireSakinleriGetir(Map<String,dynamic> queryparams) =>
      _uri(queryparams,Uri.parse(Daire.toString()+"getir"));

  static String get Borc => Url + "borc/";

  static Uri UrlBorcOdenmemis(Map<String, dynamic>? queryparams) =>
      _uri(queryparams,Uri.parse(Borc + "Odenmemis"));

  static Uri UrlBorcHepsi(Map<String, dynamic>? queryparams) =>
      _uri(queryparams,Uri.parse(Borc + "hepsi"));

  static Uri UrlBorcBorclular(Map<String, dynamic>? queryparams) =>
      _uri(queryparams,Uri.parse(Borc + "borclular"));

  static Uri UrlBorcToplam(Map<String, dynamic>? queryparams) =>
      _uri(queryparams,Uri.parse(Borc + "toplam"));

  static Uri UrlBorcOde(Map<String, dynamic>? queryparams) =>
      _uri(queryparams,Uri.parse(Borc + "ode"));

  static Uri _uri(Map<String, dynamic>? params, Uri url) {
    Map<String, dynamic>? _params ;
    if(params != null)
      _params= Map<String,dynamic>();
    params?.forEach((key, value) {
      if(value == null){
        _params!.addAll({key:'null'});
      }else{
        _params!.addAll({key:value.toString()});
      }
    });
    if (params == null) return url;
    Uri result = Uri(
        scheme: url.scheme.toString(),
        host: url.host.toString(),
        port: url.port.toInt(),
        path: url.path.toString(),
        queryParameters: _params ?? null);

    return result;
  }
}

class ResponseKod{
  static const int basarili = 200;
  static const int serverError = 500;
}
