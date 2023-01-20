import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';

class Markeur {


  final int markerId;
  final InfoModel infoWindow;
  final LatLng position ;
  final Icon icon ;

  /// Bounding box width of the marker
  final double width;
  /// Bounding box height of the marker
  final double height;
  final WidgetBuilder builder;
  

  Markeur(
    {
      required this.markerId,
      required this.position,
      required this.infoWindow,
      required this.icon,

      required this.builder,
      this.width = 30.0,
      this.height = 30.0,
    }
  );

  // factory StatusModel.fromjson(Map<String, dynamic>json){
  //   return StatusModel( 
  //     json["timestamp"],
  //     json["error_code"],
  //     json["error_message"] == null ? "" : json["error_message"],
  //     json["elapsed"],
  //     json["credit_count"],
  //     json["notice"] == null ? "" : json["notice"],
  //     json["total_count"],
  //   );
  // }

}

class InfoModel {

  final String titre ;
  final String Nomposition;

  InfoModel(

    this.titre,
    this.Nomposition

  );  

}

class VisibleMarker {
  
  List marqueurbd = [];

}

class Utilisateur {
  List user = [];
}