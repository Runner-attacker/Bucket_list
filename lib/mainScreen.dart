import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  List<dynamic> bucketListData = [];
  bool isLoading = false;
  Future<void> getData() async {
    setState(() {
      isLoading = true;
    });
    //get data from the API
    try {
      Response response = await Dio().get(
          "https://flutterapitest123-d1627-default-rtdb.firebaseio.com/bucketlist.json");

      bucketListData = response.data;
      isLoading = false;
      setState(() {});
    } catch (e) {
      isLoading = false;
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Bucket List"),
        actions: [
          InkWell(
              onTap: getData,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.refresh_rounded),
              ))
        ],
      ),
      body: Expanded(
          child: RefreshIndicator(
        onRefresh: getData,
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: bucketListData.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title: Text(bucketListData[index]["item"] ?? ""),
                      leading: CircleAvatar(
                        backgroundImage:
                            NetworkImage(bucketListData[index]["image"] ?? ""),
                      ),
                      trailing:
                          Text(bucketListData[index]["cost"].toString() ?? ""),
                    ),
                  );
                },
              ),
      )),
    );
  }
}
