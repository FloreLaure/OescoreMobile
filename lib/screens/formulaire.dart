import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'Historique.dart';
import 'prospection.dart';

class Formulaire extends StatefulWidget {
  const Formulaire({Key? key}) : super(key: key);

  @override
  FormulaireState createState() => FormulaireState();
}

class FormulaireState extends State<Formulaire> {
  final TextEditingController nomController = TextEditingController();
  final TextEditingController prenomController = TextEditingController();
  final TextEditingController telephoneController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  String? selectedGenre;
  int age = 0;
  String? selectedProfession;
  String? selectedLangue;
  String? region;

// Remplacez par l'URL de votre API Django
  void _handleClient(BuildContext context) async {
    const String apiUrl =
        'https://8de1-197-239-80-166.ngrok-free.app/api/enregistrer_client/';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'nom': nomController.text,
          'prenom': prenomController.text,
          'telephone': telephoneController.text,
          'occupation': selectedProfession,
          'langue': selectedLangue,
          'region': region,
          'gender': selectedGenre,
          'age': age,
        }),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => ProductListScreen(),
          ),
        );
      } else {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Échec de l'enregistrement"),
            content: const Text('Données incorrectes'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Fermer la boîte de dialogue
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (error) {
      print('Erreur lors de la connexion à l\'API : $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF7900),
        title: const Text('ENREGISTRER UN CLIENT'),
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
                style: TextStyle(color: Color(0xFFFF7900)), // Couleur du texte
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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context)
                  .size
                  .width, // Utilisez la largeur de l'écran
              height: MediaQuery.of(context).size.height * 1,
              clipBehavior: Clip.antiAlias,
              decoration: const BoxDecoration(color: Colors.white),
              child: Stack(
                children: [
                  const Positioned(
                    left: 35,
                    top: 0,
                    child: Text(
                      'Remplissez le formulaire',
                      style: TextStyle(
                        color: Color(0xFFFF7900),
                        fontSize: 30,
                        fontFamily: 'Shippori Mincho',
                        fontWeight: FontWeight.w700,
                        height: 1.54,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    top: 30,
                    child: SizedBox(
                      width: 350,
                      height: 765,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 291,
                            top: 80,
                            child: Container(
                              width: 30,
                              height: 30,
                              clipBehavior: Clip.antiAlias,
                              decoration: const BoxDecoration(),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 25,
                            child: SizedBox(
                              width: 328,
                              height: 110,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                      width: 328,
                                      height: 45,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              width: 0.50,
                                              color: Color(0xFFFF7900)),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: TextField(
                                          controller: nomController,
                                          decoration: const InputDecoration(
                                            hintText: "Nom du client",
                                            hintStyle: TextStyle(
                                              color: Color(0xFFFF7900),
                                              fontSize: 12,
                                              fontFamily: 'Shippori Mincho',
                                              fontWeight: FontWeight.w400,
                                              height: 1.42,
                                            ),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    top: 65,
                                    child: Container(
                                      width: 328,
                                      height: 45,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              width: 0.50,
                                              color: Color(0xFFFF7900)),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: TextField(
                                          controller: prenomController,
                                          decoration: const InputDecoration(
                                            hintText: "Prénom du client",
                                            hintStyle: TextStyle(
                                              color: Color(0xFFFF7900),
                                              fontSize: 12,
                                              fontFamily: 'Shippori Mincho',
                                              fontWeight: FontWeight.w400,
                                              height: 1.42,
                                            ),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 65,
                            child: SizedBox(
                              width: 328,
                              height: 250,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 85,
                                    child: Container(
                                      width: 328,
                                      height: 45,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              width: 0.50,
                                              color: Color(0xFFFF7900)),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: TextField(
                                          controller: telephoneController,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            hintText: "Téléphone",
                                            hintStyle: TextStyle(
                                              color: Color(0xFFFF7900),
                                              fontSize: 12,
                                              fontFamily: 'Shippori Mincho',
                                              fontWeight: FontWeight.w400,
                                              height: 1.42,
                                            ),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    top: 140,
                                    child: Container(
                                      width: 328,
                                      height: 45,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              width: 0.50,
                                              color: Color(0xFFFF7900)),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: DropdownButton<String>(
                                          isExpanded:
                                              true, // Pour occuper tout l'espace disponible
                                          value:
                                              selectedProfession, // La valeur sélectionnée
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              selectedProfession = newValue!;
                                            });
                                          },
                                          items: <String>[
                                            'commerce',
                                            'Informatique',
                                            'Armee'
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          underline: Container(),
                                          hint: const Text(
                                            "Profession",
                                            style: TextStyle(
                                              color: Color(0xFFFF7900),
                                              fontSize: 12,
                                              fontFamily: 'Shippori Mincho',
                                              fontWeight: FontWeight.w400,
                                              height: 1.42,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 265,
                            child: SizedBox(
                              width: 328,
                              height: 110,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 60,
                                    child: Container(
                                      width: 328,
                                      height: 45,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                            width: 0.50,
                                            color: Color(0xFFFF7900),
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: DropdownButton<String>(
                                          isExpanded: true,
                                          value: selectedGenre,
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              selectedGenre = newValue ??
                                                  ''; // Ajoutez cette ligne pour gérer les cas où newValue est null
                                            });
                                          },
                                          items: <String>[
                                            'Masculin',
                                            'Feminin',
                                          ].map<DropdownMenuItem<String>>(
                                            (String value) {
                                              return DropdownMenuItem<String>(
                                                value: value,
                                                child: Text(value),
                                              );
                                            },
                                          ).toList(),
                                          underline: Container(),
                                          hint: const Text(
                                            "Genre du client",
                                            style: TextStyle(
                                              color: Color(0xFFFF7900),
                                              fontSize: 12,
                                              fontFamily: 'Shippori Mincho',
                                              fontWeight: FontWeight.w400,
                                              height: 1.42,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    top: 0,
                                    child: Container(
                                      width: 328,
                                      height: 45,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              width: 0.50,
                                              color: Color(0xFFFF7900)),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: TextField(
                                          controller: ageController,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            hintText: "Age",
                                            hintStyle: TextStyle(
                                              color: Color(0xFFFF7900),
                                              fontSize: 12,
                                              fontFamily: 'Shippori Mincho',
                                              fontWeight: FontWeight.w400,
                                              height: 1.42,
                                            ),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 380,
                            child: SizedBox(
                              width: 328,
                              height: 300,
                              child: Stack(
                                children: [
                                  Positioned(
                                    left: 0,
                                    top: 5,
                                    child: Container(
                                      width: 328,
                                      height: 45,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              width: 0.50,
                                              color: Color(0xFFFF7900)),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: DropdownButton<String>(
                                          isExpanded:
                                              true, // Pour occuper tout l'espace disponible
                                          value:
                                              selectedLangue, // La valeur sélectionnée
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              selectedLangue = newValue!;
                                            });
                                          },
                                          items: <String>[
                                            'Peulh',
                                            'Moore',
                                            'Dioula',
                                            'Anglais',
                                            'Francais'
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          underline: Container(),
                                          hint: const Text(
                                            "Langue du client",
                                            style: TextStyle(
                                              color: Color(0xFFFF7900),
                                              fontSize: 12,
                                              fontFamily: 'Shippori Mincho',
                                              fontWeight: FontWeight.w400,
                                              height: 1.42,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    left: 0,
                                    top: 65,
                                    child: Container(
                                      width: 328,
                                      height: 45,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: const BorderSide(
                                              width: 0.50,
                                              color: Color(0xFFFF7900)),
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: DropdownButton<String>(
                                          isExpanded:
                                              true, // Pour occuper tout l'espace disponible
                                          value:
                                              region, // La valeur sélectionnée
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              region = newValue!;
                                            });
                                          },
                                          items: <String>[
                                            'Centre-EST',
                                            'Centre',
                                            'Centre-Ouest',
                                            'Nord',
                                            'Sud'
                                          ].map<DropdownMenuItem<String>>(
                                              (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          underline: Container(),
                                          hint: const Text(
                                            "Région",
                                            style: TextStyle(
                                              color: Color(0xFFFF7900),
                                              fontSize: 12,
                                              fontFamily: 'Shippori Mincho',
                                              fontWeight: FontWeight.w400,
                                              height: 1.42,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 500,
                            child: ElevatedButton(
                              onPressed: () => _handleClient(context),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFF7900),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              child: Container(
                                width: 300,
                                height: 50,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 16),
                                child: const Center(
                                  child: Text(
                                    'Enrégistrer',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 250, 250, 248),
                                      fontSize: 14,
                                      fontFamily: 'Shippori Mincho',
                                      fontWeight: FontWeight.w700,
                                      height: 1.29,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
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
    );
  }
}
