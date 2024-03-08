import 'package:flutter/material.dart';
import 'package:flutter_tba_info/flutter_tba_info.dart';
import 'package:flutter_tba_info/referrer_observer.dart';

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
                onTap: (){
                  FlutterTbaInfo.instance.addReferrerObserver(_observer);
                },
                child: const Text('add ReferrerObserver'),
              ),
              SizedBox(height: 20,),
              InkWell(
                onTap: (){
                  FlutterTbaInfo.instance.connectReferrer();
                },
                child: const Text('connectReferrer'),
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

  final ReferrerObserver _observer=ReferrerObserver(
    onSuccess: (map){
      print(map);
    },
    onError: (){

    }
  );

  _request()async{
    dis=await FlutterTbaInfo.instance.getDistinctId();
    setState(() {

    });
  }
}
