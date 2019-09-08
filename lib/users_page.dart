import 'package:flutter/material.dart';

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  bool _showProgress = false;

  bool _users = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title:new Center(
          child: new Text("Usuario", textAlign: TextAlign.center,style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ),
      body:SingleChildScrollView(
        child:  checkListUsers(),
      ),
    );
  }

  checkListUsers(){

    if (_users){
      return Padding(
        padding: EdgeInsets.all(30.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              logo(),
              SizedBox(height: 30.0),
              Text(
                "Seleccionar Usuario:",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28.0,
                  fontFamily: "Roboto",
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    //onTap: () => loginUser("user1"),
                    child: user1(),
                  ),
                  GestureDetector(
                    //onTap: () => loginUser("user2"),
                    child: user2(),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    //onTap: () => loginUser("user1"),
                    child: user1(),
                  ),
                  GestureDetector(
                    //onTap: () => loginUser("user2"),
                    child: user2(),
                  ),
                ],
              ),
              SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => _showDialog(),
                    child: noUsers(),
                  ),
                  
                ],
              ),
            ],
          ),
        ),
      );
    }
    else
    {
      return Padding(
        padding: EdgeInsets.all(30.0),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              logo(),
              SizedBox(height: 20.0),
              Text(
                "Seleccionar Usuario:",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28.0,
                  fontFamily: "Roboto",
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                ),
              ),
              SizedBox(height: 30.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  GestureDetector(
                    onTap: () => _showDialog(),
                    child: noUsers(),
                  ),
                  
                ],
              ),
            ],
          ),
        ),
      );
    }
    }

  Card noUsers(){
    return Card(
      child: Container(
        padding: EdgeInsets.all(25.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(Icons.person_add, color:Colors.black, size: 30.0,),
            SizedBox(height: 5.0),
            Text(
              'Agregar',
            ),
          ],
        ),
      ),
      elevation: 5.0,
      shape: CircleBorder(),
    );
  }  


  Card user1() {
    return Card(
      child: Container(
        padding: EdgeInsets.all(25.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            userImage('assets/users/angel_goitia.jpg'),
            SizedBox(height: 5.0),
            Text(
              'Angel Goitia',
            ),
          ],
        ),
      ),
      elevation: 5.0,
      shape: CircleBorder(),
    );
  }

  Card user2() {
    return Card(
      child: Container(
        child: Column(
          children: <Widget>[
            userImage('assets/users/elizabeth_guardia.jpg'),
            SizedBox(height: 5.0),
            Text(
              'Elizabeth Guardia',
            ),
          ],
        ),
        padding: EdgeInsets.all(25.0),
      ),
      elevation: 5.0,
      shape: CircleBorder(),
    );
  }

  Widget userImage(String imagePath) {
    return Image(
      image: AssetImage(imagePath),
      width: 60.0,
      height: 60.0,
    );
  }

  Widget logo() {
    return Image(
      image: AssetImage('assets/logo.png'),
      height: 100.0,
      width: 100.0,
    );
  }

  Widget showProgress() {
    if(_showProgress){
      return CircularProgressIndicator(backgroundColor: Colors.white);
    }else{
      return SizedBox(height: 35.0);
    }
  }

  void _showDialog() {
    String nameUsers = '';
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Text('Nuevo Usuario'),
          content: new Row(
            children: <Widget>[
              new Expanded(
                  child: new TextField(
                autofocus: true,
                decoration: new InputDecoration(
                    labelText: 'Nombre y Apellido', hintText: 'Juan Pablo Bonet'),
                onChanged: (value) {
                  nameUsers = value;
                },
              ))
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Guardar'),
              onPressed: () {
                Navigator.of(context).pop(nameUsers);
              },
            ),
            FlatButton(
              child: Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  
}