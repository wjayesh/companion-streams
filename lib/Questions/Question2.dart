import 'package:companion/ClientModel.dart';
import 'package:companion/Database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';
import 'package:flutter_villains/villain.dart';
import 'Question3.dart';


class Question2 extends StatefulWidget{
Question2({this.values,this.id});
final Map<String,double> values;
final int id;
@override
Question2State createState()=> Question2State(values,id);
}

class Question2State extends State<Question2>{
  Client client;
  String question="How happy do you feel today?";
  double valueSlider=1,oldValue=0;
  Question2State(this.values,this.id);
  final Map<String,double> values;
  final int id;
  void getClient()async{
    client= await DBProvider.db.getClient(id);
    setState(() { 
    });
  }

  @override 
  void initState(){
  getClient();
  super.initState();
  
  }

  void update(Client newClient) async{
    await DBProvider.db.updateClient(newClient);
    setState(() { 
    });
  }

  @override
  Widget build(BuildContext context){
    return Material(
      type: MaterialType.transparency,
      child: Villain(
      villainAnimation: VillainAnimation.fromBottom(
        curve: Curves.easeInCubic,
        relativeOffset:0.4,
        from:Duration(milliseconds:500),
        to:Duration(seconds:1),
      ),
      //animateExit:false
      secondaryVillainAnimation:VillainAnimation.fade(),
      child:Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.orange.shade100,
            Colors.red.shade800
          ],
        )
      ),
      child: Stack(
        children: <Widget>[
          Padding(
           padding: EdgeInsets.symmetric(vertical: 100.0,horizontal: 20.0),
           child:Align(child: Text.rich(TextSpan(text: question),
           style:TextStyle(fontStyle: FontStyle.normal,fontSize: 30.0,fontWeight: FontWeight.bold)
           
           ),
           alignment: Alignment.topCenter,
          )
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child:Align(child:FluidSlider(
            value:valueSlider,
            onChanged: (newValue){
                setState(() {
                  oldValue=valueSlider;
                 valueSlider=newValue; 
                });
                Client newClient = Client.fromMap(client.toMap());
                newClient.q2old = oldValue;
                newClient.q2 = valueSlider;
                update(newClient);
              }
            ,
            // start: Image.asset("less people"),
            //end: Image.asset("more people"),
            min: 1, max: 1000,
          ),
          alignment: Alignment.center,
         )
         ),
        Padding(
          padding: EdgeInsets.all(50.0),
          child:Align(child:FlatButton(
              child: Text("N E X T",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
              onPressed:(){ 
                Navigator.of(context).push(
                  MaterialPageRoute(builder:(context)=>Question3(id: id,) )
            );},
            ),  alignment: Alignment.bottomCenter,
         )
         )
        ],
      )  ,
      )
    )
    );
}}