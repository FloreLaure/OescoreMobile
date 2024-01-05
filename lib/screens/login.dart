import 'dart:convert';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';
// import 'package:project/screens/register.dart';
import 'package:http/http.dart' as http;
import 'formulaire.dart';
import 'Historique.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Remplacez par l'URL de votre API Django
  Future _handleLogin(BuildContext context) async {
    const String apiUrl =
        'https://8de1-197-239-80-166.ngrok-free.app/api/login/';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            'username': usernameController.text,
            'password': passwordController.text,
          },
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        final String authToken = responseData['token'];

        // ignore: use_build_context_synchronously, dead_code
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => const Formulaire(),
          ),
        );
        return authToken;
      } else {
        // ignore: use_build_context_synchronously
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Échec de la connexion'),
            content:
                const Text('Nom d\'utilisateur ou mot de passe incorrect.'),
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
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: MediaQuery.of(context)
                          .size
                          .width, // Utilisez la largeur de l'écran
                      height: MediaQuery.of(context).size.height * 1 / 3,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                              "assets/image1.png"), // Remplacez le chemin par votre image locale
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  const Positioned(
                    left: 75,
                    top: 300,
                    child: Text(
                      'Connectez-vous',
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
                    top: 400,
                    child: SizedBox(
                      width: 350,
                      height: 265,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 21,
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
                            top: 0,
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
                                          controller: usernameController,
                                          decoration: const InputDecoration(
                                            hintText: "Nom d'utilisateur",
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
                                    child: SizedBox(
                                      width: 328,
                                      height: 55,
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: TextField(
                                                  controller:
                                                      passwordController,
                                                  obscureText: true,
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText:
                                                        'Enter your password',
                                                    hintStyle: TextStyle(
                                                      color: Color(0xFFFF7900),
                                                      fontSize: 12,
                                                      fontFamily:
                                                          'Shippori Mincho',
                                                      fontWeight:
                                                          FontWeight.w400,
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
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: 170,
                            child: ElevatedButton(
                              onPressed: () => _handleLogin(context),
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
                                    'Se connecter',
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
                          const Positioned(
                            left: 170,
                            top: 133,
                            child: Text(
                              'Changer le mot de passe',
                              style: TextStyle(
                                color: Color(0xFFFF7900),
                                fontSize: 14,
                                fontFamily: 'Shippori Mincho',
                                fontWeight: FontWeight.w700,
                                height: 1.29,
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
    );
  }
}







// import 'dart:convert';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:flutter/material.dart';
// // import 'package:project/screens/register.dart';
// import 'package:http/http.dart' as http;
// import 'home_sreen.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);

//   @override
//   LoginScreenState createState() => LoginScreenState();
// }

// // class Login {
// //   late final String username;
// //   late final String password;

// //   const login({required this.username, required this.password}) {
// //    // TODO: implement login
// //    throw UnimplementedError();
// //    }

// //   factory login.fromJson(Map<String, dynamic> json) {
// //     return login(
// //       username: json['username'],
// //       password: json['password'],
// //     );
// //   }
// // }

// class LoginScreenState extends State<LoginScreen> {
//   final TextEditingController usernameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();

//   // Remplacez par l'URL de votre API Django
//   void _handleLogin(BuildContext context) async {
//     const String apiUrl =
//         'http://127.0.0.1:8000/api/connexion-commercial/'; // Remplacez par l'URL de votre API Django

//     final response = await http.post(
//       Uri.parse(apiUrl),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(
//         <String, String>{
//           'username': usernameController.text,
//           'password': passwordController.text,
//         },
//       ),
//     );

//     if (response.statusCode == 200) {
//       // L'authentification a réussi, traitez la réponse ici
//       // ignore: unused_local_variable
//       final Map<String, dynamic> responseData = json.decode(response.body);
//       // Vous pouvez stocker le jeton d'authentification ou effectuer d'autres actions

//       // Rediriger vers la page d'accueil
//       // ignore: use_build_context_synchronously
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(
//           builder: (context) =>
//               const HomeScreen(), // Utilisez la classe de votre page d'accueil
//         ),
//       );
//     } else {
//       // L'authentification a échoué, affichez une erreur à l'utilisateur
//       // ignore: use_build_context_synchronously
//       showDialog(
//         context: context,
//         builder: (context) => AlertDialog(
//           title: const Text('Échec de la connexion'),
//           content: const Text('Nom d\'utilisateur ou mot de passe incorrect.'),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Fermer la boîte de dialogue
//               },
//               child: const Text('OK'),
//             ),
//           ],
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Container(
//               width: 390,
//               height: 760,
//               clipBehavior: Clip.antiAlias,
//               decoration: const BoxDecoration(color: Colors.white),
//               child: Stack(
//                 children: [
//                   const Positioned(
//                     left: 95,
//                     top: 130,
//                     child: Text(
//                       'Welcome back!',
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
//                     top: 300,
//                     child: SizedBox(
//                       width: 350,
//                       height: 265,
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
//                             top: 0,
//                             child: SizedBox(
//                               width: 328,
//                               height: 110,
//                               child: Stack(
//                                 children: [
//                                   Positioned(
//                                     left: 0,
//                                     top: 65,
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
//                                           controller: usernameController,
//                                           decoration: const InputDecoration(
//                                             hintText: "Nom d'utilisateur",
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
//                                   Positioned(
//                                     left: 0,
//                                     top: 0,
//                                     child: SizedBox(
//                                       width: 328,
//                                       height: 55,
//                                       child: Stack(
//                                         children: [
//                                           Positioned(
//                                             left: 0,
//                                             top: 0,
//                                             child: Container(
//                                               width: 328,
//                                               height: 45,
//                                               decoration: ShapeDecoration(
//                                                 shape: RoundedRectangleBorder(
//                                                   side: const BorderSide(
//                                                       width: 0.50,
//                                                       color: Color(0xFFFF7900)),
//                                                   borderRadius:
//                                                       BorderRadius.circular(15),
//                                                 ),
//                                               ),
//                                               child: Padding(
//                                                 padding:
//                                                     const EdgeInsets.symmetric(
//                                                         horizontal: 8.0),
//                                                 child: TextField(
//                                                   controller:
//                                                       passwordController,
//                                                   obscureText: true,
//                                                   decoration:
//                                                       const InputDecoration(
//                                                     hintText:
//                                                         'Enter your password',
//                                                     hintStyle: TextStyle(
//                                                       color: Color(0xFFFF7900),
//                                                       fontSize: 12,
//                                                       fontFamily:
//                                                           'Shippori Mincho',
//                                                       fontWeight:
//                                                           FontWeight.w400,
//                                                       height: 1.42,
//                                                     ),
//                                                     border: InputBorder.none,
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           Positioned(
//                             left: 0,
//                             top: 170,
//                             child: ElevatedButton(
//                               onPressed: () => _handleLogin(context),
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
//                                     'Login',
//                                     style: TextStyle(
//                                       color: Color.fromARGB(255, 81, 69, 44),
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
//                           const Positioned(
//                             left: 190,
//                             top: 133,
//                             child: Text(
//                               'Changer le mot de passe',
//                               style: TextStyle(
//                                 color: Color(0xFFFF7900),
//                                 fontSize: 14,
//                                 fontFamily: 'Shippori Mincho',
//                                 fontWeight: FontWeight.w700,
//                                 height: 1.29,
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





// //              


















// // import 'package:flutter/material.dart';
// // // ignore: unused_import
// // // import 'package:flutter_login/theme.dart';
// // // import 'package:project/screens/home_sreen.dart';

// // class LoginScreen extends StatelessWidget {
// //   const LoginScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //         body: Column(
// //       children: [
// //         Container(
// //           width: 390,
// //           height: 760,
// //           clipBehavior: Clip.antiAlias,
// //           decoration: const BoxDecoration(color: Colors.white),
// //           child: Stack(
// //             children: [
// //               const Positioned(
// //                 left: 95,
// //                 top: 190,
// //                 child: Text(
// //                   'Welcome back!',
// //                   style: TextStyle(
// //                     color: Color(0xFFFF7900),
// //                     fontSize: 30,
// //                     fontFamily: 'Shippori Mincho',
// //                     fontWeight: FontWeight.w700,
// //                     height: 1.54,
// //                   ),
// //                 ),
// //               ),
// //               Positioned(
// //                 left: 35,
// //                 top: 270,
// //                 child: SizedBox(
// //                   width: 350,
// //                   height: 265,
// //                   child: Stack(
// //                     children: [
// //                       Positioned(
// //                         left: 291,
// //                         top: 80,
// //                         child: Container(
// //                           width: 30,
// //                           height: 30,
// //                           clipBehavior: Clip.antiAlias,
// //                           decoration: const BoxDecoration(),
// //                         ),
// //                       ),
// //                       Positioned(
// //                         left: 0,
// //                         top: 50,
// //                         child: SizedBox(
// //                           width: 328,
// //                           height: 100,
// //                           child: Stack(
// //                             children: [
// //                               Positioned(
// //                                 left: 282,
// //                                 top: 40,
// //                                 child: Container(
// //                                   width: 30,
// //                                   height: 30,
// //                                   clipBehavior: Clip.antiAlias,
// //                                   decoration: const BoxDecoration(),
// //                                   child: const Stack(children: []),
// //                                 ),
// //                               ),
// //                               Positioned(
// //                                 left: 0,
// //                                 top: 40,
// //                                 child: Container(
// //                                   width: 328,
// //                                   height: 55,
// //                                   decoration: ShapeDecoration(
// //                                     shape: RoundedRectangleBorder(
// //                                       side: const BorderSide(
// //                                           width: 0.50,
// //                                           color: Color(0xFFFF7900)),
// //                                       borderRadius: BorderRadius.circular(15),
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ),
// //                               Positioned(
// //                                 left: 14,
// //                                 top: 25,
// //                                 child: SizedBox(
// //                                   width: 55,
// //                                   height: 18,
// //                                   child: Stack(
// //                                     children: [
// //                                       Positioned(
// //                                         left: 0,
// //                                         top: 0,
// //                                         child: Container(
// //                                           width: 55,
// //                                           height: 18,
// //                                           decoration: const BoxDecoration(
// //                                               color: Colors.white),
// //                                         ),
// //                                       ),
// //                                       const Positioned(
// //                                         left: 0,
// //                                         top: 0,
// //                                         child: Text(
// //                                           'Password',
// //                                           style: TextStyle(
// //                                             color: Color(0xFFFF7900),
// //                                             fontSize: 12,
// //                                             fontFamily: 'Shippori Mincho',
// //                                             fontWeight: FontWeight.w400,
// //                                             height: 1.42,
// //                                           ),
// //                                         ),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                               ),
// //                               Positioned(
// //                                 left: 16,
// //                                 top: 61,
// //                                 child: SizedBox(
// //                                   width: 78,
// //                                   height: 8,
// //                                   child: Stack(
// //                                     children: [
// //                                       Positioned(
// //                                         left: 0,
// //                                         top: 0,
// //                                         child: Container(
// //                                           width: 8,
// //                                           height: 8,
// //                                           decoration: const ShapeDecoration(
// //                                             color: Color.fromARGB(
// //                                                 51, 110, 117, 107),
// //                                             shape: OvalBorder(),
// //                                           ),
// //                                         ),
// //                                       ),
// //                                       Positioned(
// //                                         left: 40,
// //                                         top: 0,
// //                                         child: Container(
// //                                           width: 8,
// //                                           height: 8,
// //                                           decoration: const ShapeDecoration(
// //                                             color: Color.fromARGB(
// //                                                 51, 110, 117, 107),
// //                                             shape: OvalBorder(),
// //                                           ),
// //                                         ),
// //                                       ),
// //                                       Positioned(
// //                                         left: 10,
// //                                         top: 0,
// //                                         child: Container(
// //                                           width: 8,
// //                                           height: 8,
// //                                           decoration: const ShapeDecoration(
// //                                             color: Color.fromARGB(
// //                                                 51, 110, 117, 107),
// //                                             shape: OvalBorder(),
// //                                           ),
// //                                         ),
// //                                       ),
// //                                       Positioned(
// //                                         left: 50,
// //                                         top: 0,
// //                                         child: Container(
// //                                           width: 8,
// //                                           height: 8,
// //                                           decoration: const ShapeDecoration(
// //                                             color: Color.fromARGB(
// //                                                 51, 110, 117, 107),
// //                                             shape: OvalBorder(),
// //                                           ),
// //                                         ),
// //                                       ),
// //                                       Positioned(
// //                                         left: 20,
// //                                         top: 0,
// //                                         child: Container(
// //                                           width: 8,
// //                                           height: 8,
// //                                           decoration: const ShapeDecoration(
// //                                             color: Color.fromARGB(
// //                                                 51, 110, 117, 107),
// //                                             shape: OvalBorder(),
// //                                           ),
// //                                         ),
// //                                       ),
// //                                       Positioned(
// //                                         left: 60,
// //                                         top: 0,
// //                                         child: Container(
// //                                           width: 8,
// //                                           height: 8,
// //                                           decoration: const ShapeDecoration(
// //                                             color: Color.fromARGB(
// //                                                 51, 110, 117, 107),
// //                                             shape: OvalBorder(),
// //                                           ),
// //                                         ),
// //                                       ),
// //                                       Positioned(
// //                                         left: 30,
// //                                         top: 0,
// //                                         child: Container(
// //                                           width: 8,
// //                                           height: 8,
// //                                           decoration: const ShapeDecoration(
// //                                             color: Color.fromARGB(
// //                                                 51, 110, 117, 107),
// //                                             shape: OvalBorder(),
// //                                           ),
// //                                         ),
// //                                       ),
// //                                       Positioned(
// //                                         left: 70,
// //                                         top: 0,
// //                                         child: Container(
// //                                           width: 8,
// //                                           height: 8,
// //                                           decoration: const ShapeDecoration(
// //                                             color: Color.fromARGB(
// //                                                 51, 110, 117, 107),
// //                                             shape: OvalBorder(),
// //                                           ),
// //                                         ),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                               ),
// //                               Positioned(
// //                                 left: 28,
// //                                 top: 0,
// //                                 child: Container(
// //                                   width: 100,
// //                                   height: 100,
// //                                   clipBehavior: Clip.antiAlias,
// //                                   decoration: const BoxDecoration(),
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       ),
// //                       Positioned(
// //                         left: 0,
// //                         top: 0,
// //                         child: SizedBox(
// //                           width: 328,
// //                           height: 100,
// //                           child: Stack(
// //                             children: [
// //                               Positioned(
// //                                 left: 0,
// //                                 top: 10,
// //                                 child: Container(
// //                                   width: 328,
// //                                   height: 55,
// //                                   decoration: ShapeDecoration(
// //                                     shape: RoundedRectangleBorder(
// //                                       side: const BorderSide(
// //                                           width: 0.50,
// //                                           color: Color(0xFFFF7900)),
// //                                       borderRadius: BorderRadius.circular(15),
// //                                     ),
// //                                   ),
// //                                 ),
// //                               ),
// //                               Positioned(
// //                                 left: 14,
// //                                 top: 0,
// //                                 child: SizedBox(
// //                                   width: 82,
// //                                   height: 18,
// //                                   child: Stack(
// //                                     children: [
// //                                       Positioned(
// //                                         left: 0,
// //                                         top: 0,
// //                                         child: Container(
// //                                           width: 82,
// //                                           height: 18,
// //                                           decoration: const BoxDecoration(
// //                                               color: Colors.white),
// //                                         ),
// //                                       ),
// //                                       const Positioned(
// //                                         left: 0,
// //                                         top: 0,
// //                                         child: Text(
// //                                           'Adresse  email',
// //                                           style: TextStyle(
// //                                             color: Color(0xFFFF7900),
// //                                             fontSize: 12,
// //                                             fontFamily: 'Shippori Mincho',
// //                                             fontWeight: FontWeight.w400,
// //                                             height: 1.42,
// //                                           ),
// //                                         ),
// //                                       ),
// //                                     ],
// //                                   ),
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       ),
// //                       const Positioned(
// //                         left: 17,
// //                         top: 28,
// //                         child: Text(
// //                           'Entrez votre email',
// //                           style: TextStyle(
// //                             color: Color.fromARGB(51, 110, 117, 107),
// //                             fontSize: 14,
// //                             fontFamily: 'Shippori Mincho',
// //                             fontWeight: FontWeight.w400,
// //                             height: 1.29,
// //                           ),
// //                         ),
// //                       ),
// //                       const Positioned(
// //                         left: 17,
// //                         top: 228,
// //                         child: Text(
// //                           'Enter your password ',
// //                           style: TextStyle(
// //                             color: Color.fromARGB(51, 110, 117, 107),
// //                             fontSize: 14,
// //                             fontFamily: 'Shippori Mincho',
// //                             fontWeight: FontWeight.w400,
// //                             height: 1.29,
// //                           ),
// //                         ),
// //                       ),
// //                       Positioned(
// //                         left: 1,
// //                         top: 210,
// //                         child: Container(
// //                           width: 328,
// //                           height: 54,
                          
// //                           padding: const EdgeInsets.symmetric(
// //                               horizontal: 10, vertical: 16),
// //                           decoration: ShapeDecoration(
// //                             color: const Color(0xFFFF7900),
// //                             shape: RoundedRectangleBorder(
// //                               borderRadius: BorderRadius.circular(15),
// //                             ),
// //                           ),
// //                           child: const Row(
// //                             mainAxisSize: MainAxisSize.min,
// //                             mainAxisAlignment: MainAxisAlignment.center,
// //                             crossAxisAlignment: CrossAxisAlignment.center,
// //                             children: [
// //                               Text(
// //                                 'Login',
// //                                 style: TextStyle(
// //                                   color: Color(0xFFFFFEFC),
// //                                   fontSize: 14,
// //                                   fontFamily: 'Shippori Mincho',
// //                                   fontWeight: FontWeight.w700,
// //                                   height: 1.29,
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       ),
// //                       const Positioned(
// //                         left: 204,
// //                         top: 153,
// //                         child: Text(
// //                           'Forgot password?',
// //                           style: TextStyle(
// //                             color: Color(0xFFFF7900),
// //                             fontSize: 14,
// //                             fontFamily: 'Shippori Mincho',
// //                             fontWeight: FontWeight.w700,
// //                             height: 1.29,
// //                           ),
// //                         ),
// //                       ),
// //                       Positioned(
// //                         left: 13,
// //                         top: 130,
// //                         child: SizedBox(
// //                           width: 127,
// //                           height: 24,
// //                           child: Stack(
// //                             children: [
// //                               Positioned(
// //                                 left: 0,
// //                                 top: 0,
// //                                 child: Container(
// //                                   width: 24,
// //                                   height: 24,
// //                                   clipBehavior: Clip.antiAlias,
// //                                   decoration: const BoxDecoration(),
// //                                   child: const Column(
// //                                     mainAxisSize: MainAxisSize.min,
// //                                     mainAxisAlignment: MainAxisAlignment.start,
// //                                     crossAxisAlignment:
// //                                         CrossAxisAlignment.start,
// //                                     children: [],
// //                                   ),
// //                                 ),
// //                               ),
// //                               const Positioned(
// //                                 left: 28,
// //                                 top: 13,
// //                                 child: Text(
// //                                   ' ',
// //                                   style: TextStyle(
// //                                     color: Color(0xFFFF7900),
// //                                     fontSize: 14,
// //                                     fontFamily: 'Shippori Mincho',
// //                                     fontWeight: FontWeight.w400,
// //                                     height: 1.29,
// //                                   ),
// //                                 ),
// //                               ),
// //                             ],
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ),
// //               Positioned(
// //                 left: 16,
// //                 top: 32,
// //                 child: Stack(
// //                   children: [
// //                     Positioned(
// //                       left: 0,
// //                       top: 0,
// //                       child: Container(
// //                         width: 24,
// //                         height: 24,
// //                         clipBehavior: Clip.antiAlias,
// //                         decoration: const BoxDecoration(),
// //                         child: const Column(
// //                           mainAxisSize: MainAxisSize.min,
// //                           mainAxisAlignment: MainAxisAlignment.start,
// //                           crossAxisAlignment: CrossAxisAlignment.start,
// //                           children: [],
// //                         ),
// //                       ),
// //                     ),
// //                     const Positioned(
// //                       left: 27,
// //                       top: 3,
// //                       child: Text(
// //                         'Back',
// //                         style: TextStyle(
// //                           color: Color(0xFFFF7900),
// //                           fontSize: 14,
// //                           fontFamily: 'Shippori Mincho',
// //                           fontWeight: FontWeight.w400,
// //                           height: 1.29,
// //                         ),
// //                       ),
// //                     ),
// //                   ],
// //                 ),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ],
// //     ));
// //   }
// // }




// // // ignore_for_file: unnecessary_const

// // import 'package:flutter/material.dart';
// // import 'package:flutter_login/flutter_login.dart';
// // // ignore: unused_import
// // import 'package:flutter_login/theme.dart';
// // import 'package:project/screens/home_sreen.dart';

// // const users = {
// //   'dribbble@gmail.com': '12345',
// //   'hunter@gmail.com': 'hunter',
// // };

// // class LoginUserType {
// //   static const normalUser = "normal";
// //   static const adminUser = "admin";
// //   static const guestUser = "guest";

// //   late final String name;
// // }

// // class Icon {}

// // class LoginScreen extends StatelessWidget {
// //   const LoginScreen({super.key});

// //   Duration get loginTime => const Duration(milliseconds: 2250);

// //   Future<String?> _authUser(LoginData data) {
// //     debugPrint('Name: ${data.name}, Password: ${data.password}');
// //     return Future.delayed(loginTime).then((_) {
// //       if (!users.containsKey(data.name)) {
// //         return 'User not exists';
// //       }
// //       if (users[data.name] != data.password) {
// //         return 'Password does not match';
// //       }
// //       return null;
// //     });
// //   }

// //   Future<String?> _signupUser(SignupData data) {
// //     debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
// //     return Future.delayed(loginTime).then((_) {
// //       return null;
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     const inputBorder = BorderRadius.vertical(
// //       bottom: Radius.circular(10.0),
// //       top: Radius.circular(20.0),
// //     );

// //     return FlutterLogin(
// //       title: 'OE Score',
// //       logo: const AssetImage('assets/images/ecorp-lightblue.png'),
// //       onLogin: _authUser,
// //       onSignup: _signupUser,
// //       onSubmitAnimationCompleted: () {
// //         Navigator.of(context).pushReplacement(MaterialPageRoute(
// //           builder: (context) => const HomeScreen(),
// //         ));
// //       },
// //       onRecoverPassword: (_) => Future(() => null),
// //       theme: LoginTheme(
// //         primaryColor: Colors.white,
// //         accentColor: Colors.yellow,
// //         errorColor: Colors.red,
// //         titleStyle: const TextStyle(
// //           color: Colors.orange,
// //           fontFamily: 'Quicksand',
// //           letterSpacing: 4,
// //         ),
// //         bodyStyle: const TextStyle(
// //           fontStyle: FontStyle.italic,
// //           decoration: TextDecoration.underline,
// //         ),
// //         textFieldStyle: const TextStyle(
// //           color: Colors.white,
// //           shadows: [Shadow(color: Colors.yellow, blurRadius: 2)],
// //         ),
// //         buttonStyle: const TextStyle(
// //           fontWeight: FontWeight.w800,
// //           color: Colors.yellow,
// //         ),
// //         cardTheme: CardTheme(
// //           color: Colors.orange,
// //           elevation: 5,
// //           margin: const EdgeInsets.only(top: 15),
// //           shape: ContinuousRectangleBorder(
// //               borderRadius: BorderRadius.circular(100.0)),
// //         ),
// //         inputTheme: InputDecorationTheme(
// //           filled: true,
// //           fillColor: Colors.purple.withOpacity(.1),
// //           contentPadding: EdgeInsets.zero,
// //           errorStyle: const TextStyle(
// //             backgroundColor: Colors.red,
// //             color: Colors.white,
// //           ),
// //           labelStyle: const TextStyle(fontSize: 12),
// //           enabledBorder: const UnderlineInputBorder(
// //             borderSide: BorderSide(color: Colors.white, width: 4),
// //             borderRadius: inputBorder,
// //           ),
// //           focusedBorder: const UnderlineInputBorder(
// //             borderSide: BorderSide(color: Colors.white, width: 5),
// //             borderRadius: inputBorder,
// //           ),
// //           errorBorder: const UnderlineInputBorder(
// //             borderSide: BorderSide(color: Colors.black12, width: 4),
// //             borderRadius: inputBorder,
// //           ),
// //           focusedErrorBorder: const UnderlineInputBorder(
// //             borderSide: BorderSide(color: Colors.black12, width: 4),
// //             borderRadius: inputBorder,
// //           ),
// //           disabledBorder: const UnderlineInputBorder(
// //             borderSide: const BorderSide(color: Colors.grey, width: 5),
// //             borderRadius: inputBorder,
// //           ),
// //         ),
// //         buttonTheme: LoginButtonTheme(
// //           splashColor: Colors.orange,
// //           backgroundColor: Colors.black,
// //           highlightColor: Colors.white,
// //           elevation: 9.0,
// //           highlightElevation: 6.0,
// //           shape: BeveledRectangleBorder(
// //             borderRadius: BorderRadius.circular(10),
// //           ),
// //           // shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
// //           // shape: CircleBorder(side: BorderSide(color: Colors.green)),
// //           // shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(55.0)),
// //         ),
// //       ),
// //     );
// //   }
// // }

// // // Exemple en utilisant la bibliothèque 'http'

// // // import 'dart:convert';
// // // import 'package:http/http.dart' as http;

// // // Future<void> createUser() async {
// // //   final String apiUrl = 'http://your-domain/api/create_user/';
// // //   final Map<String, String> headers = {
// // //     'Content-Type': 'application/json',
// // //     'Authorization': 'Token YOUR_AUTH_TOKEN',
// // //   };
// // //   final Map<String, dynamic> userData = {
// // //     'username': 'newuser',
// // //     'email': 'newuser@example.com',
// // //     'password': 'newpassword',
// // //   };
// // //   final http.Response response = await http.post(apiUrl, headers: headers, body: jsonEncode(userData));

// // //   if (response.statusCode == 201) {
// // //     print('User created successfully!');
// // //     print(jsonDecode(response.body));
// // //   } else {
// // //     print('Failed to create user. Status code: ${response.statusCode}');
// // //     print(jsonDecode(response.body));
// // //   }
// // // }

// // // import 'dart:convert';
// // // import 'package:http/http.dart' as http;

// // // Future<void> createUser(String username, String email, String password) async {
// // //   final url = 'https://your-django-api.com/api/users/';
// // //   final body = jsonEncode({
// // //     'username': username,
// // //     'email': email,
// // //     'password': password,
// // //   });

// // //   final response = await http.post(
// // //     Uri.parse(url),
// // //     headers: {'Content-Type': 'application/json'},
// // //     body: body,
// // //   );

// // //   if (response.statusCode == 201) {
// // //     print('Utilisateur créé avec succès');
// // //   } else {
// // //     print('Erreur lors de la création de l\'utilisateur');
// // //   }
// // // }

// // // import 'package:flutter/material.dart';
// // // import 'package:flutter_login/flutter_login.dart';
// // // import 'dashboard_screen.dart';

// // // const users = const {
// // //   'dribbble@gmail.com': '12345',
// // //   'hunter@gmail.com': 'hunter',
// // // };

// // // class LoginScreen extends StatelessWidget {
// // //   Duration get loginTime => Duration(milliseconds: 2250);

// // //   Future<String?> _authUser(LoginData data) {
// // //     debugPrint('Name: ${data.name}, Password: ${data.password}');
// // //     return Future.delayed(loginTime).then((_) {
// // //       if (!users.containsKey(data.name)) {
// // //         return 'User not exists';
// // //       }
// // //       if (users[data.name] != data.password) {
// // //         return 'Password does not match';
// // //       }
// // //       return null;
// // //     });
// // //   }

// // //   Future<String?> _signupUser(SignupData data) {
// // //     debugPrint('Signup Name: ${data.name}, Password: ${data.password}');
// // //     return Future.delayed(loginTime).then((_) {
// // //       return null;
// // //     });
// // //   }

// // //   Future<String> _recoverPassword(String name) {
// // //     debugPrint('Name: $name');
// // //     return Future.delayed(loginTime).then((_) {
// // //       if (!users.containsKey(name)) {
// // //         return 'User not exists';
// // //       }
// // //       return null;
// // //     });
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return FlutterLogin(
// // //       title: 'ECORP',
// // //       logo: AssetImage('assets/images/ecorp-lightblue.png'),
// // //       onLogin: _authUser,
// // //       onSignup: _signupUser,
// // //       onSubmitAnimationCompleted: () {
// // //         Navigator.of(context).pushReplacement(MaterialPageRoute(
// // //           builder: (context) => DashboardScreen(),
// // //         ));
// // //       },
// // //       onRecoverPassword: _recoverPassword,
// // //     );
// // //   }
// // // }

// // // pour django

// // // import 'dart:convert';
// // // import 'package:flutter/material.dart';
// // // import 'package:http/http.dart' as http;

// // // class SignupScreen extends StatelessWidget {
// // //   final TextEditingController usernameController = TextEditingController();
// // //   final TextEditingController passwordController = TextEditingController();

// // //   Future<void> signUp() async {
// // //     final response = await http.post(
// // //       Uri.parse('http://your-django-api-url/signup/'),
// // //       body: jsonEncode({
// // //         'username': usernameController.text,
// // //         'password': passwordController.text,
// // //       }),
// // //       headers: {'Content-Type': 'application/json'},
// // //     );

// // //     if (response.statusCode == 201) {
// // //       // Utilisateur inscrit avec succès
// // //     } else {
// // //       // Gérer l'erreur
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       body: Column(
// // //         children: [
// // //           TextFormField(
// // //             controller: usernameController,
// // //             decoration: InputDecoration(labelText: 'Nom d\'utilisateur'),
// // //           ),
// // //           TextFormField(
// // //             controller: passwordController,
// // //             decoration: InputDecoration(labelText: 'Mot de passe'),
// // //           ),
// // //           ElevatedButton(
// // //             onPressed: signUp,
// // //             child: Text('S\'inscrire'),
// // //           ),
// // //         ],
// // //       ),
// // //     );
// // //   }
// // // }
