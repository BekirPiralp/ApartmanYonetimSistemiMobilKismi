import 'package:apartman_yonetim_sistemi/EntityLayer/WebServisConnection.dart';
import 'package:apartman_yonetim_sistemi/Widgets/Tamalandi.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

import '../Widgets/IconGenisButton.dart';

class UrlAyarla extends StatefulWidget {
  const UrlAyarla({Key? key}) : super(key: key);

  @override
  State<UrlAyarla> createState() => _UrlAyarlaState();
}
String? _host;
int _port=0;
class _UrlAyarlaState extends State<UrlAyarla> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(child: Text(WebServisConnection.Url),),
            SizedBox(height: 30,),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Host",
              ),
              keyboardType: TextInputType.url,
              onChanged: (value)=>_host=value,
            ),
            SizedBox(height: 30,),
            TextFormField(
              decoration: InputDecoration(
                  labelText: "Port",
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[0123456789]')),
              ],
              onChanged: (value)=>_port=int.parse(value),
            ),
            SizedBox(height: 30,),
            Container(
              height: 50,
              child: Row(
                children: [
                  Expanded(
                    child: IconGenisButton(
                      "resimler/cancel.png",
                      color: Colors.grey.shade300,
                      text: Text(
                        "iptal",
                        style: TextStyle(fontSize: 20),
                      ),
                      onPress: () {
                        setState(() {
                          _port=0;
                          _host=null;
                          Navigator.of(context).pop();
                        });
                      },
                    ),
                  ),
                  Expanded(
                    child: IconGenisButton(
                      "resimler/tamam.png",
                      text: const Text(
                        "Kaydet",
                        style: TextStyle(fontSize: 20),
                      ),
                      color: Colors.grey.shade300,
                      onPress: () {
                        setState(() {
                          if(_host != null && _host!.isNotEmpty){
                            WebServisConnection().host = _host!;
                            WebServisConnection().port = _port;
                            setState(() {
                              Navigator.of(context).pop();
                              showDialog(context: context, builder: (context)=>Basarili());
                            });
                          }else{
                            setState(() {
                              showDialog(context: context, builder: (context)=>HataOlustu(messaj: "Lütfen bilgileri eksiksiz giriniz",));
                              showDialog(context: context, builder: (context)=>Basarisiz());
                            });
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),),
          ],
        ),
      ),
    );
  }
}
