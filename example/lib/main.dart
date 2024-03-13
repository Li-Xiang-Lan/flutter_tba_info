import 'package:flutter/material.dart';
import 'package:flutter_tba_info/flutter_tba_info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String dis="";

  @override
  void initState() {
    super.initState();
    _request();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Running on: $dis'),
              SizedBox(height: 20,),
              InkWell(
                onTap: ()async{
                  var map = await FlutterTbaInfo.instance.getReferrerMap();
                  print(map);
                },
                child: const Text('getReferrerMap'),
              ),
              SizedBox(height: 20,),
              InkWell(
                onTap: ()async{
                  print(await FlutterTbaInfo.instance.getBuild());
                },
                child: const Text('getBuild'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _request()async{
    dis=await FlutterTbaInfo.instance.getDistinctId();
    setState(() {

    });
  }
}
