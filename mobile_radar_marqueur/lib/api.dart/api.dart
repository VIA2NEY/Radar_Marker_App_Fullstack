import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_radar_marqueur/modele/markeur.dart';

class MarkeurProvider with ChangeNotifier  {
  
  // TodoProvider() {
  //   this.fetchTasks();
  // }

  List<Markeur> _marqueurs = [];

  List<Markeur> get marqueurs {
    return [..._marqueurs];
  }

  void addTodo(Markeur marqueur) async {
    final url = Uri.parse('http://127.0.0.1:8000/apis/v1/');
    final response = await http.post(url,
      headers: {"Content-Type": "application/json"}, 
      body: json.encode(marqueur));

      if (response.statusCode == 201) {
        marqueur.id = json.decode(response.body)['id'];
        _marqueurs.add(marqueur);
        notifyListeners();
      }

  }

  // void deleteTodo(Markeur markeurdelete) async {
  //   final response =
  //       await http.delete('http://127.0.0.1:8000/apis/v1/${markeurdelete.id}/');
  //   if (response.statusCode == 204) {
  //     _marqueurs.remove(markeurdelete);
  //     notifyListeners();
  //   }
  // }

  // fetchTasks() async {
  //   // final url = 'http://127.0.0.1:8000/apis/v1/?format=json';
  //   final url = 'http://127.0.0.1:8000/apis/v1/';
  //   final response = await http.get(Uri.parse(url));
  //   print('EXECUTION DE FETCH');
  //   if (response.statusCode == 200) {
  //     print('Status ' + response.statusCode.toString());
  //     var data = json.decode(response.body) as List;
  //     _marqueurs = data.map<Markeur>((json) => Markeur.fromJson(json)).toList();
  //     notifyListeners();

  //     print('Les donnees' + data.toString());
  //   }
  // }

  // Future<Markeur> fetchAlbum() async {
  //   final response = await http
  //       .get(Uri.parse('http://127.0.0.1:8000/apis/v1/?format=json'));

  //   print('EXECUTION DE FETCH');
    
  //   if (response.statusCode == 200) {
  //     // If the server did return a 200 OK response,
  //     // then parse the JSON.
  //     return Markeur.fromJson(jsonDecode(response.body));
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Failed to load album');
  //   }
  // }


}