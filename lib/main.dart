import 'package:flutter/material.dart';
import 'CustomTabBar.dart';
import "Screens/Tasks.dart";
import 'Screens/Dashboard.dart';
import 'Screens/AccountPage.dart';
import 'Screens/DoctorPage.dart';
import 'Questions/Question1.dart';
import 'Questions/Question2.dart';
import 'Questions/Question3.dart';
import 'package:flutter_villains/villain.dart';
import 'Screens/Login.dart';
import 'Database.dart';

void main() =>runApp(MyApp());


class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      navigatorObservers: [VillainTransitionObserver()],
      routes: 
      {
        "/":(context)=>Login(),
        "q1" : (context)=>Question1(),
        "q2" : (context)=>Question2(), 
        "q3" : (context)=>Question3(), 
        "home" :(context)=>MyHomePage(title:"Your Companion"),
        "doctor": (context)=>DoctorPage(),
        "account": (context)=>AccountPage(),
        "dashboard": (context)=>Dashboard()
      },
      title: 'companion',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title,this.id}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".
  final int id;
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState(id);
}

class _MyHomePageState extends State<MyHomePage> {
PageController pageController=PageController(initialPage: 0);
final int id;
_MyHomePageState(this.id);
Map<String,Widget> pages;
@override
void initState(){
  pages=<String,Widget>{
    "Tasks" : Tasks(id),
    "Dashboard" : Dashboard(id:id),   
  };
  super.initState();
}
  

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        backgroundColor:
        Colors.deepOrange,
        title: Text(
          widget.title,
          textAlign: TextAlign.left,
          style: TextStyle(fontStyle: FontStyle.normal,fontWeight: FontWeight.bold)
          ),
          
        bottom: CustomTabBar(pageController: pageController, pageNames: pages.keys.toList(),),
      ),
      drawer: Drawer(
        elevation: 16.0,
        child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            margin:EdgeInsets.all(10.0) ,
            child:  Image.asset("assets/drawer.jpg",width: 100,height: 100,),
          ),
        ListTile(
        title: Text('Get Professional Help',
          style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.normal),),
        onTap: () {
        Navigator.pushNamed(context, "doctor");
        
        },
        ),
        ListTile(
        title: Text('Clear All Accounts',
          style: TextStyle(fontWeight: FontWeight.bold,fontStyle: FontStyle.normal),),
        onTap: () async {
        Navigator.of(context).pushNamed("/");
        await DBProvider.db.deleteAll();
        
        },
        ),
        
        
        ]
        )
      ),
      body: 
        PageView(
        controller: pageController,
        children: pages.values.toList(),
        )
      
    );
      
  }
}
