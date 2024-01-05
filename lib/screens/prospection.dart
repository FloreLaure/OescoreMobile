import 'dart:convert';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/screens/formulaire.dart';
import 'package:project/screens/score.dart';

class Prospection {
  final String selectedClient; // Champs pour le client
  final String selectedProduct; // Champs pour le produit
  // ignore: non_constant_identifier_names
  final int upfront;

  Prospection({
    required this.selectedClient,
    required this.selectedProduct,
    // ignore: non_constant_identifier_names
    required this.upfront,
  });

  // Ajoutez une méthode pour convertir l'objet en JSON
  Map<String, dynamic> toJson() {
    return {
      'client': selectedClient,
      'produit': selectedProduct,
      'upfront': upfront,
    };
  }
}

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final TextEditingController upfrontController = TextEditingController();
  List<String> produit = [];
  String? selectedProduct;
  List<String> client = [];
  String? selectedClient;
  // ignore: non_constant_identifier_names
  int upfront = 1234;

  @override
  void initState() {
    super.initState();
    fetchproduit();
    fetchclient();
    _handleProspection;
  }

  Future<void> fetchproduit() async {
    final response = await http.get(Uri.parse(
        'https://8de1-197-239-80-166.ngrok-free.app/api/list_produit_api/'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      setState(() {
        produit = jsonData.map((data) => data['groupname'] as String).toList();
      });
    } else {
      throw Exception('Failed to load produit');
    }
  }

  Future<void> fetchclient() async {
    final response = await http.get(Uri.parse(
        'https://8de1-197-239-80-166.ngrok-free.app/api/list_clients_api/'));
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      setState(() {
        client = jsonData.map((data) => data['nom'] as String).toList();
      });
    } else {
      throw Exception('Failed to load client');
    }
  }

  void _handleProspection(BuildContext context) async {
    const String apiUrl =
        'https://8de1-197-239-80-166.ngrok-free.app/api/prospection_api/';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'upfront': upfront,
          'produit': selectedProduct, // Utilisez le nom du produit
          'client': selectedClient, // Utilisez le nom du client
        }),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final int predictedScore = responseData['predicted_score'];
        await Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => Score(predictedScore: predictedScore),
            // await Navigator.of(context).pushReplacement(
            //   MaterialPageRoute(
            //     builder: (context) => const Score(),
          ),
        );
      } else {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text("Échec de l'enregistrement"),
            content: const Text('Données incorrectes ou serveur indisponible'),
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
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Échec de l'enregistrement"),
          content: const Text(
              'Une erreur s\'est produite. Veuillez réessayer plus tard.'),
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFFF7900),
        title: const Text('PROSPECTION'),
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
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Center(
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
          ),
          const SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Column(
                  children: [
                    Column(
                      children: [
                        Container(
                          width: 328,
                          height: 45,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 0.50, color: Color(0xFFFF7900)),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                items: produit.map<DropdownMenuItem<String>>(
                                  (String product) {
                                    return DropdownMenuItem<String>(
                                      value: product,
                                      child: Text(product),
                                    );
                                  },
                                ).toList(),
                                value: selectedProduct,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedProduct = newValue;
                                  });
                                },
                                hint: const Text(
                                  "Produit",
                                  style: TextStyle(
                                    color: Color(0xFFFF7900),
                                    fontSize: 12,
                                    fontFamily: 'Shippori Mincho',
                                    fontWeight: FontWeight.w400,
                                    height: 1.42,
                                  ),
                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    Icons.arrow_drop_down_sharp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: 328,
                          height: 45,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 0.50, color: Color(0xFFFF7900)),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton2<String>(
                                items: client.map<DropdownMenuItem<String>>(
                                  (String client) {
                                    return DropdownMenuItem<String>(
                                      value: client,
                                      child: Text(client),
                                    );
                                  },
                                ).toList(),
                                value: selectedClient,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedClient = newValue;
                                  });
                                },
                                hint: const Text(
                                  "Client",
                                  style: TextStyle(
                                    color: Color(0xFFFF7900),
                                    fontSize: 12,
                                    fontFamily: 'Shippori Mincho',
                                    fontWeight: FontWeight.w400,
                                    height: 1.42,
                                  ),
                                ),
                                iconStyleData: const IconStyleData(
                                  icon: Icon(
                                    Icons.arrow_drop_down_sharp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                          width: 328,
                          height: 45,
                          decoration: ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(
                                  width: 0.50, color: Color(0xFFFF7900)),
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 25, right: 8.0),
                            child: TextField(
                              controller: upfrontController,
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                hintText: "Versement",
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
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => _handleProspection(context),
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
                            'Voir le score',
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
                  ],
                ),
              ],
            ),
          ),
        ],
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






// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import 'home_sreen.dart';
// import 'score.dart';

// class ProductListScreen extends StatefulWidget {
//   const ProductListScreen({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _ProductListScreenState createState() => _ProductListScreenState();
// }

// class _ProductListScreenState extends State<ProductListScreen> {
//   List<dynamic> produit = [];
//   String? selectedProduct;
//   List<dynamic> client = [];
//   String? selectedclient;
//   double upfront = 12345.67;

//   @override
//   void initState() {
//     super.initState();
//     fetchproduit();
//     fetchclient();
//   }

//   Future<void> fetchproduit() async {
//     final response = await http
//         .get(Uri.parse('https://8de1-197-239-80-166.ngrok-free.app /api/list_produit_api/'));
//     if (response.statusCode == 200) {
//       setState(() {
//         produit = json.decode(response.body);
//       });
//     } else {
//       throw Exception('Failed to load produit');
//     }
//   }

//   Future<void> fetchclient() async {
//     final response = await http
//         .get(Uri.parse('https://8de1-197-239-80-166.ngrok-free.app /api/list_client_api/'));
//     if (response.statusCode == 200) {
//       setState(() {
//         client = json.decode(response.body);
//       });
//     } else {
//       throw Exception('Failed to load client');
//     }
//   }

//   void _handleProspection(BuildContext context) async {
//     const String apiUrl = 'https://8de1-197-239-80-166.ngrok-free.app /api/prospection_api/';

