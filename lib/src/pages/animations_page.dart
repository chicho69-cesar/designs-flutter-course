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
  late Animation<double> opacityOut;
  late Animation<double> moveRight;
  late Animation<double> zoom;

  @override
  void initState() {
    /* Instanciamos el controlador */
    controller = AnimationController(
      vsync: this, 
      duration: const Duration(milliseconds: 4000)
    );

    /* Creamos la animacion */
    rotation = Tween(
      begin: 0.0, end: 2.0 * math.pi
    ).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOut)
    );

    /* Creamos la animacion de opacidad */
    opacity = Tween(
      begin: 0.1, end: 1.0
    ).animate(
      CurvedAnimation(
        parent: controller, 
        /* El Interval es un tipo de Curve especial, que nos permite modificar el tiempo
        que dura una animacion en porcentaje del tiempo de la animacion, esto con el fin de que si tenemos varias animaciones 
        estas puedan tener diferentes tiempos cada una */
        curve: const Interval(0, 0.25, curve: Curves.easeOut)
      )
    );

    opacityOut = Tween(
      begin: 0.0, end: 1.0
    ).animate(
      CurvedAnimation(
        parent: controller, 
        curve: const Interval(0.75, 1, curve: Curves.easeOut)
      )
    );

    moveRight = Tween(
      begin: 0.0, end: 200.0
    ).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOut)
    );

    zoom = Tween(
      begin: 0.0, end: 2.0
    ).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOut)
    );

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
        return Transform.translate( // widget para hacer movimientos en la animacion
          offset: Offset(moveRight.value, 0),
          child: Transform.rotate( // widget para hacer rotaciones en la animacion
            angle: rotation.value,
            child: Opacity(
              opacity: opacity.value - opacityOut.value,
              child: Transform.scale( // widget para hacer escalaciones en la animacion
                scale: zoom.value,
                child: childRectangle
              ),
            ),
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
