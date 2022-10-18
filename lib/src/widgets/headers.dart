import 'package:flutter/material.dart';

class HeaderCuadrado extends StatelessWidget {
  const HeaderCuadrado({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: const Color(0xff615AAB),
    );
  }
}

class HeaderBordesRedondeados extends StatelessWidget {
  const HeaderBordesRedondeados({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      /* No podemos usar las propiedades de diseño en un container cuando 
      tenemos un BoxDecoration en este, ya que estas propiedades se pueden establecer
      usando este BoxDecoration */
      // color: const Color(0xff615AAB),
      decoration: const BoxDecoration(
        color: Color(0xff615AAB),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(70),
          bottomRight: Radius.circular(70),
        )
      ),
    );
  }
}

class HeaderDiagonal extends StatelessWidget {
  const HeaderDiagonal({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: CustomPaint(
        /* Utilizamos la instancia de nuestro CustomPainter */
        painter: _HeaderDiagonalPainter(),
      ),
    );
  }
}

/* Creamos nuestro CustomPainter */
class _HeaderDiagonalPainter extends CustomPainter {
  /* El metodo paint es en el que definimos como estaremos pintando 
  nuestro CustomPainter */
  @override
  void paint(Canvas canvas, Size size) {
    /* Creamos nuestro lapiz que nos ayudara a hacer los dibujos */
    final paint = Paint();

    paint.color = const Color(0xff615AAB);
    // paint.style = PaintingStyle.stroke;
    paint.style = PaintingStyle.fill;
    paint.strokeWidth = 2;

    /* Creamos el path que nos estara ayudando a recorrer por donde haremos
    la figura */
    final path = Path();

    path.moveTo(0, size.height * 0.35);
    path.lineTo(size.width, size.height * 0.3);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    // path.lineTo(0, size.height * 0.5);

    /* Dibujamos el painter en el path */
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}