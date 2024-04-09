// ignore_for_file: sized_box_for_whitespace, duplicate_ignore, unnecessary_this

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/Pages/image_page.dart';
import 'package:frontend/Pages/upload_page.dart';
import 'package:frontend/Widgets/app_bar.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:frontend/Models/image.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  
  //need a function to upload image file to backend

  //need a function to receive data from backend and display

  // As of right now, image picked from gallery is displayed, but only after exiting and re-opening modalBottomSheet
  File? _image;
  
  Future getImage(ImageSource check) async {
    //await requestPermission(); //Request permission before attempting to access camera/gallery
    final image = await ImagePicker().pickImage(source: check);
    try{
      if(image == null) return;

      final imageTemp = File(image.path);

      setState(() {
        this._image = imageTemp;
      });
    } 
    catch(e) {
      print(e);
    }
    
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black, 
                    width: 2
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: IconButton(
                  icon: const Icon(Icons.music_note),
                  iconSize: 100,
                  onPressed: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const ImagePage()
                      ),
                    );
                  }
                )
              ),
              const SizedBox(height: 10),
              const Text("Image #1"),
            ],
          ),
        ),
      ),//Image.asset('assets/images/01.PNG'), //https://suragch.medium.com/how-to-include-images-in-your-flutter-app-863889fc0b29
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context, 
            builder: (BuildContext context) { //context is variable which stores information of current state
              // ignore: sized_box_for_whitespace
              return Container(
                height: MediaQuery.of(context).size.height,
                //color: Colors.grey,
                child: Center(
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          "Upload Sheet Music",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )
                        ),
                      ),
                      const SizedBox(height: 70),
                      _image != null 
                        ? Image.file(
                            _image!, 
                            width: 100, 
                            height:100, 
                            fit: BoxFit.cover
                          ) 
                          : const FlutterLogo(size: 160.0),
                      ElevatedButton(
                        onPressed: () {
                          getImage(ImageSource.gallery);
                          /* Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => UploadPage(imagePath: _image!.path)
                            ),
                          ); */
                        },  
                        child: Container(
                          width: 280,
                          child: const Text("Pick from Gallery"),
                        )),
                      ElevatedButton(
                        onPressed: () => getImage(ImageSource.camera), 
                        child: Container(
                          width: 280,
                          child: const Text("Pick from Camera"),
                        )),
                      ElevatedButton(
                        onPressed: () => Navigator.push(
                            context, 
                            MaterialPageRoute(builder: (context) => UploadPage(imagePath: _image!.path)
                            ),
                          ), 
                        // ignore: sized_box_for_whitespace
                        child: Container(
                          width: 280,
                          child: const Text("Upload"),
                        )
                      ),
                    ],
                    
                  )
                )
              );
            },
          );
        },
        child: const Icon(Icons.add)
      ),
    );
  }
}

// ignore: non_constant_identifier_names
Widget CustomButton({
  required String title,
  required IconData icon,
  required VoidCallback onClick,
}) {
  // ignore: sized_box_for_whitespace
  return Container(
    width: 280,
    child: ElevatedButton(
      onPressed: () => {},
      child: Row(
        children: [
          Icon(icon),
          const SizedBox(
            width: 20,
          ),
          Text(title)
        ],
      )
    ),
  );
}
