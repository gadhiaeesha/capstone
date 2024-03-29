// ignore_for_file: avoid_print

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:frontend/Constants/api.dart';
import 'package:frontend/Pages/music_page.dart';
import 'package:frontend/Pages/upload_page.dart';
import 'package:frontend/Widgets/app_bar.dart';
import 'package:frontend/Widgets/music_container.dart';
import 'package:http/http.dart' as http;
import 'package:frontend/Models/music.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  List<Music> myMusic = []; //keep up to date track of user's uploads

  //need a function to upload image file to backend

  //need a function to receive data from backend and display

  void _showModal() {
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
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const UploadPage()),
                    );
                  },
                  child: const Text(
                    "Photo Gallery", //going to use this as a "Send Local Image" button instead of actual photo gallery for testing
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20
                    )
                  ),
                  
                ),
                const SizedBox(height: 20),
                OutlinedButton(
                  onPressed: () {
                    showDialog(
                      context: context, 
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Check"),
                          content: const Text("Checking"),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("OK"),
                            ),
                          ],

                        );
                      }
                    );
                  },
                  child: const Text(
                    "Camera",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20
                    )
                  ),
                  
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
        Music m = Music(
          id: image['id'],
          title: image['title'],
        );
        myMusic.add(m);
      });
      print(myMusic.length);
      setState(() {
        isLoading = false;
      });
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
      appBar: customAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(35.0),
          child: Column(
            children: myMusic.map((e) {
              return MusicContainer(
                id: e.id, 
                title: e.title,  
              );
            }).toList(),
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


