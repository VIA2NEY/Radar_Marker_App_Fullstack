import 'package:flutter/material.dart';

class Connexion extends StatelessWidget {

  TextEditingController txtcnxnomUtilisateur ;
  TextEditingController txtcnxMdp ;

   Connexion({ 
    required this.txtcnxnomUtilisateur,
    required this.txtcnxMdp
    }) ;

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
              controller: txtcnxnomUtilisateur,
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
              controller: txtcnxMdp,
            ),
          ),

          ElevatedButton(
            child: Text("Valider"),
            onPressed: (){} 
          ),

        ],
      ),
    );
  }
}