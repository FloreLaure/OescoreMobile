import 'package:flutter/material.dart';
import 'package:project/screens/formulaire.dart';
import 'package:project/screens/prospection.dart';

class Score extends StatelessWidget {
  final int predictedScore;

  const Score({Key? key, required this.predictedScore}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFFF7900),
          title: const Text('SCORE'),
          // leading: const Icon(
          //   Icons.menu_outlined,
          // ),
          // actions: const <Widget>[
          //   Icon(Icons.account_circle),
          // ],
          elevation: 10.0,
          centerTitle: true,
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: const Icon(Icons.score),
                title: const Text(
                  'PROSPECTER',
                  style: TextStyle(color: Color(0xFFFF7900)),
                ),
                iconColor: const Color(0xFFFF7900),
                onTap: () {
                  Navigator.of(context).pop(); // Ferme le menu
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          const ProductListScreen())); // Action à effectuer lorsque l'icône Prospection est cliquée
                },
              ),

              ListTile(
                leading: const Icon(Icons.add),
                title: const Text(
                  'ENREGISTRER UN CLIENT',
                  style: TextStyle(color: Color(0xFFFF7900)),
                ),
                iconColor: const Color(0xFFFF7900),
                onTap: () {
                  Navigator.of(context).pop(); // Ferme le menu
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Formulaire()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.history),
                title: const Text(
                  'HISTORIQUE',
                  style:
                      TextStyle(color: Color(0xFFFF7900)), // Couleur du texte
                ),
                iconColor: const Color(0xFFFF7900),
                onTap: () {
                  Navigator.of(context).pop(); // Ferme le menu
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Formulaire()));
                },
              ),
              // Ajoutez d'autres éléments du menu ici
            ],
          ),
        ),
        body: Center(
          child: Container(
            margin: const EdgeInsets.all(75.0),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 1 / 3,
            child: Card(
              elevation: 90.0,
              color: Color.fromARGB(255, 247, 245, 243),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  getScoreIcon(predictedScore),
                  Text(
                    getScoreText(predictedScore),
                    style: TextStyle(fontSize: 24.0),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.add),
                color: Color(0xFFFF7900),
                onPressed: () {
                  Navigator.of(context).pop(); // Ferme le menu
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const Formulaire()));
                },
                // Action à effectuer lorsque l'icône Prospection est cliquée
              ),
              IconButton(
                icon: const Icon(Icons.score),
                color: Color(0xFFFF7900),
                onPressed: () {
                  Navigator.of(context).pop(); // Ferme le menu
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ProductListScreen()));
                  // Action à effectuer lorsque l'icône Accueil est cliquée
                },
              ),

              IconButton(
                icon: const Icon(Icons.history),
                color: Color(0xFFFF7900),
                onPressed: () {
                  Navigator.of(context).pop(); // Ferme le menu
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const ProductListScreen()));
                  // Action à effectuer lorsque l'icône Accueil est cliquée
                },
              ),

              // Ajoutez d'autres icônes ou éléments de pied de page ici
            ],
          ),
        ),
      ),
    );
  }

  Icon getScoreIcon(int score) {
    if (score == 1) {
      return const Icon(
        Icons.thumb_up,
        size: 200.0,
        color: Color(0xFFFF7900),
      );
    } else {
      return const Icon(
        Icons.thumb_down,
        size: 200.0,
        color: Color(0xFFFF7900),
      );
    }
  }

  String getScoreText(int score) {
    if (score == 1) {
      return 'Score favorable';
    } else {
      return 'Score défavorable';
    }
  }
}

// class Score extends StatelessWidget {
//   final int predictedScore;

//   const Score({Key? key, required this.predictedScore}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           backgroundColor: const Color(0xFFFF7900),
//           title: const Text('SCORE'),
//           leading: const Icon(
//             Icons.menu_outlined,
//           ),
//           actions: const <Widget>[
//             Icon(Icons.account_circle),
//           ],
//           elevation: 10.0,
//           centerTitle: true,
//         ),
//         body: Center(
//           child: Container(
//             margin: const EdgeInsets.all(85.0),
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height,
//             child: const Card(
//               elevation: 90.0,
//               color: Color.fromARGB(255, 247, 245, 243),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Votre contenu de carte ici

//                   // Icône "like"
//                   Icon(
//                     Icons.thumb_up,
//                     size: 200.0, // Taille de l'icône
//                     color: Color(0xFFFF7900), // Couleur de l'icône
//                   ),

//                   // Icône "unlike"
//                   Icon(
//                     Icons.thumb_down,
//                     size: 200.0,
//                     color: Color(0xFFFF7900),
//                   ),

//                   // Autres éléments de la carte
//                   Text(
//                     'Score défavorable',
//                     style: TextStyle(fontSize: 24.0),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
