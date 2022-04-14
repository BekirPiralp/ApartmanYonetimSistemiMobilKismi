import 'package:flutter/material.dart';

class IconGenisButton extends StatefulWidget {
  IconGenisButton(this.imagePath,{Key? key,this.color=Colors.white,this.text=const Text(""),this.onPress}) : super(key: key);

  String imagePath;
  Text text;
  Color color;
  void Function()? onPress;
  @override
  State<IconGenisButton> createState() => IconGenisButtonState(color,imagePath,text, onPress);
}

class IconGenisButtonState extends State<IconGenisButton> {
  IconGenisButtonState(this.renk,this.image,this.text,this.onPress):super(){
    _color = renk;
  }
  Color _color = Colors.white;
  Color renk;
  String image;
  Text text;
  //Image _image;
  void Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (value){onTapDown();},
      onTapUp: (value){onTapUp();},
      onTap: onPress,
      child: SizedBox(
        height: 60,
        child: Container(
          margin: EdgeInsets.all(8),
          padding: EdgeInsets.only(left: 10,right: 10),
          decoration: BoxDecoration(
            color: _color,
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(40), right: Radius.circular(40)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Image(image: AssetImage(image)),SizedBox(width: 10,), text],
          ),
        ),
      ),
    );
  }

  void onTapDown() {
    setState(() {
      _color = renk.withOpacity(0.5);
    });
  }

  void onTapUp() {
    setState(() {
      _color = renk;
    });
  }
}
