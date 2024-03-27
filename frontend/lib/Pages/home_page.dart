import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: Padding(
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
      )//Image.asset('assets/images/01.PNG'), //https://suragch.medium.com/how-to-include-images-in-your-flutter-app-863889fc0b29

    );
  }
}

class ImagePage extends StatelessWidget {
  const ImagePage({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image #1"),
      ),
      body: Center(
        child: Image.asset('assets/images/01.PNG'),
      )
    );
  }
}
