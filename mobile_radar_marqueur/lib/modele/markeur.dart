class Markeur {

  late  int ? id;//Je peut le mettre en nullable pour pouvoir enlever le rquired
  final double ? latitude ;
  final double ? longitude ;
  final String ? description ;
  final DateTime ? datecreation ;
  

  Markeur(
    {
       this.id,
       this.latitude,
       this.longitude,
       this.description,
       this.datecreation
    }
  );

  factory Markeur.fromJson(Map<String, dynamic> json) {
    return Markeur(
      id: json['id'], 
      latitude: json['latitude'], 
      longitude: json['longitude'], 
      description: json['description'], 
      datecreation: DateTime.tryParse(json['datecreation'])!
    );
  }
  // dynamic toJson() => {
    
  //   'id': id, 
  //   'latitude': latitude, 
  //   'longitude' : longitude,  
  //   'description': description,
  //   'datecreation' : datecreation


  // };

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['description'] = description;
    data['datecreation'] = datecreation;
    
    return data;
  }

  static List<Markeur> fromJsonList(dynamic jsonList) {
    final markeurDetailsList = <Markeur>[];
    if (jsonList == null) return markeurDetailsList;

    if (jsonList is List<dynamic>) {
      for (final json in jsonList) {
        markeurDetailsList.add(
          Markeur.fromJson(json),
        );
      }
    }

    return markeurDetailsList;
  }


}