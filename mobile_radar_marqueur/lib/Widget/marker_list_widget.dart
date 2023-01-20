import 'package:flutter/material.dart';
import 'package:mobile_radar_marqueur/modele/markeur.dart';

class MarkerListWidget extends StatelessWidget {
  final List<Markeur>? marqueur;
  // final List<Markeur> marqueur;
  // final List<Markeur> marqueur;
  // final String desscriptiontext ; 

   MarkerListWidget({ 
     required this.marqueur 
   }) ;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          ListView.builder(
            itemCount: marqueur!.length,
            itemBuilder: (context, index){

              return ListTile(
                  title: Text(marqueur![index].description.toString()),
                  subtitle: Text('La latitude est de ' + marqueur![index].latitude.toString()),
                  trailing: Text('La longitude est de ' +marqueur![index].longitude.toString()),
                  // leading: Text(DateTime.tryParse(snapshot.data!.datecreation.toString()).toString()),
                  );
            }
          )

        ],
      ),
    );
  }
}