import 'package:e_management/src/models/menu_item.dart';
import 'package:flutter/material.dart';

class MenuItems {
  static const List<MenuItem> itemsFirst = [
    itemProfile,
    itemSettings,
  ];

  static const List<MenuItem> itemsSecond = [
    itemLogout,
  ];

  static const itemProfile = MenuItem(
    text: 'Profile',
    icon: Icons.person,
  );

  static const itemSettings = MenuItem(
    text: 'Settings',
    icon: Icons.settings,
  );

  static const itemLogout = MenuItem(text: 'Déconnexion', icon: Icons.logout);
}
