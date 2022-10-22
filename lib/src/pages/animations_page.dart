import 'package:flutter/material.dart';
import 'dart:math' as math;

class AnimationsPage extends StatelessWidget {
  const AnimationsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: AnimatedSquare(),
      ),
    );
  }
}

class AnimatedSquare extends StatefulWidget {
  const AnimatedSquare({
    Key? key,
  }) : super(key: key);

  @override
  State<AnimatedSquare> createState() => _AnimatedSquareState();
}

class _AnimatedSquareState extends State<AnimatedSquare> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> rotation;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this, 
      duration: const Duration(milliseconds: 4000)
    );

    rotation = Tween(
      begin: 0.0,
      end: 2.0 * math.pi
    ).animate(controller);

    /* Con el event listener lo que hacemos es tener control del flujo de la animacion
    mientras esta siendo reproducida, de esta forma, podemos tener control de lo que sucede
    mas facilmente */
    controller.addListener(() { 
      if (controller.status == AnimationStatus.completed) {
        controller.reverse();
      } else if (controller.status == AnimationStatus.dismissed) {
        controller.forward();
      }

      // controller.repeat();
    });

    controller.forward();

    super.initState();
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
        return Transform.rotate( // widget para hacer rotaciones en la animacion
          angle: rotation.value,
          child: child
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
