import 'package:flutter/material.dart';

void main() {
  runApp(const MonAppli());
}

class MonAppli extends StatelessWidget {
  const MonAppli({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Magazine',
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
        backgroundColor: Colors.pink,
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
      body: const Column(children: [
        Image(
          image: AssetImage("assets/images/magazineInfo.jpg")
          ),
          PartieTitre(),
          PartieTexte(),
          PartieIcone(),
          PartieRubrique(),
      ]),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.pinkAccent,
      //   onPressed: () {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(
      //         content: Text('Donc tu as cliqué dessus !'),
      //         duration: Duration(seconds: 2),
      //       ),
      //     );
      //   },
      //   child: const Icon(Icons.add,color: Colors.white), 
      // ),
    );
  }
}

class PartieTitre extends StatelessWidget {
  const PartieTitre({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bienvenue au Magazine Infos',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
          ),
          Text(
            'Votre magazine numérique, votre source d\'inspiration',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}

class PartieTexte extends StatelessWidget {
  const PartieTexte({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: const Text(
        'Magazine Info est bien plus qu\'un simple magazine d\'informations. C\'est votre passerelle vers le monde, une source inestimable de connaissances et d\'actualités soigneusement sélctionnées pour vous éclairer sur les enjeux mondiaux, la culture, la science et voir même le divertissement (les jeux)'
      ),
    );
  }
}

class PartieIcone extends StatelessWidget {
  const PartieIcone({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Icon(Icons.phone, color: Colors.pink),
                const SizedBox(height: 5),
                Text(
                  'Tel'.toUpperCase(),
                  style: const TextStyle(color: Colors.pink),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Icon(Icons.mail, color: Colors.pink),
                const SizedBox(height: 5),
                Text(
                  'Mail'.toUpperCase(),
                  style: const TextStyle(color: Colors.pink)
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const Icon(Icons.share, color: Colors.pink),
                const SizedBox(height: 5),
                Text(
                  'Partage'.toUpperCase(),
                  style: const TextStyle(color: Colors.pink)
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class PartieRubrique extends StatelessWidget {
  const PartieRubrique({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: const Image(
              image: AssetImage('assets/images/design.jpg')),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: const Image(
              image: AssetImage('assets/images/presse.jpg')),
          ),
        ],
      ),
    );
  }
}