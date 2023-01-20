import 'package:flutter/material.dart';

class Inscription extends StatelessWidget {

  TextEditingController txtnomUtilisateur ;
  TextEditingController txtMdp ;
  void Function()  clickValider ;

   Inscription({ 
    required this.txtnomUtilisateur,
    required this.txtMdp,
    required this.clickValider
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
              controller: txtnomUtilisateur,
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
              controller: txtMdp,
            ),
          ),
          //Todo dans inscription si on fini de clicker sur valider ils doivent nous dire c'est bon 
          //Et rediriger vers formulaire de connexion
          ElevatedButton(
            child: Text("Valider"),
            onPressed: clickValider
          ),

        ],
      ),
    );
  }
}