import 'package:flutter/material.dart';

class DoctorPage extends StatefulWidget{
  DoctorPage();

@override
DoctorPageState createState()=> DoctorPageState();
}

class DoctorPageState extends State<DoctorPage>{

  @override
  Widget build(BuildContext context){
    return Material(
      child:ListView(
      children: <Widget>[
        Image.asset("assets/doctor.jpg",width: 250,height: 250,),
        Card(
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical:20.0,horizontal: 10.0),
            leading: Image.asset("assets/doctor1.jpg",width: 50,height:50,),
            title: Text("Dr. Jack Dorsey"),
            subtitle: ButtonTheme.bar( // make buttons use the appropriate styles for cards
            child: ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('Contact'),
                  onPressed: () { 
                    //TODO implement mailto: intent
                   },
                ),
              ],
            ),
          ),
          ),
          elevation: 5.0,
        ),
        Card(
          child: ListTile(
            contentPadding: EdgeInsets.symmetric(vertical:20.0,horizontal: 10.0),
            leading: Image.asset("assets/doctor2.jpg",width: 50,height: 50,),
            title: Text("Dr. Ray Aberthone"),
            subtitle: ButtonTheme.bar( // make buttons use the appropriate styles for cards
            child: ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('Contact'),
                  onPressed: () { 
                    //TODO implement mailto: intent
                   },
                ),
              ],
            ),
          ),
          ),
          elevation: 5.0,
        ),
      ],
    )
    );
  }
}