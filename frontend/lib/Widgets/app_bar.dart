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
    leading: const Icon(
      Icons.menu,
      color: Colors.white,
    ),
    elevation: 0.0,
    backgroundColor: const Color(0xFF001133),
  );
}