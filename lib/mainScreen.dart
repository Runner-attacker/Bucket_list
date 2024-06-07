import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  Future<void> getData() async {
    //get data from the API
    var response = await Dio().get(
        "https://flutterapitest123-d1627-default-rtdb.firebaseio.com/bucketlist.json");
    print(response);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Bucket List"),
      ),
      body: ElevatedButton(onPressed: getData, child: Text("Get Data")),
    );
  }
}
