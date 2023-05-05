import 'package:flutter/material.dart';
import 'package:tarea_4/constanst.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List _jsonData = [];

  // Load jsonData variable with the data from the json file using the readJson function
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/crypto_exchange.json');
    final data = await json.decode(response);

    setState(() {
      _jsonData = data;
    });
  }

  // Call the readJson function when the widget is created
  @override
  void initState() {
    super.initState();
    readJson();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(itemBuilder: (BuildContext context, int index) {
      return ListTile(
        leading: CircleAvatar(
          child: Image.network(_jsonData[index]['image']),
        ),
        title: Text(_jsonData[index]['name']),
        subtitle: Text(_jsonData[index]['country']),
        trailing: CircleAvatar(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          child: Text(_jsonData[index]['trust_score'].toString()),
        )
      );
    }, separatorBuilder: (BuildContext context, int index) => const Divider(), itemCount: _jsonData.length);
  }
}
