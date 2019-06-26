import 'dart:core';
import 'package:companion/Database.dart';
import 'package:flutter/material.dart';
import 'package:companion/ClientModel.dart';
import 'package:companion/Questions/Question1.dart';


class Tasks extends StatefulWidget{
  Tasks(this.id);
final int id;
@override
TasksState createState()=> TasksState(id);
}
Client client;

class TasksState extends State<Tasks>{
  TasksState(this.id);
  final int id;
  bool timeUp=false;

  void getClient()async{
    client= await DBProvider.db.getClient(id);
    setState(() { 
    });
  }

@override 
void initState(){
  getClient();
  super.initState();
  updateTime();
}

  bool isDepressed(){
    if(client.q1==null) return false;
    if(client.q1<3)
    return true;
    return false;
  }

  void updateTime()async{
    if(client==null) return;
    var now =DateTime.now().day;
    if( now- client.hour >=1){
      setState(() {
        timeUp=true;
      });
      
    }
        
  }

  void update(Client newClient) async{
    await DBProvider.db.updateClient(newClient);
    getClient();
    // setState(() { 
    // });
  }
  

  @override
  Widget build(BuildContext context){
    return Material(
    
      
    child:(client==null)?Container(child: Text("Loading...",textAlign: TextAlign.center,),):
    Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        (!client.answered && !timeUp) ? askQuestion() : Container(),
        Flexible(child:ListView(
          children: <Widget>[
            (isDepressed() && client.notDone1)? 
            GestureDetector(
              onDoubleTap: () {
                client.notDone1=false;
                update(client);
              }
               ,
              child:ListTile(
                contentPadding: EdgeInsets.all(10.0),
                title: Image.asset("assets/outdoors2.jpg",width: 200,height: 200,) ,
                subtitle: Text.rich(TextSpan(text:"Go out! Meet a few people today"),
                        style: TextStyle(fontWeight:FontWeight.bold ),),
              )

            )
            :Container(),
            (isDepressed() && client.notDone2)? 
            GestureDetector(
              onDoubleTap: (){
              client.notDone2=false;
                update(client);
                },
              child:ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal:10.0),
              title: Image.asset("assets/music2.jpg",width: 200,height: 200,) ,
              subtitle: Text.rich(TextSpan(text:"Listen to your favourite tracks"),
                        style: TextStyle(fontWeight:FontWeight.bold ),),
              )
              )
              :Container(),
              (isDepressed() && client.notDone3)?
              GestureDetector(
              onDoubleTap: (){
              client.notDone3=false;
                update(client);
                },
              child:ListTile(
                contentPadding: EdgeInsets.all(10.0),
                title: Image.asset("assets/work2.jpg",width: 200,height: 200) ,
                subtitle: Padding(child:Text.rich(TextSpan(text:"Take up some job!"),
                
                        style: TextStyle(fontWeight:FontWeight.bold ),),
                padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 20.0),
                ),
              )

            )
            :Container(),
            (isDepressed() && !client.notDone1)?
              ListTile(
                  title: Image.asset("assets/happy.jpg",width: 200,height: 200,),
                  subtitle: Padding(child:Text.rich(TextSpan(text:"Yay! You did good today"),
                
                        style: TextStyle(fontWeight:FontWeight.bold ),),
                padding: EdgeInsets.symmetric(vertical: 5.0,horizontal: 20.0),
                ), ) 
              
              :Container()
          ],
        ),
        
      )
      ],
      )
      );
      
  }

  Widget askQuestion(){
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const ListTile(
            leading: Icon(Icons.question_answer),
            title: Text('Ready to answer a few questions?'),
            subtitle: Text('It will only take a minute'),
          ),
          ButtonTheme.bar( // make buttons use the appropriate styles for cards
            child: ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('Yes!'),
                  onPressed: () { 
                    // Client newClient = Client.fromMap(client.toMap());
                    // newClient.answered = true;
                    // update(newClient);
                    Navigator.of(context).push(
                      MaterialPageRoute(builder: (context)=>Question1(id:id))
                    );
                   },
                ),
                FlatButton(
                  child: const Text('Not now'),
                  onPressed: () { 
                    client.answered=true;
                update(client);
                   },
                ),
              ],
            ),
          ),
        ],
      ),
      elevation: 2.0,
      margin: EdgeInsets.all(12.0),
    );
  }
}