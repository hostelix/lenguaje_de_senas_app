import 'package:flutter/material.dart';
import 'dataBase.dart';
import 'package:lenguaje_de_senas_app/Model/category.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';


Future<List<Category>> getCategorys() async{
  var dbLenguajeSenas = DBLenguajeSenas();
  Future<List<Category>> categorys = dbLenguajeSenas.getCategorys();
  return categorys;
}


class MainPage extends StatefulWidget {
  MainPage(this.idUserLogin, this.nameUserLogin);
  final int idUserLogin;
  final String nameUserLogin;

  @override
  _MainPageState createState() => _MainPageState(idUserLogin, nameUserLogin);
}

class _MainPageState extends State<MainPage> {
  _MainPageState(this.idUserLogin, this.nameUserLogin);
  final int idUserLogin;
  final String nameUserLogin;

  @override
  void initState() {
    super.initState();

    verifyCategory();
  }

  void verifyCategory() async{
    final val = await getCategorys();
    if (val.length == 0) {
      print('entro');
      var dbLenguajeSenas = DBLenguajeSenas();
      dbLenguajeSenas.addCategory();

      setState(() {
        getCategorys();
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: <Widget>[
          ClipPath(
            clipper: ArcClipper(20.0),
            child: Container(
              color: Colors.blue,
              height: 200.0,
              padding: EdgeInsets.only(bottom: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top:50),
                      )
                    ],
                  ),
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
                        padding: EdgeInsets.all(20.0),
                        child: new LinearPercentIndicator(
                          width: MediaQuery.of(context).size.width - 100,
                          lineHeight: 14.0,
                          percent: 0.5,
                          center: Text(
                            "50%",
                            style: new TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold),
                          ),
                          trailing: Icon(Icons.grade, color: Colors.yellow,),
                          linearStrokeCap: LinearStrokeCap.roundAll,
                          backgroundColor: Colors.white,
                          progressColor: Colors.orange[300],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 170),
            child: FutureBuilder<List<Category>>(
              future: getCategorys(),
              builder: (context, snapshot){
                if ((snapshot.data != null) && (snapshot.hasData))
                  {
                    return ListView.builder(
                        itemExtent: 160.0,
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index){
                        return Card(
                          elevation: 5,
                          color: Colors.orange,
                          child: Container(
                            height: 50.0,
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.all(5.0),
                                  child: Container(
                                    height: 100.0,
                                    width: 100.0,
                                    decoration: BoxDecoration(
                                      //borderRadius: BorderRadius.all(Radius.circular(5)),
                                        image: DecorationImage(
                                          image: new AssetImage(snapshot.data[index].urlCategory),
                                        )
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 100,
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(20, 5, 0, 0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.only(left: 5),
                                          child: Text(snapshot.data[index].nameCategory, style: TextStyle(fontSize: 18, fontFamily: 'RobotoMono', color: Colors.white, fontWeight: FontWeight.bold)),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(0, 30, 0, 3),
                                          child: Container(
                                            child: new LinearPercentIndicator(
                                              width: width-160,
                                              lineHeight: 14.0,
                                              percent: 0.5,// 0.5 = 50%
                                              center: Text(
                                                "50%",
                                                style: new TextStyle(fontSize: 12.0,fontWeight: FontWeight.bold),
                                              ),
                                              linearStrokeCap: LinearStrokeCap.roundAll,
                                              backgroundColor: Colors.white,
                                              progressColor: Colors.blue[300],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                  }
                    return new Container(
                      alignment: AlignmentDirectional.center,
                      child: new CircularProgressIndicator(),
                    );
              },
            ),
          ),
        ],
      ),
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