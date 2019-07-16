import 'package:companion/BlocBase.dart';
import 'package:companion/Message.dart';
import 'dart:async';

class UserBloc extends BlocBase{

  StreamController<Message> notDone1Controller = StreamController<Message>();
  Stream<Message> get outNotDone1 => notDone1Controller.stream;
  StreamSink<Message> get sinkNotDone1 => notDone1Controller.sink;


  void dispose(){
    notDone1Controller.close();
  }
  
} 