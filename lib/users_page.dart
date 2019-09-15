import 'package:flutter/material.dart';
import 'package:lenguaje_de_senas_app/Model/user.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dataBase.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';


Future<List<User>> getUsers() async{
  var dbLenguajeSenas = DBLenguajeSenas();
  Future<List<User>> users = dbLenguajeSenas.getUsers();
  return users;
}

class UsersPage extends StatefulWidget {
  @override
  _UsersPageState createState() => _UsersPageState();
}


class _UsersPageState extends State<UsersPage> {
  final _formKey = new GlobalKey<FormState>();

  String nameUser;

  //status Botton flotante
  bool _statusBotton = false;

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
        child:  Padding(
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
                SizedBox(height: 15.0),
                FutureBuilder(
                  future: getUsers(),
                  builder: (context, snapshot){
                    if(!(snapshot.data == null || snapshot.data.isEmpty))
                    {
                        _statusBotton = true;

                      return SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: snapshot.data.map<Widget>((user)=>drawUser(user)).toList()
                          )
                      );
                    }
                    else
                    {
                      _statusBotton = false;
                      return Row();
                    }
                  },
                ),
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
        )
      ),
        floatingActionButton: new Visibility(
          visible: _statusBotton,
          child: new FloatingActionButton(
            onPressed: (){},
            tooltip: 'Evento ',
            child: new Icon(Icons.settings,color: Colors.white,),
          ),
        ),
    );
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


  Widget drawUser(User user) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(25.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            //userImage('${user.urlImageUser}'),
            userImage(user.nameUser),
            SizedBox(height: 5.0),
            Text(
              '${user.nameUser}',
            ),
          ],
        ),
      ),
      elevation: 5.0,
      shape: CircleBorder(),
    );
  }


  Widget userImage(String nameUser) {
    nameUser = nameUser.toLowerCase();
    String firstCharacter = nameUser.substring(0, 1);
    String url = 'assets/users/' + firstCharacter +'.png';

    return Image(
      image: AssetImage(url),
      width: 80.0,
      height: 80.0,
    );
  }

  Widget logo() {
    return Image(
      image: AssetImage('assets/logo.png'),
      height: 100.0,
      width: 100.0,
    );
  }

  void _showDialog(){
    var width = MediaQuery.of(context).size.width;

    Alert(

        context: context,
        title: "Nuevo Usuario",
        content: Column(
          children: <Widget>[
            Form(
              key: _formKey,
              child:TextFormField(
                inputFormatters: [
                  WhitelistingTextInputFormatter(RegExp("[a-zA-Z\ áéíóúÁÉÍÓÚñÑ\s]")),
                  BlacklistingTextInputFormatter(RegExp("[/\\\\]")),
                ], 
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  icon: Icon(Icons.account_circle),
                  labelText: 'Nombre ',
                ),
                validator:(value) => value.isEmpty ? 'Ingrese tu nombre.':value.length <2 ? 'El nombre es muy corto' :null,
                
                onSaved: (val) => this.nameUser = val,
              ),
            )
            
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: (){
              if(_formKey.currentState.validate()){
                _formKey.currentState.save();
                Navigator.of(context).pop();

                nameUser =  nameUser.toLowerCase();
                String firstCharacter = nameUser.substring(0, 1);
                String afterFirstCharacter= nameUser.substring(1, nameUser.length);

                nameUser = firstCharacter.toUpperCase() + afterFirstCharacter;

                var user = User();
                user.nameUser = nameUser;

                var dbLenguajeSenas = DBLenguajeSenas();
                dbLenguajeSenas.addNewUser(user);
                Toast.show("Usuario guardado", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER,
                    textColor: Colors.white, backgroundColor: Colors.blue);

                setState(() {
                  _statusBotton = true;
                });
              }

            }, 
            child: Text(
              "GUARDAR",
              style: TextStyle(color: Colors.white, fontSize: width/28),
            ),
            color: Colors.blue,
          ),
          DialogButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              "CERRAR",
              style: TextStyle(color: Colors.white, fontSize: width/28),
            ),
            color: Colors.red,
          ),
        ]).show();
  }


}