import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

 
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        
        primarySwatch: Colors.blue,
        
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  File imageFile;
  final _picker = ImagePicker();
  _openGallery(BuildContext context) async{
     PickedFile pickedFile = await _picker.getImage(source: ImageSource.gallery  );
     final File picture = File(pickedFile.path);
     this.setState(() {
       imageFile= picture;
     });
    Navigator.of(context).pop();
  }
  _openCamera(BuildContext context) async{
    PickedFile pickedFile = await _picker.getImage(source: ImageSource.camera  );
     final File picture = File(pickedFile.path);
     this.setState(() {
       imageFile= picture;
     });
     Navigator.of(context).pop();
  }
   Future<void> _showChoiceDialog (BuildContext context)
  {
    return showDialog(context: context,builder: (BuildContext context) {
      return AlertDialog(
        title:Text("Make a choice !!"),
        content:SingleChildScrollView(child: ListBody(children:<Widget> [
          GestureDetector(
            child: Text("Gallery"),
            onTap: (){
              _openGallery(context);
            },           ),
            Padding(padding: EdgeInsets.all(8.0)),
            GestureDetector(
            child: Text("Camera"),
            onTap: (){
              _openCamera(context);
            },),
            ],),)
      );
    });
  }

  Widget _decideImageView(){
    if (imageFile == null)
    { return Text("No image selected",); }
    else{
     return Image.file(imageFile,width:400,height:400);
     //return Text("images :");
    }
  }
  
  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      
      appBar: AppBar(
        
        title: Text("Import Images Screen"),
      ),
      body: Container(
        
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              //Text('No image selected',),
              //Image.file(imageFile,width:400,height:400),
              _decideImageView(),
              RaisedButton(
                onPressed: (){ _showChoiceDialog(context);},
                child: Text('Select Image :'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
