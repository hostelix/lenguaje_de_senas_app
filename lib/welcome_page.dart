import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  static String tag = 'welcome-page';
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {

    final logo = Hero(
      tag: 'tag',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo.png'),
      ),
    );

    final welcome = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Bienvenido al Aprendizaje de Lenguaje de Señas',
        textAlign: TextAlign.center,
        style: TextStyle(fontSize:28.0, color: Colors.white),
      ),
    );


    final descripcion = Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Es una aplicación para aprendizaje de lenguaje de señas especialmente para niños, niñas y adolecentes.',
        textAlign: TextAlign.justify,
        style: TextStyle(fontSize:18.0, color: Colors.white),
      ),
    );

    final labelName = Padding(
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
        
    );


    final enterButton = Padding(
      padding: EdgeInsets.all(8.0),
      child: SizedBox(
        width: 200,
        child:  RaisedButton(
        textColor: Colors.white,
        color: Colors.lightBlueAccent,
        splashColor: Colors.blueAccent,
        child: Text("Entrar"),
        onPressed: () {
          Navigator.pushNamed(context, "/users");
        },
        shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0),
        ),
      ),
      ),

      
    );


    final body = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(28.0),
      decoration: BoxDecoration(
        gradient: LinearGradient(colors:[
          Colors.blue,
          Colors.lightBlueAccent,
        ])
      ),
      child: Column(children: <Widget>[
        SizedBox(height: 68.0),
        logo,
        SizedBox(height: 38.0),
        welcome,
        SizedBox(height: 18.0),
        descripcion,
        SizedBox(height: 78.0),
        labelName,
        formName,
        SizedBox(height: 10.0),
        enterButton
      ],),
    );

    return Scaffold(
      body: body,
    );
  }
}