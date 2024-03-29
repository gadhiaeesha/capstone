import 'package:flutter/material.dart';
import 'package:frontend/Widgets/app_bar.dart';

class MusicPage extends StatelessWidget {
  const MusicPage({Key? key}) : super(key: key);
  
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