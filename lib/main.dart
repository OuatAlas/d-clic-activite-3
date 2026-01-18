import 'package:flutter/material.dart';
import 'pages/redacteurs.dart';
import 'pages/accueil.dart';

void main() {
  runApp(const MonAppli());
}


class MonAppli extends StatelessWidget {
  const MonAppli({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Magazine',
      routes: {
        '/': (context) => const PageAccueil(),
        '/redacteurs': (context) => const RedacteurInterface(),
      },
    );
  }
}
