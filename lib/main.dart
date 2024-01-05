// import 'dart:ui';

import 'package:flutter/material.dart';
// ignore: unnecessary_import
// ignore: unused_import
import 'package:project/screens/formulaire.dart';
import 'package:project/screens/Historique.dart';
// import 'package:flutter/services.dart';
// ignore: unused_import
import 'package:project/screens/login.dart';
import 'package:project/screens/prospection.dart';
// ignore: unused_import
import 'package:project/screens/register.dart';
import 'package:project/screens/score.dart';
import 'package:flutter/foundation.dart';
// import 'package:project/screens/home_sreen.dart';

// import 'package:http/http.dart' as http;
// import 'dart:async';
// import 'dart:convert';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false, // Désactive la bannière de débogage
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Future<http.Response> fetchAlbum() {
  //   return http.get(Uri.parse('lien de l api'));
  // }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.red, // Changez la couleur ici
      ),
      title: 'Flutter Demo',
      home: const LoginScreen(),
    );
  }
}


//   ThemeData myTheme() {
//     final base = ThemeData.light();
//     const pgfColor = Color.fromARGB(255, 156, 56, 108);
//     final colorScheme =
//         ColorScheme.fromSeed(seedColor: pgfColor, primary: pgfColor);
//     return base.copyWith(
//       colorScheme: colorScheme,
//       floatingActionButtonTheme:
//           base.floatingActionButtonTheme.copyWith(backgroundColor: pgfColor),
//       bottomNavigationBarTheme:
//           base.bottomNavigationBarTheme.copyWith(backgroundColor: pgfColor),
//       cardTheme: base.cardTheme.copyWith(
//         color: Colors.orange,
//         elevation: 5,
//         margin: const EdgeInsets.only(top: 15),
//         shape: ContinuousRectangleBorder(
//             borderRadius: BorderRadius.circular(100.0)),
//       ),
//       inputDecorationTheme: base.inputDecorationTheme.copyWith(
//         filled: true,
//         fillColor: Colors.purple.withOpacity(.1),
//         contentPadding: EdgeInsets.zero,
//         errorStyle: const TextStyle(
//           backgroundColor: Colors.red,
//           color: Colors.white,
//         ),
//       ),
//       buttonTheme: base.buttonTheme.copyWith(
//         splashColor: Colors.orange,
//         buttonColor: Colors.black,
//         highlightColor: Colors.white,
//         shape: BeveledRectangleBorder(
//           borderRadius: BorderRadius.circular(10),
//         ),
//       ),
//     );
//   }
// }




//  theme: ThemeData(
//         brightness: Brightness.light,
//         primaryColor: Colors.orange,
//         hintColor: Colors.deepOrangeAccent,
//         fontFamily: 'Georgia',

//         //text styling
//         textTheme: const TextTheme(
//           displayLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
//           titleLarge: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
//           bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
//         ),
//       ),

// // ignore: non_constant_identifier_names
// ThemeData BuildTheme() {
//   return  ThemeData();
// }









// class MyHomePage extends StatefulWidget {
//   const MyHomePage({super.key, required this.title});

//   // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

//   final String title;

//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   int _counter = 0;

//   void _incrementCounter() {
//     setState(() {
//       // This call to setState tells the Flutter framework that something has
//       // changed in this State, which causes it to rerun the build method below
//       // so that the display can reflect the updated values. If we changed
//       // _counter without calling setState(), then the build method would not be
//       // called again, and so nothing would appear to happen.
//       _counter++;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     // This method is rerun every time setState is called, for instance as done
//     // by the _incrementCounter method above.
//     //
//     // The Flutter framework has been optimized to make rerunning build methods
//     // fast, so that you can just rebuild anything that needs updating rather
//     // than having to individually change instances of widgets.
//     return Scaffold(
//       appBar: AppBar(
//         // TRY THIS: Try changing the color here to a specific color (to
//         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
//         // change color while the other colors stay the same.
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         // Here we take the value from the MyHomePage object that was created by
//         // the App.build method, and use it to set our appbar title.
//         title: Text(widget.title),
//       ),
//       body: Center(
//         // Center is a layout widget. It takes a single child and positions it
//         // in the middle of the parent.
//         child: Column(
//           // Column is also a layout widget. It takes a list of children and
//           // arranges them vertically. By default, it sizes itself to fit its
//           // children horizontally, and tries to be as tall as its parent.
//           //
//           // Column has various properties to control how it sizes itself and
//           // how it positions its children. Here we use mainAxisAlignment to
//           // center the children vertically; the main axis here is the vertical
//           // axis because Columns are vertical (the cross axis would be
//           // horizontal).
//           //
//           // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
//           // action in the IDE, or press "p" in the console), to see the
//           // wireframe for each widget.
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             const Text(
//               'You have pushed the button this many times:',
//             ),
//             Text(
//               '$_counter',
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//           ],
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: _incrementCounter,
//         tooltip: 'Increment',
//         child: const Icon(Icons.add),
//       ), // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }