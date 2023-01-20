
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_radar_marqueur/modele/markeur.dart';


import 'package:http/http.dart' as http;

class AddMarqueurScreen extends StatefulWidget {
  @override
  _AddMarqueurScreenState createState() => _AddMarqueurScreenState();
}

class _AddMarqueurScreenState extends State<AddMarqueurScreen> {

  final latitude = TextEditingController();
  final longitude = TextEditingController();
  final description = TextEditingController();



  Future<Markeur> createMarker(String description , double latitude , double longitude) async {

  print("Execution de create marker");

  final url = Uri.parse('http://10.0.2.2:8000/apis/v1/');
    final response = await http.post(url,
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'}, 
      body: json.encode({
        
        "latitude": latitude,
        "longitude": longitude,
        "description": description ,
        
      })
    );

  if (response.statusCode == 201) {
    
    print('Create marker OK');
    return Markeur.fromJson(jsonDecode(response.body));
  } else {
    
    throw Exception('Echec de creation de marqueur.');
  }
}

  @override
  Widget build(BuildContext context) {

    final String lattVal = latitude.text ;
    final String longVal = longitude.text;
    final String desVal = description.text;

    return Scaffold(
      appBar: AppBar(title: Text('Add Marker')),
      body: ListView(
        children: [
          Container(
            child: Column(
              children: [

                TextField(
                  controller: latitude,
                  decoration: InputDecoration(
                    hintText: 'Latitude',
                  ),
                ),

                TextField(
                  controller: longitude,
                  decoration: InputDecoration(
                    hintText: 'Longitude',
                  ),
                ),

                TextField(
                  controller: description,
                  decoration: InputDecoration(
                    hintText: 'Description',
                  ),
                ),

                ElevatedButton(
                    child: Text('Add'),
                    onPressed: () {

                      //Partie verification 
                      if (lattVal.isEmpty || longVal.isEmpty) {
                        // Affichage d'un message d'erreur à l'utilisateur
                        print('Entrez une valeur valide pour la latitude et la longitude');
                      } else {
                        double lat = double.parse(lattVal);
                        double long = double.parse(longVal);
                        createMarker(desVal, lat, long);
                        
                      }




                      //Partie essaie 
                      // double lat,long;
                      // try{
                      // lat = double.parse(lattVal);
                      // long = double.parse(longVal);

                      // print(double.parse(lattVal));
                      // print(double.parse(lattVal));

                      // createMarker(desVal, lat, long);
                      // } on FormatException catch(e){
                      //   print("Format exception : $e");
                      // }

                      // createMarker(desVal, double.parse(lattVal), double.parse(longVal));
                      Navigator.pop(context, true);
                    })


// I have a textcontroller and need to pass the text controller value to a parameter of a class that only accepts double as the input but by default the type of textcontroller is string                    
              ],
            )
          )
        ],
      ),
    );
  }
}