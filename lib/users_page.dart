import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:lenguaje_de_senas_app/Model/user.dart';
import 'package:lenguaje_de_senas_app/main_page.dart';
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
  bool _statusButton = false;
  String _statusAction = '';

  @override
  void initState() {
    super.initState();

    verifyDBUsers();
  }

  verifyDBUsers() async {
    final val = await getUsers();
    // length table users
    if(val.length > 0){
      setState(() {
        _statusButton = true;
      });
    }else{
      setState(() {
        _statusButton = false;
      });
    }
  }

  Future<bool> _onBackPressed(){
    return showDialog(
      context: context,
      builder: (context)=> AlertDialog(
        title: Text('¿Desea salir de la aplicación?'),
        actions: <Widget>[
          FlatButton(
            child: Text('Si'),
            onPressed: () => Navigator.pop(context,true),
          ),
          FlatButton(
            child: Text('No'),
            onPressed: () => Navigator.pop(context,false),
          )
        ],
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold( 
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
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 15.0),
                  FutureBuilder(
                    future: getUsers(),
                    builder: (context, snapshot){
                      if(!(snapshot.data == null || snapshot.data.isEmpty))
                      {
                        _statusButton =  true;

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
                        _statusButton = false;
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
          visible: _statusButton,
          child: SpeedDial(
            animatedIcon: AnimatedIcons.menu_close,
            foregroundColor: Colors.white,
            overlayOpacity: 0.2,
            children: [
              SpeedDialChild(
                  child: Icon(Icons.delete, color: Colors.white,),
                  label: "Eliminar Usuario",
                  backgroundColor: Colors.red,
                  onTap: () => _buttonAction('delete',0, ''),
              ),
              SpeedDialChild(
                  child: Icon(Icons.edit, color: Colors.white,),
                  label: "Modificar Usuario",
                  onTap: () => _buttonAction('modify',0, ''),
              ),
            ],
          ),
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
        child: GestureDetector(
          onTap: () => _buttonAction('login',user.idUser,user.nameUser),
          child:Column(
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
                Toast.show("Usuario Guardado", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER,
                    textColor: Colors.white, backgroundColor: Colors.blue);

                setState(() {
                  getUsers();
                  verifyDBUsers();
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

  _buttonAction(String status, int id, String name){

    if(_statusAction == ''){
      _statusAction = status;
    }


    if(id == 0){
      Toast.show(
        "Seleccionar un Usuario...",
        context,
        duration: Toast.LENGTH_LONG,
        gravity:  Toast.BOTTOM,
        textColor: Colors.white,
        backgroundColor: Colors.blue
      );

      _statusAction = status;
    }
    else
    {

      switch (_statusAction) {
        case 'delete':
          _showDialogDeleteUser(id, name);
          break;
        
        case 'modify':
          _showDialogModify(id, name);
          break;
        
        case 'cancel':
          _statusAction = '';
          break;
        
        case 'login':
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => new MainPage(id, name)));
          break;
      }
    }

  }

  void _showDialogModify(int id, String name){
    var width = MediaQuery.of(context).size.width;

    Alert(

        context: context,
        title: "Modificar Usuario",
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
                autofocus: true,
                decoration: InputDecoration(
                  icon: Icon(Icons.account_circle),
                  labelText: 'Nombre ', 
                ),
                initialValue: name,
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

                name = nameUser.toLowerCase();
                String firstCharacter = name.substring(0, 1);
                String afterFirstCharacter= name.substring(1, name.length);

                name = firstCharacter.toUpperCase() + afterFirstCharacter;

                var user = User();
                user.idUser = id;
                user.nameUser = name;

                var dbLenguajeSenas = DBLenguajeSenas();
                dbLenguajeSenas.updateUser(user);
                Toast.show("Usuario Actualizado", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER,
                    textColor: Colors.white, backgroundColor: Colors.blue);
                
                _statusAction = '';

                setState(() {
                  getUsers(); 
                  verifyDBUsers();
                });
                

              }

            }, 
            child: Text(
              "ACTUALIZAR",
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


  void _showDialogDeleteUser(int id, String name){
    var width = MediaQuery.of(context).size.width;

    Alert(

        context: context,
        title: "¿Esta seguro que desea eliminar este usuario?",
        content: Column(
          children: <Widget>[
            Card(
              child: Container(
                padding: EdgeInsets.all(25.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    //userImage('${user.urlImageUser}'),
                    userImage(name),
                    SizedBox(height: 5.0),
                    Text(
                      name,
                    ),
                  ],
                ),
              ),
              elevation: 5.0,
              shape: CircleBorder(),
            ),
            
          ],
        ),
        buttons: [
          DialogButton(
            onPressed: (){
                Navigator.of(context).pop();

                var user = User();
                user.idUser = id;

                var dbLenguajeSenas = DBLenguajeSenas();
                dbLenguajeSenas.deleteUser(user);

                Toast.show("Usuario Eliminado", context, duration: Toast.LENGTH_LONG, gravity:  Toast.CENTER,
                    textColor: Colors.white, backgroundColor: Colors.blue);
                
                _statusAction = '';

                setState(() {
                  getUsers(); 
                  verifyDBUsers();
                });


            }, 
            child: Text(
              "CONFIRMAR",
              style: TextStyle(color: Colors.white, fontSize: width/28),
            ),
            color: Colors.blue,
          ),
          DialogButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              "CANCELAR",
              style: TextStyle(color: Colors.white, fontSize: width/28),
            ),
            color: Colors.red,
          ),
        ]).show();
  }

}