import 'package:flutter/material.dart';
import 'users_page.dart';


class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _layoutDetails()
    );
  }


  Widget _layoutDetails(){
    Orientation orientation = MediaQuery.of(context).orientation;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    if(orientation == Orientation.portrait){
      final logo = Padding(
        padding: EdgeInsets.all(18.0),
        child: Hero(
          tag: 'tag',
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 48.0,
            child: Image.asset(
              'assets/logo.png',
              width: width-250,
              height: height-250,
              ),
          ),
        )
      );

      final welcome = Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Bienvenido al Aprendizaje de Lenguaje de Señas ',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: width/15, color: Colors.white),
        ),
      );


      final descripcion = Padding(
        padding: EdgeInsets.all(18.0),
        child: Text(
          'Es una aplicación para el aprendizaje de lenguaje de señas especialmente para niños, niñas y adolecentes.',
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize:width/20 , color: Colors.white),
        ),
      );

  /*     final labelName = Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Por Favor Ingrese tu Nombre y Apellido:',
          style: TextStyle(fontSize:16.0, color: Colors.white),
        ),
      );

      final formName = TextFormField(
        keyboardType: TextInputType.text,
        autofocus: false,
        initialValue: '',
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: 'Nombre y Apellido',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Colors.white)
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 5.0),
          ),
        ),
          
      ); */


      final enterButton = Padding(
        padding: EdgeInsets.all(18.0),
        child: SizedBox(
          width: 250.0,
          child:  RaisedButton(
            textColor: Colors.white,
            color: Colors.orange,
            child: Text(
              "Siguiente",
              style: new TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => UsersPage()));
            },
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
          ),
        ),      
      );

      final body = Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(28.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors:[
            Colors.blue,
            Colors.lightBlueAccent,
          ])
        ),
        child: Column(children: <Widget>[
          logo,
          welcome,
          SizedBox(height: 10.0),
          descripcion,
  /*         labelName,
          formName, 
          SizedBox(height: MediaQuery.of(context).size.height/50),*/
          SizedBox(height: 10.0),
          enterButton
        ],),
      );

      return Scaffold(
        body: body,
      );
    }
    else
    {
      final logo = Padding(
        padding: EdgeInsets.all(2.0),
        child: Hero(
          tag: 'tag',
          child: CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 48.0,
            child: Image.asset(
              'assets/logo.png',
              width: width-250,
              height: height-250,
              ),
          ),
        )
      );

      final welcome = Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Bienvenido al Aprendizaje de Lenguaje de Señas',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: width/25, color: Colors.white),
        ),
      );


      final descripcion = Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Es una aplicación para el aprendizaje de lenguaje de señas especialmente para niños, niñas y adolecentes.',
          textAlign: TextAlign.justify,
          style: TextStyle(fontSize:width/35 , color: Colors.white),
        ),
      );

  /*     final labelName = Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Por Favor Ingrese tu Nombre y Apellido:',
          style: TextStyle(fontSize:16.0, color: Colors.white),
        ),
      );

      final formName = TextFormField(
        keyboardType: TextInputType.text,
        autofocus: false,
        initialValue: '',
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          hintText: 'Nombre y Apellido',
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(5.0)),
            borderSide: BorderSide(color: Colors.white)
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 5.0),
          ),
        ),
          
      ); */


      final enterButton = Padding(
        padding: EdgeInsets.all(8.0),
        child: SizedBox(
          width: 250.0,
          child:  RaisedButton(
            textColor: Colors.white,
            color: Colors.orange,
            child: Text(
              "Siguiente",
              style: new TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            onPressed: () {
              Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => UsersPage()));
            },
            shape: new RoundedRectangleBorder(
              borderRadius: new BorderRadius.circular(30.0),
            ),
          ),
        ),

        
      );


      final body = Container(
        width: width,
        height: height,
        padding: EdgeInsets.all(28.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(colors:[
            Colors.blue,
            Colors.lightBlueAccent,
          ])
        ),
        child: Column(children: <Widget>[
          logo,
          welcome,
          descripcion,
  /*         labelName,
          formName, 
          SizedBox(height: MediaQuery.of(context).size.height/50),*/
          enterButton
        ],),
      );

      return Scaffold(
        body: body,
      );
    }
  }
}