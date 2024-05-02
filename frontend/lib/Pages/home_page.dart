// ignore_for_file: sized_box_for_whitespace, duplicate_ignore, unnecessary_this, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/Constants/api.dart';
import 'package:frontend/Models/image.dart';
import 'package:frontend/Pages/image_page.dart';
import 'package:frontend/Pages/upload_page.dart';
import 'package:frontend/Widgets/app_bar.dart';
import 'package:frontend/Widgets/image_container.dart';
import 'package:http/http.dart' as http;
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
  List<Images> myImages = [];

  // As of right now, image picked from gallery is displayed, but only after exiting and re-opening modalBottomSheet
  File? _image;
  
  Future getImage(ImageSource check) async {
    //await requestPermission(); //Request permission before attempting to access camera/gallery
    final image = await ImagePicker().pickImage(source: check);
    try{
      if(image == null) return;

      final imageTemp = File(image.path);

      setState(() { //figure out why state is not being updated immediately in app
        _image = imageTemp;
      });
    } 
    catch(e) {
      print(e);
    }
  
  }

  void _showModal(){
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
  }

  void fetchData() async {
    try {
      http.Response response = await http.get(Uri.parse(api));
      var data = json.decode(response.body);
      data.forEach((image) {
        Images i = Images(
          id: image['id'],
          title: image['title'],
        );
        myImages.add(i);
      });
      print(myImages.length);
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Error is $e");
    }
  }

  void _postData({String title = ""}) async {
    try {
      http.Response response = await http.post(
        Uri.parse(api),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "title": title,
        }),
      );
      if (response.statusCode == 201) {
        setState(() {
          myImages = [];
        });
        fetchData();
      } else {
        print("Something went wrong");
      }
    } catch (e) {
      print("Error is $e");
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onMenuItemClicked: (menuItem) {
          // Handle menu item click here
          print('Clicked on: $menuItem');
        },
      ),
      drawer: SideMenu(
        onMenuItemClicked: (menuItem) {
          // Handle menu item click here
          print('Clicked on: $menuItem');
        },
      ),
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
          _showModal();
        },
        child: const Icon(Icons.add)
      ),
    );
  }
}

