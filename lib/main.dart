import 'package:flutter/material.dart';

// import 'package:designs_app/src/pages/headers_page.dart';
import 'package:designs_app/src/pages/animations_page.dart';

import 'src/challenges/animated_square_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Designs App',
      debugShowCheckedModeBanner: false,
      // home: HeadersPage(),
      home: SquareAnimatedPage(),
    );
  }
}
