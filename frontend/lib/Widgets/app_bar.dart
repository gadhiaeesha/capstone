// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Function(String) onMenuItemClicked;

  const CustomAppBar({super.key, required this.onMenuItemClicked});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text(
        "ReMu", 
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      leading: IconButton(
        onPressed: () {
          // Open the drawer when the menu icon is pressed
          Scaffold.of(context).openDrawer();
        },
        icon: Icon(
          Icons.menu,
          color: Colors.white,
        ),
      ),
      elevation: 0.0,
      backgroundColor: const Color(0xFF001133),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class SideMenu extends StatelessWidget {
  final Function(String) onMenuItemClicked;

  const SideMenu({super.key, required this.onMenuItemClicked});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: const Color(0xFF001133),
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Uploads'),
            onTap: () {
              onMenuItemClicked('Uploads');
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            title: Text('Settings'),
            onTap: () {
              onMenuItemClicked('Settings');
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            title: Text('Log Out'),
            onTap: () {
              onMenuItemClicked('Log Out');
              Navigator.pop(context); // Close the drawer
            },
          ),
        ],
      ),
    );
  }
}
