import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primarySwatch: Colors.cyan,
//       ),
//       debugShowCheckedModeBanner: false,
//       home: const Testee(),
//     );
//   }
// }

class TransactionDetails {
  String? avatar;
  String? name;
  String? date;
  String? amount;

  TransactionDetails({
    this.avatar,
    this.name,
    this.date,
    this.amount,
  });

  TransactionDetails.fromJson(Map<String, dynamic> json) {
    avatar = json['avatar'];
    name = json['name'];
    date = json['date'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avatar'] = avatar;
    data['name'] = name;
    data['date'] = date;
    data['amount'] = amount;
    return data;
  }
}

Future<List<TransactionDetails>> fetchAlbum() async {
  final response = await http.get(Uri.parse(
      'https://brotherlike-navies.000webhostapp.com/people/people.php'));

  if (response.statusCode == 200) {
     print('OK TESTT');
    final List result = json.decode(response.body);
    return result.map((e) => TransactionDetails.fromJson(e)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}

class Testee extends StatefulWidget {
  const Testee({Key? key}) : super(key: key);

  @override
  State<Testee> createState() => _TesteeState();
}

class _TesteeState extends State<Testee> {

  @override
  void initState() {
    // TODO: implement initState
    fetchAlbum();
    print('Init test ');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor : Colors.black,
      body : Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          height: 150,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              Container(
                margin: const EdgeInsets.all(15),
                width: 319,
                height: 100,
                color: Colors.green,
                alignment: Alignment.center,
                child: const Text(
                  '\$5200.00',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(15),
                width: 319,
                height: 100,
                color: Colors.green,
                alignment: Alignment.center,
                child: const Text(
                  '\$1200.00',
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(15),
          child: Text(
            "Recent Transactions",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.green),
          ),
        ),
        Center(
          child: FutureBuilder<List<TransactionDetails>>(
            future: fetchAlbum(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: CircleAvatar(
                        child: Image.network(
                            snapshot.data![index].avatar.toString()),
                      ),
                      title: Text(snapshot.data![index].name.toString()),
                      trailing:
                          Text(snapshot.data![index].amount.toString()),
                      subtitle: Text(snapshot.data![index].date.toString()),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              } 
              return const CircularProgressIndicator();
            },
          ),
        ),
      ],
    ),


    );
  }
}
