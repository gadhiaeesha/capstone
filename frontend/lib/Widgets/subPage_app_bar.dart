import 'package:flutter/material.dart';

AppBar subPageAppBar(BuildContext context, String title) {
  return AppBar(
    leading: IconButton(
      icon: const Icon(
        Icons.arrow_back,
        color: Colors.white,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    ),
    title: Text(
      title,
      style: const TextStyle(color: Colors.white),
    ),
    centerTitle: true,
    elevation: 0.0,
    backgroundColor: const Color(0xFF001133),
  );
}
