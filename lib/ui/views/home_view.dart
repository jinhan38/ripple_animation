import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:ripple_animation/ui/shared/globals.dart';
import 'package:ripple_animation/ui/views/animated_circle.dart';
import 'package:ripple_animation/viewmodels/home_model.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  late AnimationController animationController;
  late Animation<double> startAnimation;
  late Animation<double> endAnimation;
  late Animation<double> horizontalAnimation;
  late PageController pageController;

  @override
  void initState() {
    super.initState();

    pageController = PageController();
    animationController = AnimationController(duration: Duration(milliseconds: 2500), vsync: this);

    startAnimation = CurvedAnimation(
      parent: animationController,
      // curve: Interval(0.000, 0.500, curve: Curves.easeInOutQuad),
      curve: Interval(0.000, 0.500, curve: Curves.easeInExpo),
    );

    endAnimation = CurvedAnimation(
      parent: animationController,
      curve: Interval(0.500, 1.000, curve: Curves.easeOutExpo),
    );

    horizontalAnimation = CurvedAnimation(
      parent: animationController,
      curve: Interval(0.750, 1.000, curve: Curves.easeInOutQuad),
    );

    animationController
      ..addStatusListener((status) {
        final model = Provider.of<HomeModel>(context, listen: false);
        if (status == AnimationStatus.completed) {
          model.swapColors();
          animationController.reset();
        }
      })
      ..addListener(() {
        final model = Provider.of<HomeModel>(context, listen: false);
        var value = Tween<double>(begin: 1.0, end: Global.radius).evaluate(animationController);

        // animationController.value 의 value 값은 0 ~ 1사이이다.
        // 이 값들은 animationController 에 설정한 Duration 시간을 계산해서 주어진다
        // Tween의 evaluate에 animationController.value 값을 넣으면 begin과 end 두 개의 값 사이에 있는 것을 반환한다.
        // print('animationController : ${animationController.value}, value : $value');
        if (animationController.value > 0.5) {
          model.isHalfWay = true;
        } else {
          model.isHalfWay = false;
        }
      });
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeModel>(context, listen: false);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: model.isHalfWay ? model.foreGroundColor : model.backGroundColor,
      body: Stack(
        children: <Widget>[
          Container(
            color: model.isHalfWay ? model.foreGroundColor : model.backGroundColor,
            width: screenWidth / 2.0 - Global.radius / 2.0,
            height: double.infinity,
          ),
          Transform(
            transform: Matrix4.identity()
              ..translate(
                screenWidth / 2 - Global.radius / 2.0,
                screenHeight - Global.radius - Global.bottomPadding,
              ),
            child: GestureDetector(
              onTap: () {
                if (animationController.status != AnimationStatus.forward) {
                  model.isToggled = !model.isToggled;
                  model.index++;
                  if (model.index > 3) {
                    model.index = 0;
                  }
                  pageController.animateToPage(model.index, duration: Duration(milliseconds: 2500), curve: Curves.easeInOutQuad);
                  animationController.forward();
                }
              },
              child: Stack(
                children: <Widget>[
                  AnimatedCircle(
                    animation: startAnimation,
                    color: model.foreGroundColor,
                    flip: 1.0,
                    tween: Tween<double>(begin: 1.0, end: Global.radius),
                  ),
                  AnimatedCircle(
                    animation: endAnimation,
                    color: model.backGroundColor,
                    flip: -1.0,
                    horizontalTween: Tween<double>(begin: 0, end: -Global.radius),
                    horizontalAnimation: horizontalAnimation,
                    tween: Tween<double>(begin: Global.radius, end: 1.0),
                  ),
                ],
              ),
            ),
          ),
          IgnorePointer(
            ignoring: true,
            child: PageView.builder(
              controller: pageController,
              itemCount: 4,
              itemBuilder: (context, index) {
                return Center(
                  child: Text(
                    'Page ${index + 1}',
                    style: TextStyle(
                      color: index % 2 == 0 ? Global.mediumBlue : Colors.purple,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
