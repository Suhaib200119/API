import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  getData() async{
    var result=await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    if(result.statusCode==200){
      var object=json.decode(result.body);
      return object;
    }
  }
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("API"),
      ),
      body: Center(
          child: FutureBuilder(
            future: getData(),
            builder: (ctx,snapshot){
              if(snapshot.connectionState==ConnectionState.waiting){
                return CircularProgressIndicator();
              }else{
                return ListView.builder(
                    itemCount: 10,
                    itemBuilder: (ctx2,index){
                      return Card(
                        child: Container(
                          child: Column(
                            children: [
                              Text((snapshot.data as List)[index]["title"]),
                              Image.network((snapshot.data as List)[index]["thumbnailUrl"]),
                            ],
                          ),
                        ),
                      );
                    });
              }

            },
          ),
      ),

    );
  }
}
