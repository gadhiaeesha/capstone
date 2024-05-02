import 'package:flutter/material.dart';
import 'package:frontend/Pages/image_page.dart';

class ImageContainer extends StatelessWidget {
  final int id;
  final String title;
  final String path;
  
  const ImageContainer({
    Key? key, 
    required this.id, 
    required this.title, 
    required this.path, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
                  MaterialPageRoute(builder: (context) => ImagePage(title: title, imagePath: path,)),
                );
              }
            ),
          ),
          const SizedBox(height: 10), // Adjust the spacing between the image and the title
          Text(
            title,
            textAlign: TextAlign.center, // Align the title text to the center
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
