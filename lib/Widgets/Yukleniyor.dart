import 'package:flutter/material.dart';

class Yukleniyor extends StatefulWidget {
  const Yukleniyor({Key? key}) : super(key: key);

  @override
  State<Yukleniyor> createState() => _YukleniyorState();
}

class _YukleniyorState extends State<Yukleniyor> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>await false,
      child: Container(
        color: Colors.transparent,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(30))
            ),
            width: MediaQuery.of(context).size.width*2/3,
            height: MediaQuery.of(context).size.width*2/3,
            child: Stack(children: [
              Positioned(
                left: 0,
                top: 0,
                child: SizedBox(width: MediaQuery.of(context).size.width*2/3,
                    height: MediaQuery.of(context).size.width*2/3,
                    child: CircularProgressIndicator(strokeWidth: 10,)),
              ),
              Positioned(child: Center(child: Text("Yükleniyor...",style: TextStyle(fontSize: 20),))),
            ]),
          ),
        ),
      ),
    );
  }
}
