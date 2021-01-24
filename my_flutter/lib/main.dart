import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;
import 'secondRoute.dart';

void main() => runApp(_widgetForRoute(ui.window.defaultRouteName));

Widget _widgetForRoute(String route) {
  print("route::::$route");

  switch (route) {
    case '/':
      return MyApp();

    default:
      return Center(
        child: Text('Unknown route: $route', textDirection: TextDirection.ltr),
      );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => MyHomePage(
              title: "KKKK",
            ),
        '/SecondRoute': (context) => SecondRoute(
              title: "FFF",
            ),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  static const methodChannel = const MethodChannel('cxl');

  void _incrementCounter() {
    setState(() {
      _counter++;
      if (_counter == 1) {
        toNativePush();
      }

      if (_counter == 2) {
        toNativePop();
      }

      if (_counter == 3) {
        _toNativeSomethingAndGetInfo();
      }
    });
  }

  Future<Null> toNativePush() async {
    dynamic result;
    try {
      Map<String, String> map = {
        "title": "This is the second parameter from flutter"
      };
      result = await methodChannel.invokeMethod('toNativePush', map);
    } on PlatformException {
      result = 66;
    }
    setState(() {
      // Type judgment
      if (result is int) {
        _counter = result;
      }
    });
  }

  Future<Null> toNativePop() async {
    dynamic result;
    try {
      Map<String, String> map = {"title": "This is a parameter from flutter"};
      result = await methodChannel.invokeMethod('toNativePop', map);
    } on PlatformException {
      result = 888;
    }
    setState(() {
      // Type judgment
      if (result is int) {
        _counter = result;
      }
    });
  }

  Future<Null> _toNativeSomethingAndGetInfo() async {
    dynamic result;
    try {
      result = await methodChannel.invokeMethod(
          'toNativeSomething', 'You clicked $_counter times');
    } on PlatformException {
      result = 888;
    }
    setState(() {
      // Type judgment
      if (result is int) {
        _counter = result;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
