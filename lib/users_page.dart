import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lenguaje_de_senas_app/Model/user.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'dataBase.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

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


  File image;

  Future getImage() async{
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    print(picture);
    setState(() {
     image = picture; 
    });
  }

  Future getGallery() async{
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    print(picture);
    setState(() {
     image = picture; 
    });
  }

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
                    if(snapshot.data == null || snapshot.data.isEmpty)
                    {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () => _showDialogNew(),
                            child: noUsers(),
                          ),
                        ],
                      );
                    }
                    else
                    {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: snapshot.data.map<Widget>((user)=>drawUser(user)).toList()

                      );
                    }
                  },
                )
              ],
            ),
          ),
        )
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
            userImage('${user.urlImageUser}'),
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


  Widget userImage(String imagePath) {
    return Image(
      image: AssetImage(imagePath),
      width: 100.0,
      height: 100.0,
    );
  }

  Widget logo() {
    return Image(
      image: AssetImage('assets/logo.png'),
      height: 100.0,
      width: 100.0,
    );
  }

  void _showDialogNew(){
    var width = MediaQuery.of(context).size.width;
    String nameUser = '';

    Alert(

        context: context,
        title: "Nuevo Usuario",
        content: Column(
          children: <Widget>[
            noImage(),
            Form(
              key: _formKey,
              child:TextFormField(
                inputFormatters: [
                  WhitelistingTextInputFormatter(RegExp("[a-zA-Z]"))
                ],
                textInputAction: TextInputAction.done,
                decoration: InputDecoration(
                  icon: Icon(Icons.account_circle),
                  labelText: 'Nombre y Apellido',
                ),
                validator:(value) => value.isEmpty ? 'Ingrese tu nombre y apellido.':null
              ),
            )
            
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: (){
              setState(() {
                if(_formKey.currentState.validate()){
                  Navigator.of(context).pop(nameUser);
                } 
              });
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

  Card noImage(){
    return Card(
      child: GestureDetector(
        onTap: () => showDialogPicture(),
        child: Container(
          padding: EdgeInsets.all(25.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              image == null? drawIconAdd() : drawuUserImage(image),    
            ],
          ),
        ),
      ),
      elevation: 5.0,
      shape: CircleBorder(),
    );
  }

  drawIconAdd(){
    return Column(
      children: <Widget>[
        Icon(Icons.add_a_photo, color:Colors.black, size: 30.0,),
        SizedBox(height: 5.0),
        Text(
          'Agregar',
        ),
      ],
    );
  }

  drawuUserImage(File image){
    return Column(
      children: <Widget>[
        Image(
            image: FileImage(image),
            width: 100.0,
            height: 100.0,
          )
      ],
    );
  }


  void showDialogPicture(){
    
  var width = MediaQuery.of(context).size.width;
    Alert(
      context: context,
      title: 'Completar acción utilizando',
      buttons: [
        DialogButton(
          onPressed: (){
            Navigator.of(context).pop();
            getImage();
          }, 
          child: Row(
            children: <Widget>[
              Text("  "),
              Icon(Icons.camera_alt, color: Colors.white),
              Text(
                "   Camara",
                style: TextStyle(color: Colors.white, fontSize: width/28),
              ),
            ],
          ),
        color: Colors.orange,
        ),
        DialogButton(
          onPressed: (){
            Navigator.of(context).pop();
            getGallery();
            
          }, 
          child: Row(
          children: <Widget>[
            Text("  "),
            Icon(Icons.photo, color: Colors.white),
            Text(
              "   Galeria",
              style: TextStyle(color: Colors.white, fontSize: width/28),
            ),
          ],
        ), 
        color: Colors.orange,
        ),
      ]
    ).show();

  }
}