import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class Inscription extends StatefulWidget {

  // TextEditingController txtnomUtilisateur ;
  // TextEditingController txtMdp ;
  // void Function()  clickValider ;

   Inscription(/*{*/ 
    // required this.txtnomUtilisateur,
    // required this.txtMdp,
    // required this.clickValider
    /*}*/) ;

  @override
  State<Inscription> createState() => _InscriptionState();
}

class _InscriptionState extends State<Inscription> {

  final txtcnxnomUtilisateur = TextEditingController();
  final txtMdp = TextEditingController();
  
  void signIn(String username ,String password ) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/users/inscrire/');
    final response = await http.post(url,
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'}, 
      body: json.encode({
        "username": username,
        "password": password
      })
    );

    if (response.statusCode == 200 || response.statusCode == 201 ) {
      print('Inscription reussie de ' + username.toString() + " mdp " + password.toString() + " " );
    } else {
      throw Exception('Echec de l\'inscription de .' + username.toString() + " mdp " + password.toString() );
    }
  } 

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.45,
      child: Column(
        children: [

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Nom d\'utilisateur ',
              ),
              controller: /*widget.*/txtcnxnomUtilisateur,
            ),
          ),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Mot de passe',
              ),
              controller: /*widget.*/txtMdp,
            ),
          ),
          //Todo dans inscription si on fini de clicker sur valider ils doivent nous dire c'est bon 
          //Et rediriger vers formulaire de connexion
          ElevatedButton(
            child: Text("Valider"),
            onPressed: (){
              signIn(/*widget.*/txtcnxnomUtilisateur.text, /*widget.*/txtMdp.text);
              Navigator.pop(context);
            }
          ),

        ],
      ),
    );
  }
}