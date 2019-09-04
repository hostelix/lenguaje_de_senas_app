import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Lenguaje de Señas',
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text('Lenguaje de Señas')
          ),
        ),
        body: Center(
          child: Text('Hola Mundo')
        ),
      ),
    );
  }

}
