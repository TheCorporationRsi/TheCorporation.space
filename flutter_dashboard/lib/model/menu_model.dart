import 'package:flutter/material.dart';

class MenuModel {
  final IconData icon;
  final String title;
  final List<MenuModel>? subMenu;

  const MenuModel({
    required this.icon,
    required this.title,
    this.subMenu,
  });
}
