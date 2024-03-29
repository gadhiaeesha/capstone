import 'package:flutter/material.dart';
import 'package:frontend/Pages/image_page.dart';
import 'package:frontend/Pages/upload_page.dart';
import 'package:frontend/Widgets/app_bar.dart';
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
                OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context, 
                      MaterialPageRoute(builder: (context) => const UploadPage()),
                    );
                    /* showDialog(
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
                    ); */
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
        },
        child: const Icon(Icons.add)
      ),
    );
  }
}