//     try {
//       final response = await http.post(
//         Uri.parse(apiUrl),
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(<String, dynamic>{
//           'upfront_price': upfront,
//           'Produit': selectedProduct,
//           'client': selectedclient,
//         }),
//       );

//       if (response.statusCode == 201) {
//         final Map<String, dynamic> responseData = json.decode(response.body);
//         Navigator.of(context).pushReplacement(
//           MaterialPageRoute(
//             builder: (context) => const Score(),
//           ),
//         );
//       } else {
//         // ignore: use_build_context_synchronously
//         showDialog(
//           context: context,
//           builder: (context) => AlertDialog(
//             title: const Text("Échec de l'enregistrement"),
//             content: const Text('Données incorrectes'),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(); // Fermer la boîte de dialogue
//                 },
//                 child: const Text('OK'),
//               ),
//             ],
//           ),
//         );
//       }
//     } catch (error) {
//       print('Erreur lors de la connexion à l\'API : $error');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFFFF7900),
//         title: const Text('PROSPECTION'),
//         leading: const Icon(
//           Icons.menu_outlined,
//         ),
//         actions: const <Widget>[
//           Icon(Icons.account_circle),
//         ],
//         elevation: 10.0,
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               width: 390,
//               height: 990,
//               clipBehavior: Clip.antiAlias,
//               decoration: const BoxDecoration(color: Colors.white),
//               child: Stack(
//                 children: [
//                   const Positioned(
//                     left: 35,
//                     top: 0,
//                     child: Text(
//                       'Remplissez le Prospection',
//                       style: TextStyle(
//                         color: Color(0xFFFF7900),
//                         fontSize: 30,
//                         fontFamily: 'Shippori Mincho',
//                         fontWeight: FontWeight.w700,
//                         height: 1.54,
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     left: 35,
//                     top: 30,
//                     child: SizedBox(
//                       width: 350,
//                       height: 765,
//                       child: Stack(
//                         children: [
//                           Positioned(
//                             left: 291,
//                             top: 80,
//                             child: Container(
//                               width: 30,
//                               height: 30,
//                               clipBehavior: Clip.antiAlias,
//                               decoration: const BoxDecoration(),
//                             ),
//                           ),
//                           Positioned(
//                             left: 0,
//                             top: 25,
//                             child: SizedBox(
//                               width: 328,
//                               height: 810,
//                               child: Stack(
//                                 children: [
//                                   Positioned(
//                                     left: 0,
//                                     top: 40,
//                                     child: Container(
//                                       width: 328,
//                                       height: 45,
//                                       decoration: ShapeDecoration(
//                                         shape: RoundedRectangleBorder(
//                                           side: const BorderSide(
//                                               width: 0.50,
//                                               color: Color(0xFFFF7900)),
//                                           borderRadius:
//                                               BorderRadius.circular(15),
//                                         ),
//                                       ),
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 8.0),
//                                         child: DropdownButton<String>(
//                                           value: selectedProduct,
//                                           onChanged: (String? newValue) {
//                                             setState(() {
//                                               selectedProduct = newValue!;
//                                             });
//                                           },
//                                           items: produit
//                                               .map<DropdownMenuItem<String>>(
//                                                   (dynamic product) {
//                                             return DropdownMenuItem<String>(
//                                               value: product['groupname'],
//                                               child: Text(product['groupname']),
//                                             );
//                                           }).toList(),
//                                           underline: Container(),
//                                           hint: const Text(
//                                             "Produit",
//                                             style: TextStyle(
//                                               color: Color(0xFFFF7900),
//                                               fontSize: 12,
//                                               fontFamily: 'Shippori Mincho',
//                                               fontWeight: FontWeight.w400,
//                                               height: 1.42,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Positioned(
//                                     left: 0,
//                                     top: 95,
//                                     child: Container(
//                                       width: 328,
//                                       height: 45,
//                                       decoration: ShapeDecoration(
//                                         shape: RoundedRectangleBorder(
//                                           side: const BorderSide(
//                                               width: 0.50,
//                                               color: Color(0xFFFF7900)),
//                                           borderRadius:
//                                               BorderRadius.circular(15),
//                                         ),
//                                       ),
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 8.0),
//                                         child: DropdownButton<String>(
//                                           value: selectedclient,
//                                           onChanged: (String? newValue) {
//                                             setState(() {
//                                               selectedclient = newValue!;
//                                             });
//                                           },
//                                           items: client
//                                               .map<DropdownMenuItem<String>>(
//                                                   (dynamic client) {
//                                             return DropdownMenuItem<String>(
//                                               value: client['nom'],
//                                               child: Text(client['nom']),
//                                             );
//                                           }).toList(),
//                                           underline: Container(),
//                                           hint: const Text(
//                                             "Client",
//                                             style: TextStyle(
//                                               color: Color(0xFFFF7900),
//                                               fontSize: 12,
//                                               fontFamily: 'Shippori Mincho',
//                                               fontWeight: FontWeight.w400,
//                                               height: 1.42,
//                                             ),
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   Positioned(
//                                     left: 0,
//                                     top: 150,
//                                     child: Container(
//                                       width: 328,
//                                       height: 45,
//                                       decoration: ShapeDecoration(
//                                         shape: RoundedRectangleBorder(
//                                           side: const BorderSide(
//                                               width: 0.50,
//                                               color: Color(0xFFFF7900)),
//                                           borderRadius:
//                                               BorderRadius.circular(15),
//                                         ),
//                                       ),
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(
//                                             horizontal: 8.0),
//                                         child: TextField(
//                                           controller: TextEditingController(
//                                               text: upfront.toString()),
//                                           keyboardType: TextInputType.number,
//                                           decoration: const InputDecoration(
//                                             hintText: "Versement",
//                                             hintStyle: TextStyle(
//                                               color: Color(0xFFFF7900),
//                                               fontSize: 12,
//                                               fontFamily: 'Shippori Mincho',
//                                               fontWeight: FontWeight.w400,
//                                               height: 1.42,
//                                             ),
//                                             border: InputBorder.none,
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 0,
//                             top: 250,
//                             child: ElevatedButton(
//                               onPressed: () => _handleProspection(context),
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: const Color(0xFFFF7900),
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(15),
//                                 ),
//                               ),
//                               child: Container(
//                                 width: 300,
//                                 height: 50,
//                                 padding: const EdgeInsets.symmetric(
//                                     horizontal: 10, vertical: 16),
//                                 child: const Center(
//                                   child: Text(
//                                     'Enrégistrer',
//                                     style: TextStyle(
//                                       color: Color.fromARGB(255, 250, 250, 248),
//                                       fontSize: 14,
//                                       fontFamily: 'Shippori Mincho',
//                                       fontWeight: FontWeight.w700,
//                                       height: 1.29,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }












// import 'dart:convert';
// import 'package:http/http.dart' as http;

// Future<List<Article>> fetchArticles() async {
//   final response = await http.get(
//     Uri.parse('https://votre-domaine.com/api/articles/'), // Remplacez par votre URL
//   );

//   if (response.statusCode == 200) {
//     final List<dynamic> data = jsonDecode(response.body);
//     return data.map((json) => Article.fromJson(json)).toList();
//   } else {
//     throw Exception('Impossible de charger les articles');
//   }
// }

// import 'dart:convert';
// import 'package:http/http.dart' as http;

// Future<void> enregistrerTable1() async {
//   final response = await http.post(
//     Uri.parse('https://votre-domaine.com/api/enregistrer/table1/'), // URL pour Table1
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, dynamic>{
//       'champ1': 'valeur1',
//       'champ2': 42,
//       // Ajoutez d'autres champs ici
//     }),
//   );

//   if (response.statusCode == 201) {
//     print('Données de Table1 enregistrées avec succès');
//   } else {
//     print('Échec de l\'enregistrement des données dans Table1');
//   }
// }

// Future<void> enregistrerTable2() async {
//   final response = await http.post(
//     Uri.parse('https://votre-domaine.com/api/enregistrer/table2/'), // URL pour Table2
//     headers: <String, String>{
//       'Content-Type': 'application/json; charset=UTF-8',
//     },
//     body: jsonEncode(<String, dynamic>{
//       'champ1': 'valeurA',
//       'champ2': 99,
//       // Ajoutez d'autres champs ici
//     }),
//   );

//   if (response.statusCode == 201) {
//     print('Données de Table2 enregistrées avec succès');
//   } else {
//     print('Échec de l\'enregistrement des données dans Table2');
//   }
// }









//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primaryColor: Colors.red, // Changez la couleur ici
//       ),
//       home: const MyForm(),
//     );
//   }
// }

// class MyForm extends StatefulWidget {
//   const MyForm({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _MyFormState createState() => _MyFormState();
// }

// class _MyFormState extends State<MyForm> {
//   final _formKey = GlobalKey<FormState>();
//   final _baseUrl = 'YOUR_API_URL'; // Replace with your API URL

//   String _name = '';
//   String _email = '';
//   String _selectedOption = 'Option 1';

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Flutter Form Example'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(15.0),
//           child: ListView(
//             // Utilisez un ListView ici
//             shrinkWrap: true,
//             children: [
//               Form(
//                 key: _formKey,
//                 child: Column(
//                   children: <Widget>[
//                     DropdownButtonFormField<String>(
//                       value: _selectedOption,
//                       onChanged: (newValue) {
//                         setState(() {
//                           _selectedOption = newValue!;
//                         });
//                       },
//                       items: <String>[
//                         '_'
//                             'Standard',
//                         'Basic',
//                         'Premium'
//                       ].map<DropdownMenuItem<String>>(
//                         (String value) {
//                           return DropdownMenuItem<String>(
//                             value: value,
//                             child: Text(value),
//                           );
//                         },
//                       ).toList(),
//                     ),
//                     // SizedBox(
//                     //   height: 50,
//                     const SizedBox(height: 10),
//                     TextFormField(
//                       decoration: const InputDecoration(
//                         labelText: 'Nom',
//                         // border: OutlineInputBorder(
//                         //   borderSide: const BorderSide(color: Color(0xFFFF7900)),
//                         //   borderRadius: BorderRadius.circular(15),
//                         // ), // Ajoute une bordure autour du champ
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Entrez votre Nom';
//                         }
//                         return null;
//                       },
//                       onSaved: (value) {
//                         _name = value!;
//                       },
//                     ),
//                     const SizedBox(height: 10),
//                     TextFormField(
//                       decoration: const InputDecoration(
//                         labelText: 'Prenom',
//                         // border: OutlineInputBorder(
//                         //   borderSide: const BorderSide(color: Color(0xFFFF7900)),
//                         //   borderRadius: BorderRadius.circular(15),
//                         // ), // Ajoute une bordure autour du champ
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Entrez le Prénom';
//                         }
//                         return null;
//                       },
//                       onSaved: (value) {
//                         _name = value!;
//                       },
//                     ),

//                     const SizedBox(height: 10),
//                     TextFormField(
//                       decoration: const InputDecoration(
//                         labelText: 'montant_premier_versement',
//                         // border: OutlineInputBorder(
//                         //   borderSide: const BorderSide(color: Color(0xFFFF7900)),
//                         //   borderRadius: BorderRadius.circular(15),
//                         // ), // Ajoute une bordure autour du champ
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Please enter your name';
//                         }
//                         return null;
//                       },
//                       onSaved: (value) {
//                         _name = value!;
//                       },
//                     ),

//                     const SizedBox(height: 10),
//                     TextFormField(
//                       decoration: const InputDecoration(
//                         labelText: 'prix_produit',
//                         // border: OutlineInputBorder(
//                         //   borderSide: const BorderSide(color: Color(0xFFFF7900)),
//                         //   borderRadius: BorderRadius.circular(15),
//                         // ), // Ajoute une bordure autour du champ
//                       ),
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'Please enter your name';
//                         }
//                         return null;
//                       },
//                       onSaved: (value) {
//                         _name = value!;
//                       },
//                     ),

//                     // const SizedBox(height: 10),
//                     // TextFormField(
//                     //   decoration: const InputDecoration(labelText: 'Email'),
//                     //   validator: (value) {
//                     //     if (value!.isEmpty) {
//                     //       return 'Please enter your email';
//                     //     }
//                     //     // You can add more complex email validation here if needed
//                     //     return null;
//                     //   },
//                     //   onSaved: (value) {
//                     //     _email = value!;
//                     //   },
//                     // ),

//                     const SizedBox(height: 10),
//                     ElevatedButton(
//                       onPressed: () async {
//                         if (_formKey.currentState!.validate()) {
//                           _formKey.currentState!.save();

//                           final response = await http.post(
//                             Uri.parse(_baseUrl),
//                             body: {
//                               'name': _name,
//                               'email': _email,
//                             },
//                           );

//                           if (response.statusCode == 200) {
//                             // Request succeeded, handle response here
//                             print('API Response: ${response.body}');
//                           } else {
//                             // Request failed, handle error here
//                             print('API Error: ${response.statusCode}');
//                           }
//                         }
//                       },
//                       child: const Text('Submit'),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
