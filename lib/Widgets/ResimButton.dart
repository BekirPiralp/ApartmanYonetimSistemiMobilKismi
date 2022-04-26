import 'package:flutter/material.dart';

class ResimButton extends StatelessWidget {
  String image;
  void Function()? onTap;
  ResimButton(this.image,{Key? key,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        constraints: BoxConstraints(minWidth: 40,minHeight: 40),
        child: Image(
          image: AssetImage(image),
        ),
      ),
      onTap: onTap,

    );
  }
}
