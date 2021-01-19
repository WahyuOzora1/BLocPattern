import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'color_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ColorBLoc bloc = ColorBLoc();

  @override
  void dispose() {
    bloc.dispose;
    super.dispose();
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              backgroundColor: Colors.amber,
              onPressed: () {
                bloc.eventSink
                    .add(ColorEvent.to_amber); //menghubungkan ke eventSink
              },
            ),
            SizedBox(
              width: 10,
            ),
            FloatingActionButton(
              onPressed: () {
                bloc.eventSink.add(ColorEvent.to_light_blue);
              },
              backgroundColor: Colors.lightBlue,
            )
          ],
        ),
        appBar: AppBar(
          title: Text("BLoC tanpa library"),
        ),
        body: Center(
          child: StreamBuilder(
              stream: bloc.stateStream,
              initialData: Colors.amber,
              builder: (context, snapshot) {
                return AnimatedContainer(
                  duration: Duration(microseconds: 500),
                  width: 100,
                  height: 100,
                  color: snapshot.data,
                );
              }), //memblok widget setiap kali mendapatkan update dari stream
        ),
      ),
    );
  }
}
