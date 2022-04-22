import 'package:apartman_yonetim_sistemi/Widgets/GenisButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Basarili extends StatefulWidget {
  const Basarili({Key? key}) : super(key: key);

  @override
  State<Basarili> createState() => _BasariliState();
}

class _BasariliState extends State<Basarili> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30))
        ),
        width: MediaQuery
            .of(context)
            .size
            .width * 2 / 3,
        height: MediaQuery
            .of(context)
            .size
            .width * 2 / 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("resimler/tamam.png", width: 40, height: 40,),
            Text("İşleminiz Başarıyla Tamamlandı",
              style: TextStyle(fontSize: 20),),
            GenisButton("Tamam", () {
              setState(() {
                Navigator.of(context).pop();
              });
            }),
          ],
        ),
      ),
    );
  }
}

class Basarisiz extends StatefulWidget {
  const Basarisiz({Key? key}) : super(key: key);

  @override
  State<Basarisiz> createState() => _BasarisizState();
}

class _BasarisizState extends State<Basarisiz> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30))
        ),
        width: MediaQuery
            .of(context)
            .size
            .width * 2 / 3,
        height: MediaQuery
            .of(context)
            .size
            .width * 2 / 3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: 10,),
            SizedBox(width:50,height: 50,child: Image(image:AssetImage("resimler/cancel.png"),fit: BoxFit.fill,)),
            Text("İşleminiz Tamamlanmadı!", style: TextStyle(fontSize: 20),),
            GenisButton("Tamam", () {
              setState(() {
                Navigator.of(context).pop();
              });
            }),
          ],
        ),
      ),
    );
  }
}

class HataOlustu extends StatefulWidget {
  HataOlustu({Key? key, this.messaj = "Bilinmeyen",}) : super(key: key);
  String messaj;

  @override
  State<HataOlustu> createState() => _HataOlustuState(messaj);
}

class _HataOlustuState extends State<HataOlustu> {
  String messaj;

  _HataOlustuState(this.messaj);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      child: Container(
        width: MediaQuery.of(context).size.width * (2 / 3),
        height: MediaQuery.of(context).size.width * (4 / 5),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30))
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, color: Colors.red, size: 40,),
            SizedBox(height: 10,),
            Expanded(
              child: ListView(
                children: [
                    Container(
                      child: Text(
                        "Hata oluştu!. Detay:\n${messaj}",
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            ),

            SizedBox(height: 10,),
            GenisButton("Tamam", (){
              setState(() {
                Navigator.of(context).pop();
              });
            }),
          ],
        ),
      ),
    );
  }
}


