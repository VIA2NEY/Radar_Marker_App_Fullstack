import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';


class Localisation {
  
  double? latitudeAppareil ;
  double? longitudeAppareil ;

  Future <void> avoirPosition() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.medium);

      latitudeAppareil = position.latitude;
      longitudeAppareil = position.longitude;

      print("Try excecute valeur " 'latitudeAppareil'+ position.latitude.toString() + ' longitudeAppareil'+ position.longitude.toString());

    } catch (e) {
      print(e);
    }

    void markerCreate() {

      final markerr = Marker(
        point: LatLng(latitudeAppareil!, longitudeAppareil!), 
        builder: (ctx) => InkWell(
          child: Container(
            child: Column(
              children: const [
                //Je voulais mettre un containner en haut pour display quan on clik sur lui
                Icon(
                  Icons.fiber_manual_record,
                  color: Colors.blue,
                ),
              ],
            ),
          ),
        )
      );
    }
    
  }
  
}