import 'package:flutter/material.dart';
// import 'package:mobile_radar_marqueur/Ecrans/Ajoutermarqueur.dart';
import 'package:mobile_radar_marqueur/map_view.dart';
import 'package:provider/provider.dart';

import 'api.dart/api.dart';

import 'package:http/http.dart' as http;
import 'package:mobile_radar_marqueur/modele/markeur.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MarkeurProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
    
          primarySwatch: Colors.blue,
        ),
        home: const /*HomePage( )*/ MapviewTest(),
      ),
    );
  }
}




// class HomePage extends StatefulWidget {
//   const HomePage({ Key? key }) : super(key: key);

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {

//   late final List<Markeur> dataMarker;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // futureMarker = fetchMarkeur();
    
//     print('init');
//     fetchMarkeur();
//     print('Methode terminer');
//   }

//   Future< List<Markeur>> fetchMarkeur() async {
//   final response = await http
//       .get(Uri.parse('http://10.0.2.2:8000/apis/v1/?format=json'));

//   if (response.statusCode == 200) {
//     print('Ok');
//     // If the server did return a 200 OK response,
//     // then parse the JSON.
//     return Markeur.fromJsonList(json.decode(response.body));
    
//   } else {
//     // If the server did not return a 200 OK response,
//     // then throw an exception.
//     throw Exception('Failed to load album');
//   }
// }


//   @override
//   Widget build(BuildContext context) {

//     final marquerP = Provider.of<MarkeurProvider>(context);

//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             onPressed: initState, 
//             icon: Icon(Icons.replay_outlined)
//           ),
//         ],
//       ),

//       body: Center(
//         child: FutureBuilder<List<Markeur>>(
//           future: fetchMarkeur(),
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {

//               // var markeurData = snapshot.data!;
//               return ListView.builder(
//                 itemCount:  snapshot.data!.length/*marqueur*/,
//                 itemBuilder: (context, index){

//                   return ListTile(
//                       title: Text(snapshot.data![index].description.toString()),
//                       subtitle: Text('La latitude est de ' + snapshot.data![index].latitude.toString()),
//                       trailing: Text('La longitude est de ' + snapshot.data![index].longitude.toString()),
//                       // leading: Text(DateTime.tryParse(snapshot.data!.datecreation.toString()).toString()),
//                       );
//                 }
//               );
            
//             } else if (snapshot.hasError){
//               return Text('${snapshot.error}');
//             }

//             return const CircularProgressIndicator();

//           }
//         )

//       ),

//       floatingActionButton: FloatingActionButton(
//           child: Icon(
//             Icons.add,
//             size: 30,
//           ),
//           onPressed: () {
//             Navigator.of(context)
//                 .push(MaterialPageRoute(builder: (ctx) => AddMarqueurScreen()));
//           }
//       ),
       
//     );
//   }
// }

