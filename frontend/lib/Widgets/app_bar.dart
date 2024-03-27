import 'package:flutter/material.dart';


AppBar customAppBar() {
  return AppBar(
    centerTitle: true,
    title: const Text(
      "ReMu", 
      style: TextStyle(
          color: Colors.white,
      )
    ),
    leading: const IconButton(
      onPressed: null, //come back to create navigation to menupage
      icon: Icon(Icons.menu),
      color: Colors.white,
    ),
    elevation: 0.0,
    backgroundColor: const Color(0xFF001133),
  );
}