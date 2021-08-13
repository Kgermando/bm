
import 'package:e_management/services/auth_service.dart';
import 'package:e_management/src/auth/login_screen.dart';
import 'package:e_management/src/auth/profile_screen.dart';
import 'package:e_management/src/models/menu_item.dart';
import 'package:e_management/src/screens/setting_screen.dart';
import 'package:e_management/src/utils/menu_items.dart';
import 'package:flutter/material.dart';

class MenuOptions {
  PopupMenuItem<MenuItem> buildItem(MenuItem item) => PopupMenuItem(
      value: item,
      child: Row(
        children: [
          Icon(item.icon, color: Colors.black, size: 20),
          const SizedBox(width: 12),
          Text(item.text)
        ],
      ));

  void onSelected(BuildContext context, MenuItem item) {
    switch (item) {
      case MenuItems.itemSettings:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => SettingsScreen()));
        break;
      case MenuItems.itemProfile:
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => ProfileScreen()));

        break;
      case MenuItems.itemLogout:
        // Remove stockage jwt here.
        AuthService().logout();
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LoginScreen()),
            (route) => false);
        break;
    }
  }
}