import 'package:flutter/material.dart';
import 'package:frontend/Widgets/app_bar.dart';

class ImagePage extends StatefulWidget {
  final String title;
  final String imagePath;

  const ImagePage({Key? key, required this.title, required this.imagePath})
      : super(key: key);
  
  @override
  // ignore: library_private_types_in_public_api
  _ImagePageState createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  bool _isPlaying = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Image.asset(widget.imagePath),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  _isPlaying = !_isPlaying;
                });
              },
              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
            ),
          ],
        ),
      ),
    );
  }
}
