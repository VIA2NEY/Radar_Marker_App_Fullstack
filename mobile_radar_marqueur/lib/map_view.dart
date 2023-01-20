import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

import 'modele/Localisation.dart';
import 'modele/MarkerVisible.dart';

import 'Ecrans/SousEcrans.dart/FormulaireInscription.dart';
import 'package:mobile_radar_marqueur/Ecrans/SousEcrans.dart/FormulaireConnexion.dart';



enum SampleItem { Inscription, connexion }

class MapviewTest extends StatefulWidget {
  const MapviewTest({ Key? key }) : super(key: key);

  @override
  State<MapviewTest> createState() => _MapviewTestState();
}

class _MapviewTestState extends State<MapviewTest> {
  MapController _mapController =  MapController() ;

  final txtnomUtilisateur = TextEditingController();
  final txtMdp = TextEditingController();
  final txtcnxnomUtilisateur = TextEditingController();
  final txtcnxMdp = TextEditingController();

  //Je peut remplacer image la par des couleurs la sa vas changer de couleur en fonction du marquer
  List<String> images = ['images/car.png','images/bus.png', 'images/travelling.png', 'images/bycicle.png', 'images/food-delivery.png'];

  VisibleMarker lemarqueur = VisibleMarker();
  Utilisateur utilisateur = Utilisateur();

  // created empty list of markers
  final List<Marker> _markers = <Marker>[];
    
  SampleItem? menuSelectioner;

  late Position _currentPosition;//Suprime later

