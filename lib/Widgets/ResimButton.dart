import 'package:flutter/material.dart';

class ResimButton extends StatelessWidget {
  String image;
  void Function()? onTap;
  ResimButton(this.image,{Key? key,this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Image(
        image: AssetImage(image),
      ),
      onTap: onTap,

    );
  }
}
