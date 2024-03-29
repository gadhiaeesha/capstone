import 'package:flutter/material.dart';
import 'package:frontend/Pages/music_page.dart';

class MusicContainer extends StatelessWidget {
  final int id;
  final String title;
  
  const MusicContainer({Key? key, 
  required this.id, 
  required this.title,  
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
                      MaterialPageRoute(builder: (context) => const MusicPage()
                      ),
                    );
                  }
                )
              ),
              const SizedBox(height: 10),
              Text(title), 
            ],
          ),
    );
  }
}