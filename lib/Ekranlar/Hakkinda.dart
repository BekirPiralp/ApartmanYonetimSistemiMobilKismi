import 'package:flutter/material.dart';

class Hakkinda extends StatefulWidget {
  const Hakkinda({Key? key}) : super(key: key);

  @override
  State<Hakkinda> createState() => _HakkindaState();
}

class _HakkindaState extends State<Hakkinda> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("H A K K I N D A"),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                child: const Center(
                  child: Text(
                      "Tüm alemlerin Rabbi olan Allah(cc)'a hamdolsun. \n\nSelçuk Üniversitesi'nin Bilgisayar Mühendisliği Bölümünde verilen Staj 1 Dersi kapsamında yapılmıştır."
                          " Yardımları ve desteklerinden dolayı Salih Abiye, Tarık Abiye, Figen Ablaya, Emrah Abiye ve Seyhan Belediyesine son olarak "
                          "bize bu eğitimi veren Selçuk Üniversitesi ve öğretim elemanlarına en içten teşekkürlerimi eder saygılarımı sunarım.",
                    style: TextStyle(
                      fontSize: 25,
                      fontFamily: "TimesNewRoman"
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10,),
            Container(
              child: const Text("Not: Güvenlik ve diğer sebepler sebebiyle soy isimleri yazılmamıştır.",
              style: TextStyle(fontSize: 17.5),),
            ),
            SizedBox(height: 10,),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: const Text(
                      "Bekir PİRALP",
                      style: TextStyle(
                          fontSize: 25,
                          fontFamily: "TimesNewRoman"
                      ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
