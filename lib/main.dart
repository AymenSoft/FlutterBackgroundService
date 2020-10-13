import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Flutter Background Service",
      home: Scaffold(
        appBar: AppBar(
          title: Text("Flutter Background Service"),
        ),
        body: Builder(
          builder:(context) => Center(
            child: Wrap(
              direction: Axis.vertical,
              alignment: WrapAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  onPressed: (){
                    controlServiceInPlatform(context, "startService");
                  },
                  child: Text("Start Service"),
                ),
                RaisedButton(
                  onPressed: (){
                    controlServiceInPlatform(context, "stopService");
                  },
                  child: Text("Stop Service"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void controlServiceInPlatform(BuildContext context, String action) async {
    if(Platform.isAndroid){
      var methodChannel = MethodChannel("com.aymensoft.messages");
      String data = await methodChannel.invokeMethod(action);
      debugPrint(data);
      showSnakeBar(context, data);
    }
  }

  void showSnakeBar(BuildContext context, String data){
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(data == "start_success" ? "success start" : "success stop"),
      action: SnackBarAction(
        label: "DONE",
        onPressed: (){
          Scaffold.of(context).hideCurrentSnackBar();
        },
      ),
    ));
  }

}
