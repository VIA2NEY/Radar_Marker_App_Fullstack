import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Connexion extends StatefulWidget {

  TextEditingController txtcnxnomUtilisateur ;
  TextEditingController txtcnxMdp ;
  void onsave ;
   Connexion({
    required this.txtcnxnomUtilisateur,
    required this.txtcnxMdp,
    this.onsave
  });/*Pour en dure  */
  
 

  //  Connexion() ; Pour pas en dure

  @override
  State<Connexion> createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {

  // final txtcnxnomUtilisateur = TextEditingController(); pour dynamic on dirait
  // final txtcnxMdp = TextEditingController();

  Future logIn(String username ,String password ) async {
  final url = Uri.parse('http://10.0.2.2:8000/api/users/login/');
  final response = await http.post(url,
    // headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'}, 
    body: {
      "username": username,
      "password": password
    }
  );

  if (response.statusCode == 201 || response.statusCode == 200 ) {
    print('Authenthification reussie ' + username.toString() + " " + password.toString() + " " );
  } else {
    throw Exception('Echec de l\'authentification de ' + username.toString() + " mdp :" + password.toString());
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
              controller: widget.txtcnxnomUtilisateur,
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
              controller: widget.txtcnxMdp,
            ),
          ),

          ElevatedButton(
            child: Text("Valider"),
            onPressed: ()async {
              // await logIn (txtcnxnomUtilisateur.text , txtcnxMdp.text);
              Navigator.pop(context);
              
            },
           
          ),

        ],
      ),
    );
  }
}