import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {

    var isPortrait = MediaQuery.of(context).orientation;


    return Scaffold(
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: ArcClipper(50.0),
            child: Container(
              color: Colors.orange,
              height: 200.0,
              padding: EdgeInsets.only(bottom: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                       Text(
                          'Logro de Aprendizaje',
                          style: TextStyle(
                            fontSize: MediaQuery.of(context).size.width / 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,

                          )
                        ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: new LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width - 100,
                          lineHeight: 14.0,
                          percent: 0.5,
                          center: Text(
                            "50.0%",
                            style: new TextStyle(fontSize: 12.0),
                          ),
                          trailing: Icon(Icons.grade, color: Colors.yellow,),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          backgroundColor: Colors.white,
                          progressColor: Colors.lightBlue,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          isPortrait == Orientation.portrait ? gridviewVertical() : gridviewHorizontal(),
        ],
      ),
    );

  }

  gridviewVertical(){
    return Padding(
      padding: EdgeInsets.only(top: 150.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 1.0,
        mainAxisSpacing: 5.0,
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
      padding: EdgeInsets.only(top:150.0),
      child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1.0,
        mainAxisSpacing: 10.0,
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

class ArcClipper extends CustomClipper<Path> {
  ArcClipper(this.height);

  ///The height of the arc
  final double height;

  @override
  Path getClip(Size size) => _getBottomPath(size);

  Path _getBottomPath(Size size) {
    return Path()
      ..lineTo(0.0, size.height - height)
      //Adds a quadratic bezier segment that curves from the current point
      //to the given point (x2,y2), using the control point (x1,y1).
      ..quadraticBezierTo(
          size.width / 4, size.height, size.width / 2, size.height)
      ..quadraticBezierTo(
          size.width * 3 / 4, size.height, size.width, size.height - height)
      ..lineTo(size.width, 0.0)
      ..close();
  }

  @override
  bool shouldReclip(ArcClipper oldClipper) => height != oldClipper.height;
}