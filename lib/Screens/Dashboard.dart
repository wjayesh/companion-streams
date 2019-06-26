import 'package:flutter/material.dart';
import 'package:companion/ClientModel.dart';
import 'package:companion/Database.dart';


class Dashboard extends StatefulWidget{
  Dashboard({this.id,this.values});
  final int id;
  final Map<String,double> values;

@override
DashboardState createState()=> DashboardState(id,values);
}

class DashboardState extends State<Dashboard>{
  int id;
  final Map<String,double> values;
  DashboardState(this.id,this.values);
  Client client;

  void getClient() async{
    client=await DBProvider.db.getClient(id);
    Client newClient=Client(
    id: client.id, q1: values["q1"],q2: values["q2"],q3: values["q3"],
    q1old: values["q1old"],q2old: values["q2old"],q3old: values["q3"]);
    update(newClient);
    setState(() { 
    });
  }

  @override
  void initState(){
    getClient();
    super.initState();
    updateProgress();
  }

  void updateProgress()async{
    if(client==null)return;
    if(client.q1==null ||client.q1old==null) return;
    double progress1=client.q1-client.q1old;
    client.progress1=progress1;
    
    await DBProvider.db.updateClient(client);
    setState((){});
  }

  void update(Client newClient)async{
    await DBProvider.db.updateClient(newClient);
    setState((){});
  }
  
  @override
  Widget build(BuildContext context){
    return Material(
      type: MaterialType.transparency,
      child:(client==null)? Container(child: Text("loading...",textAlign: TextAlign.center,),):
      ListView(
      children: <Widget>[
          
            (client.show1)? Container():
            
              
                //(client.progress1>0)?
              ListTile(
                contentPadding: EdgeInsets.all(10.0),
                 title:Image.asset("assets/congrats.jpg", width: 200,height: 200,), 
                subtitle: Text("Congratulations! You met 5 more people today", style:TextStyle(fontWeight: FontWeight.bold)),
              ),
              // :ListTile(
              //   //leading: Image.asset("encourage"),
              //   title: Text("You are yet to make progress"),
              // ) ,
               
            
            ButtonTheme.bar( // makes buttons use the appropriate styles for cards
            child: ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('Share'),
                  onPressed: () { 
                    //TODO Implement share to social media
                   },
                ),
                FlatButton(
                  child: const Text('Dismiss'),
                  onPressed: () { 
                    client.show1=false;
                    update(client);
                   },
                ),
              ],
            ),
          ),

         
              ListTile(
                contentPadding: EdgeInsets.all(10.0),
                 title:Image.asset("assets/congrats.jpg", width: 200,height: 200,), 
                subtitle: Text("Treat yourself! You are happier today than a week ago", style:TextStyle(fontWeight: FontWeight.bold)),
              ),
              ButtonTheme.bar( // makes buttons use the appropriate styles for cards
            child: ButtonBar(
              children: <Widget>[
                FlatButton(
                  child: const Text('Share'),
                  onPressed: () { 
                    //TODO Implement share to social media
                   },
                ),
                FlatButton(
                  child: const Text('Dismiss'),
                  onPressed: () { 
                    client.show2=false;
                    update(client);
                   },
                ),
              ],
            ),
          ),]
          )
          
          );
         
        
  }}