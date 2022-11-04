import 'package:flutter/material.dart';

class SquareAnimatedPage extends StatelessWidget {
  const SquareAnimatedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: _AnimatedSquare()),
    );
  }
}

class _AnimatedSquare extends StatefulWidget {
  const _AnimatedSquare({
    Key? key,
  }) : super(key: key);

  @override
  State<_AnimatedSquare> createState() => _AnimatedSquareState();
}

class _AnimatedSquareState extends State<_AnimatedSquare> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  
  late Animation<double> modeRight;
  late Animation<double> moveUp;
  late Animation<double> moveLeft;
  late Animation<double> moveDown;

  @override
  void initState() { 
    super.initState();

    controller = AnimationController(vsync: this, duration: const Duration( milliseconds: 4500 ));

    modeRight = Tween( begin: 0.0, end: 125.0 ).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0, 0.25, curve: Curves.bounceOut ))
    );

    moveUp = Tween( begin: 0.0, end: -125.0 ).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0.25, 0.5, curve: Curves.bounceOut ))
    );

    moveLeft = Tween( begin: 0.0, end: -125.0 ).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0.5, 0.75, curve: Curves.bounceOut ))
    );

    moveDown = Tween( begin: 0.0, end: 125.0 ).animate(
      CurvedAnimation(parent: controller, curve: const Interval(0.75, 1.0, curve: Curves.bounceOut ))
    );
    
    controller.addListener((){
      if ( controller.status == AnimationStatus.completed ) {
        controller.repeat();
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward();

    return AnimatedBuilder(
      animation: controller,
      child: const _Rectangle(),
      builder: (BuildContext context, Widget? child) {
        return Transform.translate(
          offset: Offset(modeRight.value + moveLeft.value, moveUp.value + moveDown.value ),
          child: child,
        );
      },
    );
  }
}

class _Rectangle extends StatelessWidget {
  const _Rectangle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 70,
      height: 70,
      decoration: const BoxDecoration(color: Colors.blue),
    );
  }
}
