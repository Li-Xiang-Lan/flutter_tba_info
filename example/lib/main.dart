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
  String distinctId="";

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
              Text('distinctId:$distinctId'),
            ],
          )
        ),
      ),
    );
  }

  _request()async{
    distinctId = await FlutterTbaInfo.instance.getDistinctId();
    setState(() {});
  }
}
