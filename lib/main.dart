import 'package:flutter/material.dart';

void main() {
  runApp(const MonAppli());
}

class MonAppli extends StatelessWidget {
  const MonAppli({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Ma Première App',
      debugShowCheckedModeBanner: false,
      home: PageAccueil(),
    );
  }
}

class PageAccueil extends StatelessWidget {
  const PageAccueil({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: const Text("Magazine Infos", 
          style: TextStyle(
            color: Colors.white
          ),
        ),
        centerTitle: true,
        leading: IconButton( 
          icon: const Icon(Icons.menu,color: Colors.white), 
          onPressed: () {}, 
        ), 
        actions: [ 
          IconButton( 
            icon: const Icon(Icons.search,color: Colors.white), 
            onPressed: () {}, 
          ), 
        ] 
      ),
      body: Center(
        child: Image.asset("assets/images/images.jpg"),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.pinkAccent,
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Donc tu as cliqué dessus !'),
              duration: Duration(seconds: 2),
            ),
          );
        },
        child: const Icon(Icons.add,color: Colors.white), 
      ),
    );
  }
}