import 'package:flutter/material.dart';
import 'package:lenguaje_de_senas_app/Model/detailCategory.dart';
import 'package:page_slider/page_slider.dart';
import 'dataBase.dart';

Future<List<DetailCategory>> getDetailCategorys() async{
  var dbLenguajeSenas = DBLenguajeSenas();
  Future<List<DetailCategory>> detailCategorys = dbLenguajeSenas.getDetailCategorys();

  return detailCategorys;

}
 
 class LearnPage extends StatefulWidget {
   LearnPage({Key key}) : super(key: key);
   @override
   _LearnPageState createState() => _LearnPageState();
 }
 
 class _LearnPageState extends State<LearnPage> {
   GlobalKey<PageSliderState> _slider = GlobalKey();

   @override
   Widget build(BuildContext context) {
     return Scaffold(
       backgroundColor: Colors.orange,
       appBar: AppBar(
         title: Text(''),
          iconTheme: IconThemeData(color: Colors.white),
         leading: IconButton(
           onPressed: ()=> Navigator.of(context).pop() ,
           icon: Icon(Icons.arrow_back),
         ),
       ),
       body: Center(
         child: Column(
           mainAxisSize: MainAxisSize.max,
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
           children: <Widget>[
             FutureBuilder(
               future: getDetailCategorys(),
               builder: (context, snapshot) {
                 if ((snapshot.data != null) && (snapshot.hasData))
                 {
                   return ListView.builder(
                       itemExtent: 160.0,
                       itemCount: snapshot.data.length,
                       itemBuilder: (BuildContext context, int index) {
                         return PageSlider(
                           key: _slider,
                           duration: Duration(milliseconds: 400),
                           pages: <Widget>[
                             Card(
                               elevation: 10,
                               child: Padding(
                                   padding: EdgeInsets.all(100),
                                   child: Image.asset(snapshot.data[index].urlImageGif)
                               ),
                             ),
                             SizedBox(height: 20.0),
                             Text(
                               snapshot.data[index].word,
                               style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.0),
                             ),
                           ],
                         );
                       }
                   );
                 }
                 return new Container(
                   alignment: AlignmentDirectional.center,
                   child: new CircularProgressIndicator(),
                 );
               },
             ),

             Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
               children: <Widget>[
                 FloatingActionButton(
                     child: Icon(Icons.arrow_back),
                     foregroundColor: Colors.white,
                     onPressed: () => _slider.currentState.previous(),
                   ),
                 FloatingActionButton(
                   child: Icon(Icons.arrow_forward),
                   foregroundColor: Colors.white,
                   onPressed: () => _slider.currentState.next(),
                 ),
               ],
             ),
           ],
         ),
       ),
     );
   }


 }