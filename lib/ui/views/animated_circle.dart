import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ripple_animation/ui/shared/globals.dart';
import 'package:ripple_animation/viewmodels/home_model.dart';

class AnimatedCircle extends AnimatedWidget {
  final Tween<double> tween;
  Tween<double>? horizontalTween;
  final Animation<double> animation;
  Animation<double>? horizontalAnimation;
  final double flip;
  final Color color;

  AnimatedCircle({
    Key? key,
    required this.animation,
    this.horizontalTween,
    this.horizontalAnimation,
    required this.color,
    required this.flip,
    required this.tween,
  })  : assert(flip == 1 || flip == -1),
        super(key: key, listenable: animation);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeModel>(context);
    // print(' tween.evaluate(animation) : ${tween.evaluate(animation)}');
    return Transform(
      alignment: FractionalOffset.centerLeft,
      transform: Matrix4.identity()
        ..scale(
          tween.evaluate(animation) * flip,
          tween.evaluate(animation),
        ),
      child: Transform(
        transform: Matrix4.identity()
          ..translate(
            horizontalTween != null ? horizontalTween!.evaluate(horizontalAnimation!) : 0.0,
          ),
        child: Container(
          width: Global.radius,
          height: Global.radius,
          decoration: BoxDecoration(
            color: flip == 1
                ? color
                : model.isHalfWay
                    ? Colors.purple
                    : color,
            borderRadius: BorderRadius.circular(
              Global.radius / 2.0 - tween.evaluate(animation) / (Global.radius / 2.0),
            ),
          ),
          child: Icon(
            flip == 1 ? Icons.keyboard_arrow_right : Icons.keyboard_arrow_left,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

// @override
// Widget build(BuildContext context) {
//   final model = Provider.of<HomeModel>(context);
//   return Transform(
//     alignment: FractionalOffset.centerLeft,
//     transform: Matrix4.identity()
//       ..scale(
//         tween.evaluate(animation) * flip,
//         tween.evaluate(animation),
//       ),
//     child: Transform(
//       transform: Matrix4.identity()
//         ..translate(
//           horizontalTween != null ? horizontalTween!.evaluate(horizontalAnimation!) : 0.0,
//         ),
//       child: Container(
//         width: Global.radius,
//         height: Global.radius,
//         decoration: BoxDecoration(
//           color: color,
//           borderRadius: BorderRadius.circular(
//             Global.radius / 2.0 - tween.evaluate(animation) / (Global.radius / 2.0),
//           ),
//         ),
//         child: Icon(
//           flip == 1 ? Icons.keyboard_arrow_right : Icons.keyboard_arrow_left,
//           color: model.index % 2 == 0 ? Global.white : Global.mediumBlue,
//         ),
//       ),
//     ),
//   );
// }
}
