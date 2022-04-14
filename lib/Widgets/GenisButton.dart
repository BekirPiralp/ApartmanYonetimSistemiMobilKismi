import 'dart:ui';

import 'package:flutter/material.dart';
class GenisButton extends StatefulWidget {
  String Text;
  void Function() onPress;
  Color renk;
  GenisButton(this.Text,this.onPress,{Key? key,this.renk=Colors.green}) : super(key: key);

  @override
  State<GenisButton> createState() => GenisButtonState(this.Text,this.onPress,this.renk);
}

class GenisButtonState extends State<GenisButton> {
  String text;
  void Function() onPress;
  Color renk;
  static Color _color=Colors.white;

  GenisButtonState(this.text,this.onPress,this.renk):super(){
    _color=this.renk;
  }
  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTapDown: (value){
        tiklayinca();
      },
      onTapUp: (value){
        cekince();
      },
      child:
      SizedBox(
        width: Size.infinite.width,
        height: 40,
        child: Container(
          decoration: BoxDecoration(
            color: _color,
            borderRadius: const BorderRadius.horizontal(left: Radius.circular(40),right: Radius.circular(40))
          ),
          alignment: Alignment.center,
          child: Text(this.text,style: TextStyle(
            fontFamily: 'OpenDyslexic',
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.bold,
            fontSize: 25,
          ),),
        ),
      ),
    );
  }

  void tiklayinca(){
     setState(() {
      _color=renk.withOpacity(0.5);
    });
  }

  void cekince(){
    setState(() {
      _color=renk;
    });
  }
}



