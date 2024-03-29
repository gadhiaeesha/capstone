// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:frontend/Widgets/app_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; 
//import 'dart.io';

class UploadPage extends StatelessWidget {
  const UploadPage({Key? key}) : super(key: key);

  Future<void> _sendImage(String imagePath) async {
    try{
      //read image file as bytes
      //File imageFile = File(imagePath);
    }
    catch(e){
      print(e);
    }
    
    print("Sending Image File to Server");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Upload Files"),
      ),
      body: Center(
        child: OutlinedButton(
          onPressed: () {
            _sendImage('assests/images/01.PNG');
          },
          child: const Text(
            "Upload"
          ),
        ), //here we can display photo gallery and utilize image picker
      )
    );
  }
}