  @override
  void initState() {

    lemarqueur.marqueurbd ;
    utilisateur.user;
    
    print(lemarqueur.marqueurbd.length);    

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    Localisation localisation = Localisation();

    List<Marker> markers = [];

    return  Scaffold(
      appBar: AppBar(
        title: Text('Marker APP'),
        centerTitle: true,
        actions: [
          PopupMenuButton<SampleItem>(
            initialValue: menuSelectioner,

            onSelected: (SampleItem item) {
              setState(() {
                menuSelectioner = item;
              });
              switch (item) {
                case SampleItem.Inscription: 
                  showDialog(
                    context: context, 
                    builder: (context){
                      return AlertDialog(
                        title: Center(child: Text("Inscription")),
                        backgroundColor: Colors.white,
                        content: StatefulBuilder(
                          builder: (context, setState) =>
                          Inscription(txtnomUtilisateur: txtnomUtilisateur, txtMdp: txtMdp, clickValider: SaveInscription)
                          
                        )
 
                      );
                    }
                  );
                  
                  break;
                  case SampleItem.connexion :

                    showDialog(
                    context: context, 
                    builder: (context){
                      return AlertDialog(
                        title: Center(child: Text("Connexion")),
                        backgroundColor: Colors.white,
                        content: StatefulBuilder(
                          builder: (context, setState) =>
                          Connexion(txtcnxnomUtilisateur: txtcnxnomUtilisateur, txtcnxMdp: txtcnxMdp)

                        )
                      );
                    }
                  );

                  break;
              }


            },

            itemBuilder: (BuildContext context) => <PopupMenuEntry<SampleItem>>[
              const PopupMenuItem<SampleItem>(
                value: SampleItem.Inscription,
                child: Text('S\'inscrire'),
                
              ),
              const PopupMenuItem<SampleItem>(
                value: SampleItem.connexion,
                child: Text('Se connecter'),
              ),
            ],
          ),
          // Icon(
          //   Icons.more_vert,
          // ),
        ],
      ),
      body: Center(
        child: Column(
          children: [

            Flexible(
              child:  FlutterMap(
                mapController: _mapController,
                options: MapOptions(
                  center: LatLng(5.225936, -3.753666/*localisation.latitudeAppareil!, localisation.longitudeAppareil!*/),
                  zoom: 15,
                  onTap: (tapPosition, point) =>{
                    print(point.toString()),
                    
                    // loadDataone(point)
                    // creation_marker(point),
            //TODO APRES ICI AJOUTER CONDITION SI IL Y'a Username + MDP execute sinon ne fait rien

                    if (txtcnxnomUtilisateur.text != 'vianney' || txtcnxMdp.text != '1234') {
                      
                    } else {
                      setState(() {
                      lemarqueur.marqueurbd.add(
                        Marker(
                          
                          width: 150.0,
                          height: 150.0,
                          point: point,
                          builder: (ctx) => InkWell(
                            // onTap: MarkerClicked(point),
                            child: Container(
                              child: IconButton(
                                onPressed: (){
                                 showModalBottomSheet(
                                    context: context, 
                                    builder: (builder){
                                      return Container(
                                        color: Colors.white,
                                        child: Column(
                                          children: [
                                            SizedBox(height: 10,),
                                            const Center(
                                              child : Text(
                                                " Informations ",
                                                style: TextStyle(
                                                  fontSize: 24,
                                                  fontWeight: FontWeight.w500
                                                ),
                                              ),
                                            ),

                                            const Padding(
                                              padding: const EdgeInsets.fromLTRB(10,20,10,20),
                                              child: Center(
                                                child: Icon(
                                                  Icons.photo,
                                                  size: 120,
                                                ),
                                              ),
                                            ),

                                            ListTile(
                                              leading: Text("La latitude :",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300),),
                                              title: Text(point.latitude.toStringAsFixed(4),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300),),
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                            ),

                                            ListTile(
                                              leading: Text("La longitude :",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300),),
                                              title: Text(point.longitude.toStringAsFixed(4),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300),),
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                            ),

                                            ListTile(
                                              leading: Text("Description :",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300),),
                                              title: Text("Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock, a Latin professor at Hampden-Sydney College in Virginia,",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300),maxLines: 3,),
                                              onTap: () {
                                                Navigator.pop(context);
                                              },
                                            ),

                                            
                                            // Text('La latitude est de ' + point.latitude.toString()),
                                            // Text('La Longitude est de ' + point.longitude.toString()),
                                            Padding(
                                              padding: const EdgeInsets.all(19.0),
                                              child: Text('Itinéraire sur google map'),
                                            ),
                                          ],
                                        ),
                                      );
                                    }
                                  );
                                },
                                icon: const Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                  size: 35.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );

                      print('le nbre de marquer dans la methode ' + lemarqueur.marqueurbd.length.toString());
                    })
                    }
                    
                  },
                  maxZoom: 19,
                  ),

                  layers: [
                  TileLayerOptions(                   
                    urlTemplate:
                        "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                    subdomains: ['a', 'b', 'c']
                  ),
                  MarkerLayerOptions(
                    markers: [
                        for (int i = 0; i < lemarqueur.marqueurbd.length; i++) lemarqueur.marqueurbd[i]
                      ],
                  )
                ],

                  // layers: [
                  //   MarkerLayerOptions(
                  //     markers: [
                  //       for (int i = 0; i < markers.length; i++) markers[i]
                  //     ],
                  //   ),
                  // ],
              ),

            )

          ],
        ),
      ),
    );
    
  }

   void Function()? MarkerClicked (LatLng point){
    showDialog(
      context: context, 
      builder: (context){
        return Column(
          children: [
            Text('Les coordonnées : ' + point.toString()),
            Text('La latitude est '),
          ],
        );

      }
    );
  }

  void SaveInscription (){
    setState(() {
      utilisateur.user.add([
        txtnomUtilisateur.text, 
        txtMdp.text
      ]);
      
      print(utilisateur.user.toString());
    });
  }

  void creation_marker (LatLng point){
    setState(() {
      _markers.add(
        Marker(
          width: 150.0,
          height: 150.0,
          point: point,
          builder: (ctx) => const Icon(
            Icons.location_on,
            color: Colors.red,
            size: 35.0,
          ),
        ),
      );
      print('le nbre de marquer dans la methode ' + _markers.length.toString());
    });
  }
}