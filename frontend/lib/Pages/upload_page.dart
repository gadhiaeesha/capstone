// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:frontend/Constants/api.dart';
import 'package:frontend/Widgets/homePage_app_bar.dart';
import 'package:frontend/Widgets/subPage_app_bar.dart';
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
  late String _title;
  bool haveTitle = false;
  
  

  Future<void> _sendImage(String imagePath, String title) async {
    try{
      //read image file as bytes
      File imageFile = File(imagePath);
      List<int> imageBytes = await imageFile.readAsBytes();

      //convert image bytes to base64 string
      String base64Image = base64Encode(imageBytes);

      //prepare payload
      Map<String, dynamic> payload = {
        'image': base64Image,
        'title': title,
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

  void _showTitleDialog() {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Enter Piece Name"),
        content: TextField(
          onChanged: (value) {
            setState(() {
              _title = value;
              haveTitle = _title.isNotEmpty;
            });
          },
          decoration: const InputDecoration(
            hintText: "Title",
          ),
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // Set rounded corners
                    side: const BorderSide(color: Color(0xFF001133)), // Set outline color
                    backgroundColor: Color(0xFF001133),
                  ), 
                  child: Container(
                    height: 50,
                    child: const Center(
                      child: Text(
                        "Enter",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10), // Add some space between buttons
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // Set rounded corners
                    side: const BorderSide(color: Color(0xFF001133)), // Set outline color
                  ), 
                  child: Container(
                    height: 50,
                    child: const Center(
                      child: Text(
                        "Back",
                        style: TextStyle(
                          fontSize: 20,
                          color: Color(0xFF001133)
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: subPageAppBar(context, "Upload Page"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display the selected image
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20), // Add side margins
              child: Flexible(
                child: Image.file(
                  File(widget.imagePath),
                  // Remove width and height constraints
                  fit: BoxFit.contain, // Keep aspect ratio and fit within the available space
                ),
              ),
            ),
            const SizedBox(height: 20),
            haveTitle
              ? ElevatedButton(
                  onPressed: () {
                    _sendImage(widget.imagePath, _title);
                    Navigator.popUntil(context, ModalRoute.withName('/'));
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // Set rounded corners
                    side: const BorderSide(color: const Color(0xFF001133)), // Set outline color
                  ), 
                  child: Container(
                    alignment: Alignment.center,
                    width: 280,
                    child: const Text(
                      "Upload Image",
                      style: TextStyle(
                        fontSize: 20,
                        color: const Color(0xFF001133)
                      ),
                    ),
                  )
                )
              : ElevatedButton(
                  onPressed: () {
                    _showTitleDialog();
                  },
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // Set rounded corners
                    side: const BorderSide(color: const Color(0xFF001133)), // Set outline color
                  ), 
                  child: Container(
                    alignment: Alignment.center,
                    width: 280,
                    child: const Text(
                      "Enter Title",
                      style: TextStyle(
                        fontSize: 20,
                        color: const Color(0xFF001133)
                      ),
                    ),
                  )
                ),
          ],
        ),
      ),
    );
  }
}
