// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:frontend/Constants/api.dart';
import 'package:frontend/Widgets/app_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; 
import 'dart:io';

class UploadPage extends StatefulWidget {
  const UploadPage({Key? key, required this.imagePath}) : super(key: key);

  final String imagePath;

  @override
  // ignore: library_private_types_in_public_api
  _UploadPageState createState() => _UploadPageState();
}

class _UploadPageState extends State<UploadPage> {
  Future<void> _sendImage(String imagePath) async {
    try{
      //read image file as bytes
      File imageFile = File(imagePath);
      List<int> imageBytes = await imageFile.readAsBytes();

      //convert image bytes to base64 string
      String base64Image = base64Encode(imageBytes);

      //prepare payload
      Map<String, dynamic> payload = {
        'image': base64Image,
      };

      //convert payload to JSON
      String jsonPayload = jsonEncode(payload);

      //send image data to backend api
      var response = await http.post(
        Uri.parse(api),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonPayload,
      );

      //handle response
      if(response.statusCode == 200){
        print("Image uploaded successfully!");
      }
      else{
        print("Failed to upload image: ${response.statusCode}");
      }
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the selected image
            Image.file(
              File(widget.imagePath),
              width: 200,
              height: 200,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                //_sendImage(widget.imagePath);
                Navigator.popUntil(context, ModalRoute.withName('/'));
              },
              child: const Text("Upload Image"),
            ),
          ],
        ),
      ),
    );
  }
}
