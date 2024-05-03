// ignore_for_file: sized_box_for_whitespace, duplicate_ignore, unnecessary_this, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:frontend/Constants/api.dart';
import 'package:frontend/Models/image.dart';
import 'package:frontend/Pages/image_page.dart';
import 'package:frontend/Pages/upload_page.dart';
import 'package:frontend/Widgets/homePage_app_bar.dart';
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

      // ignore: use_build_context_synchronously
      Navigator.push(
        context, 
        MaterialPageRoute(builder: (context) => UploadPage(imagePath: _image!.path)
        ),
      );
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
                ElevatedButton(
                  onPressed: () {
                    getImage(ImageSource.gallery);
                  },  
                  child: Container(
                    width: 280,
                    child: const Text("Pick from Gallery"),
                  )),
                ElevatedButton(
                  onPressed: () {
                    getImage(ImageSource.camera);
                  }, 
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

  void populateList() {
    List<String> imagePaths = [
      'assets/images/01.PNG',
      'assets/images/02.PNG',
      'assets/images/03.PNG',
      'assets/images/04.PNG',
      'assets/images/05.PNG',
      'assets/images/06.PNG',
      'assets/images/07.PNG',
      'assets/images/08.PNG',
      'assets/images/09.PNG',
      'assets/images/10.PNG',
    ];

    for(var i = 0; i < imagePaths.length; i++){
      myImages.add(
        Images(
          id: i+1, 
          title: "Image #${i+1}", 
          path: imagePaths[i],
        )
      );
    }
    setState(() {});
  }

  /* void fetchData() async {
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
      print("Check 1 2");
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

    // ignore: non_constant_identifier_names
    void delete_image(String id) async {
    try {
      http.Response response = await http.delete(Uri.parse("$api/$id"));
      setState(() {
        myImages = [];
      });
      fetchData();
    } catch (e) {
      print(e);
    }
  } */

  @override
  void initState() {
    //fetchData();
    populateList();
    super.initState();
    
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(
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
              SizedBox(
                height: MediaQuery.of(context).size.height,
                child: GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 0.8,
                  children: myImages.map((e) {
                    return ImageContainer(
                      id: e.id,
                      title: e.title,
                      path: e.path,
                    );
                  }).toList(),
                ),
              )
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

