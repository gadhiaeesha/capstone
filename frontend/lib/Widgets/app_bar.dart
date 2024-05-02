import 'package:flutter/material.dart';


AppBar customAppBar() {
  return AppBar(
    //centerTitle: true,
    title: const Text(
      "ReMu", 
      style: TextStyle(
          color: Colors.white,
      )
    ),
    leading: IconButton(
      onPressed: () {
        // Add functionality for the menu button here
      },
      icon: const Icon(
        Icons.menu,
        color: Colors.white, // Set the color of the menu icon to white
      ),
    ),
    elevation: 0.0,
    backgroundColor: const Color(0xFF001133),
  );
}