import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:image_picker_saver/image_picker_saver.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';


void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static GlobalKey screen = new GlobalKey();
  

  @override
  Widget build(BuildContext context) {
    //RepaintBoundary
    return new Scaffold(
      appBar: new AppBar(

        title: new Text(widget.title),
      ),
      body: RepaintBoundary(
        key: screen,
        child:Container(
    height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          child: Column(
            children: <Widget>[
              new Text(
                'click the button below to capture image',
              ),
              new RaisedButton(
                child: Text('capture Image'),
                onPressed: (){},
              ),
              Image.network("https://images.pexels.com/photos/462118/pexels-photo-462118.jpeg",height: 200,width: 200,)

            ],

          ),

        ) ,
      ),



      floatingActionButton: new FloatingActionButton(
      onPressed: ScreenShot,
      tooltip: 'Increment',
      child: new Icon(Icons.add),
    ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );

  }
  ScreenShot() async{
    RenderRepaintBoundary boundary = screen.currentContext.findRenderObject();
    ui.Image image = await boundary.toImage();
    ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);

    var filePath = await ImagePickerSaver.saveFile(
        fileData:byteData.buffer.asUint8List() );
    print(filePath);

  }
}
