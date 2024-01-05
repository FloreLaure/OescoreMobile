import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Prospection {
  final int id;
  final String client;
  final String produit;
  final int upfront;
  final int predictedScore;

  Prospection(
      this.id, this.client, this.produit, this.upfront, this.predictedScore);

  factory Prospection.fromJson(Map<String, dynamic> json) {
    return Prospection(
      json['id'],
      json['client']['groupname'], // Accédez aux données du client correctement
      json['produit']['name'], // Accédez aux données du produit correctement
      json['upfront'],
      json['predicted_score'],
    );
  }
}

class Historique extends StatefulWidget {
  @override
  _HistoriqueState createState() => _HistoriqueState();
}

class _HistoriqueState extends State<Historique> {
  List<Prospection> prospections = [];

  @override
  void initState() {
    super.initState();
    fetchProspections().then((prospections) {
      setState(() {
        this.prospections = prospections;
      });
    });
  }

  Future<List<Prospection>> fetchProspections() async {
    final response = await http.get(Uri.parse(
        'https://votre-api-django.com/prospections/')); // Assurez-vous de mettre l'URL correcte

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => Prospection.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load prospections');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Liste des Prospections'),
        ),
        body: ListView.builder(
          itemCount: prospections.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Client: ${prospections[index].client}'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Produit: ${prospections[index].produit}'),
                  Text('Upfront: ${prospections[index].upfront.toString()}'),
                  Text(
                      'Score Prédit: ${prospections[index].predictedScore.toString()}'),
                ],
              ),
              // Vous pouvez ajouter plus d'informations ici ou personnaliser l'affichage.
            );
          },
        ),
      ),
    );
  }
}
