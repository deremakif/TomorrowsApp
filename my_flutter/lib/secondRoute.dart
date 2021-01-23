import 'package:flutter/material.dart';
import 'dart:ui' as ui;

void main() => runApp(_widgetForRoute(ui.window.defaultRouteName));

Widget _widgetForRoute(String route) {
  print("route::::$route");

  switch (route) {
    case '/':
      return MySecondApp();

    default:
      return MySecondApp();
  }
}

class MySecondApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Second Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SecondRoute(title: 'Flutter Demo Second Page'),
    );
  }
}

class SecondRoute extends StatefulWidget {
  SecondRoute({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SecondRouteState createState() => _SecondRouteState();
}

class _SecondRouteState extends State<SecondRoute> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title ?? "HHH"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
