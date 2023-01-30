import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:mobile_radar_marqueur/modele/markeur.dart';

import 'modele/Localisation.dart';
import 'modele/MarkerVisible.dart';

import 'Ecrans/SousEcrans.dart/FormulaireInscription.dart';
import 'package:mobile_radar_marqueur/Ecrans/SousEcrans.dart/FormulaireConnexion.dart';

import 'package:http/http.dart' as http;



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
  final txtdescription = TextEditingController();

  //Je peut remplacer image la par des couleurs la sa vas changer de couleur en fonction du marquer
  List<String> images = ['images/car.png','images/bus.png', 'images/travelling.png', 'images/bycicle.png', 'images/food-delivery.png'];

  VisibleMarker lemarqueur = VisibleMarker();
  Utilisateur utilisateur = Utilisateur();

  // created empty list of markers
  // final List<Marker> _markers = <Marker>[];
  //Test de sa 
  late List<Marker> _markers = <Marker>[];
    
  SampleItem? menuSelectioner;

  late Position _currentPosition;//Suprime later

  @override
  void initState() {

    lemarqueur.marqueurbd ;
    utilisateur.user;
    _markers ;

    fetchMarkeur();
    
    // print(lemarqueur.marqueurbd.length);    

    super.initState();
  }

  void/*Future< List<Markeur>>*/ fetchMarkeur() async {
  final response = await http
      .get(Uri.parse( 'http://10.0.2.2:8000/api/?format=json' /*'http://192.168.1.165:8000/api/?format=json'*/ ));

  if (response.statusCode == 200) {
    print('fetch Ok');
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // return Markeur.fromJsonList(json.decode(response.body));
    final List<dynamic> data = jsonDecode(response.body);
    setState(() {
      print(data[3]['latiude']);
       _markers = data.map(
          (marker) => Marker(
            point: LatLng(marker['latitude'], marker['longitude']),
            builder: (ctx) =>Container(
              
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
                                title: Text(marker['latitude'].toStringAsFixed(4),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300),),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),

                              ListTile(
                                leading: Text("La longitude :",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300),),
                                title: Text(marker['longitude'].toStringAsFixed(4),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300),),
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),

                              ListTile(
                                leading: Text("Description :",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w300),),
                                title: Text(marker['description'],style: TextStyle(fontSize: 16,fontWeight: FontWeight.w300),maxLines: 3,),
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
                  icon : Icon(Icons.location_on)
                ),
              
            )
          ),
        ).toList();
    });
  } else {
    print('fetch kO');
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load album');
  }
}

Future saveMarker(double lat, double lng, String description) async {
  final url = Uri.parse('http://10.0.2.2:8000/api/');
  final response = await http.post(url,
    headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'}, 
    body: json.encode({
      "latitude": lat,
      "longitude": lng,
      "description": description,
    })
  );

  if (response.statusCode == 201 || response.statusCode == 200) {
    print('Marqueur enregistré avec succès ' + lat.toString() + " " + lng.toString() + " " + description);
  } else {
    throw Exception('Echec de l\'enregistrement du marqueur.' + lat.toString() + " " + lng.toString() + " " + description);
  }
}

// void logIn(String username ,String password ) async {
//   final url = Uri.parse('http://10.0.2.2:8000/api/users/login/');
//   final response = await http.post(url,
//     headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'}, 
//     body: json.encode({
//       "username": username,
//       "password": password
//     })
//   );

//   if (response.statusCode == 201) {
//     print('Authenthification reussie ' + username.toString() + " " + password.toString() + " " );
//   } else {
//     throw Exception('Echec de l\'authentification .');
//   }
// }



  // getDataAndCreateMarkerDetailsList() async {
  //   List data = await fetchMarkeur();
  //   for (Map i in data) {
  //     Markeur marker = Markeur(
  //       latitude: i['latitude'],
  //       longitude: i['longitude'],
  //       description: i['description'],
  //     );
  //     setState(() {
  //       lemarqueur.marqueurbd.add(marker);
  //     });
  //   }
  // }

  // getDataAndCreateMarkerDetailsList() async {
  //   ApiServices apiServices = ApiServices();
  //   var data = await apiServices.getData();
  //   for (Map i in data) {
  //     mk.Marker marker = mk.Marker(
  //       username: i['username'],
  //       latitude: i['latitude'],
  //       longitude: i['longitude'],
  //       categorie: i['categorie'],
  //       status: i['status'],
  //       titre: i['title'],
  //       description: i['description'],
  //       contact: i['contact'],
  //     );
  //     setState(() {
  //       markerDetailList.add(marker);
  //     });
  //   }
  // }

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
                          Inscription(/*txtnomUtilisateur: txtnomUtilisateur, txtMdp: txtMdp, clickValider: SaveInscription*/)
                          
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
                          Connexion(txtcnxnomUtilisateur: txtcnxnomUtilisateur, txtcnxMdp: txtcnxMdp ,/* onsave: logIn(txtcnxnomUtilisateur, txtcnxMdp.text),*/)

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

                    if (txtcnxnomUtilisateur.text != 'vianney' && txtcnxMdp.text != '1234' /**/  ) {
                      print( 'txtcnxnomUtilisateur.text valeur = '+ txtcnxnomUtilisateur.text +' et txtcnxMdp.text valeur est '+txtcnxMdp.text ),
                      showDialog(
                        context: context,
                        builder: (BuildContext context){
                            return AlertDialog(
                              title: Text("Information"),
                              content: Text("Si vous voulez ajouter des marqueur inscriver vous"),
                            );
                        }
                      )
                    } else {
                      setState(() {
                   //POPUP POUR DESCRIPTION     
                        showDialog(
                          context: context, 
                          builder: (context){
                            return AlertDialog(
                              contentPadding: EdgeInsets.fromLTRB(24,20,24,10),
                              title: Center(child: Text("Ajout de marqueur")),
                              backgroundColor: Colors.white,
                              content: StatefulBuilder(
                                builder: (context, setState) =>
                                Container(
                                  child: Column(
                                    children: [
                                      Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          hintText: 'Ajouter une description ',
                                        ),
                                        controller: txtdescription,
                                      ),
                                    ),

                                    ElevatedButton(
                                      child: Text("Valider"),
                                      onPressed: (){
                                        saveMarker(point.latitude, point.longitude, txtdescription.text);
                                      },
                                      
                                    )
                                    ],
                                  ),
                                )
                                
                              )
      
                            );
                          }
                        );
                       // 
                         
                      /*lemarqueur.marqueurbd.add*/ _markers.add(
                        
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

                      print('le nbre de marquer dans la methode ' + _markers.length.toString());
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
                  // MarkerLayerOptions(
                  //   markers: [
                  //       for (int i = 0; i < lemarqueur.marqueurbd.length; i++) lemarqueur.marqueurbd[i]
                  //     ],
                  // )
                  MarkerLayerOptions(
                    markers: [
                        for (int i = 0; i < _markers.length; i++) _markers[i]
                      ],
                  )
                ],

                // _markers
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

 
}