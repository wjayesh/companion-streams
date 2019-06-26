import 'package:flutter/material.dart';
import 'package:flutter_fluid_slider/flutter_fluid_slider.dart';
import 'package:flutter_villains/villain.dart';
import 'package:companion/Database.dart';
import 'package:companion/ClientModel.dart';
import 'Question2.dart';


class Question1 extends StatefulWidget{
Question1({this.id});
final int id;
@override
Question1State createState()=> Question1State(id);
}
Client client;
class Question1State extends State<Question1>{
  String question="How many people did you meet today?";
  double valueSlider=1,oldValue=0;
  Question1State(this.id);
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
    getClient();
  }

  @override
  Widget build(BuildContext context){
    //Map<String,double> values=Map.from({"x":0.0});
    return Material(
      type:MaterialType.transparency,
      child:Villain(
      // villainAnimation: VillainAnimation.fromTop(
        
      //   from:Duration(milliseconds:500),
      //   to:Duration(seconds:1),
      // ),
      //animateExit:false,
      villainAnimation:VillainAnimation.scale(
        curve: Curves.easeInSine,
        from: Duration(milliseconds: 600),
        to: Duration(seconds: 1)
      ),
      child:
      Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.amber,
            Colors.deepOrange
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
                newClient.q1old = oldValue;
                newClient.q1 = valueSlider;
                newClient.notDone1 = true;
                update(newClient);
              }
            ,
            // start: Image.asset("2 people.jpg"),
            // end: Image.asset("5 people.jpg"),
            min: 1, max: 20,
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
                  MaterialPageRoute(builder:(context)=>Question2(id: id,) )
                );},
            ),
            alignment: Alignment.bottomCenter,
         )
         )
        ],
      )  ,
      )
    )
    );
  }
}