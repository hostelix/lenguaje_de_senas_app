import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {

    var isPortrait = MediaQuery.of(context).orientation;


    return Scaffold(
      body: isPortrait == Orientation.portrait ? gridviewVertical() : gridviewHorizontal(),
    );
  }

  gridviewVertical(){
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        mainAxisSpacing: 20.0,
        children: List.generate(6, (index){
          return Card(
            child: Container(
              alignment: Alignment.center,
              color: Colors.blue [100 * (index % 9)],
              child: Text('$index'),
            ),
          );
        })
      )
    );
  }

  gridviewHorizontal(){
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: GridView.count(
        crossAxisCount: 4,
        childAspectRatio: 1.0,
        mainAxisSpacing: 4.0,
        children: List.generate(6, (index){
          return Card(
            child: Container(
              alignment: Alignment.center,
              color: Colors.blue [100 * (index % 9)],
              child: Text('$index'),
            ),
          );
        })
      )
    );
  }




}