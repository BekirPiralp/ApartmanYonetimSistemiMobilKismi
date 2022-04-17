import 'package:flutter/material.dart';

class DefterEffectSag extends StatefulWidget {
  DefterEffectSag({Key? key,this.color = Colors.black,this.width = 1,this.height = 1,this.radius=30}) : super(key: key);
  Color color;
  double height,width,radius;
  @override
  State<DefterEffectSag> createState() => _DefterEffectSagState(color,height,width,radius);
}

class _DefterEffectSagState extends State<DefterEffectSag> {
  _DefterEffectSagState(this.color,this.height,this.width,this.radius);
  Color color;
  double height,width,radius;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(radius),
          topLeft: Radius.circular(radius),
        )
      ),
    );
  }
}

class DefterEffectSol extends StatefulWidget {
  DefterEffectSol({Key? key,this.color = Colors.black,this.width = 1,this.height = 1,this.radius = 30}) : super(key: key);
  Color color;
  double height,width,radius;
  @override
  State<DefterEffectSol> createState() => _DefterEffectSolState(color,height,width,radius);
}

class _DefterEffectSolState extends State<DefterEffectSol> {
  _DefterEffectSolState(this.color,this.height,this.width,this.radius);
  Color color;
  double height,width,radius;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(radius),
            topRight: Radius.circular(radius),
          )
      ),
    );
  }
}
