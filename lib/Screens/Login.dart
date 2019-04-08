import 'package:flutter/material.dart';
import 'package:companion/main.dart';
import 'package:companion/ClientModel.dart';
import 'package:companion/Database.dart';
import 'dart:io';
class Login extends StatefulWidget{
  
  
@override 
LoginState createState()=>LoginState();
}
class LoginState extends State<Login>{
  static Client pehla=Client(firstName: "CHOOSE AN EXISTING USER");
  List<Client> clients=[pehla]; String name;

  @override
  void initState(){
    getClients();
    super.initState();
  }
  void getClients() async{
    clients=await DBProvider.db.getAllClients();
    setState(() { 
    });
  }
  final controller=TextEditingController();


  @override
  Widget build(BuildContext context){
    
    return Material(
      child:Column(
      children:<Widget>[ 
        Image.asset("assets/drawer.jpg"),
        Padding(
        child:TextField(
          onEditingComplete: (){name=controller.text;},
          controller: controller ,
          decoration: InputDecoration(hintText: "Enter Name"),
        ),
        padding: EdgeInsets.all(30.0) ,
        ),
        RaisedButton(
          padding: EdgeInsets.all(10.0),
          highlightColor: Colors.deepOrange,
          child: Text("Proceed"),
          onPressed:() async{ 
          Client newClient=Client(firstName: controller.text);
          int id=await DBProvider.db.newClient(newClient);
          while(newClient.id!=null) sleep(const Duration(seconds: 2));
          
          Navigator.of(context).push(
            MaterialPageRoute(builder:(context)=>MyHomePage(title:"Your Companion",id:id)));}
        ),
        Flexible(child:ListView.builder(
          padding: EdgeInsets.all(10.0),
         itemBuilder: (context,index)=> GestureDetector(child:Padding(
              child:Text(clients[index].firstName) ,
              padding: EdgeInsets.all(10.0),),
              onTap:(){ 
              Navigator.of(context).push(
              MaterialPageRoute(builder:(context)=>MyHomePage(title:"Your Companion",id:clients[index].id)));},
              ),
         itemCount: clients.length,)
        )
        
      ]
      ));
  }
  

}