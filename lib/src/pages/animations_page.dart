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
  /* Controlador y animacion para el contenedor */
  late AnimationController controller;
  late Animation<double> rotation;
  late Animation<double> opacity;

  @override
  void initState() {
    /* Instanciamos el controlador */
    controller = AnimationController(
      vsync: this, 
      duration: const Duration(milliseconds: 4000)
    );

    /* Creamos la animacion */
    rotation = Tween(
      begin: 0.0,
      end: 2.0 * math.pi
    ).animate(
      CurvedAnimation(
        parent: controller, 
        curve: Curves.easeOut
      )
    );

    /* Creamos la animacion de opacidad */
    opacity = Tween(
      begin: 0.1,
      end: 1.0
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
      builder: (BuildContext context, Widget? childRectangle) {
        return Transform.rotate( // widget para hacer rotaciones en la animacion
          angle: rotation.value,
          child: Opacity(
            opacity: opacity.value,
            child: childRectangle,
          ),
        );
      },
    );
  }
}

/* Widget a animar */
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
