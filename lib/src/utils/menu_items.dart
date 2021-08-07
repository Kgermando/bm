import 'package:e_management/src/models/menu_item.dart';
import 'package:flutter/material.dart';

class MenuItems {
  static const List<MenuItem> itemsFirst = [
    itemSettings,
    itemProfile, 
  ];

  static const List<MenuItem> itemsSecond = [
    itemLogout,
  ];

  static const itemSettings = MenuItem(
    text: 'Settings',
    icon: Icons.settings,
  );

  static const itemProfile = MenuItem(
    text: 'Settings',
    icon: Icons.person,
  );

  static const itemLogout = MenuItem(text: 'Settings', icon: Icons.logout);
}
