import 'package:flutter_dashboard/model/menu_model.dart';
import 'package:flutter/material.dart';

class SideMenuData {
  final menu = const <MenuModel>[
    MenuModel(
      icon: Icons.home,
      title: 'Dashboard',
      subMenu: [
        MenuModel(icon: Icons.dashboard, title: 'Overview'),
        MenuModel(icon: Icons.analytics, title: 'Analytics'),
      ],
    ),
    MenuModel(
      icon: Icons.person,
      title: 'Profile',
      subMenu: [
        MenuModel(icon: Icons.edit, title: 'Edit Profile'),
        MenuModel(icon: Icons.security, title: 'Security'),
      ],
    ),
    MenuModel(icon: Icons.trending_up, title: 'Influence System'),
    MenuModel(icon: Icons.settings, title: 'Settings'),
    MenuModel(icon: Icons.history, title: 'Stats'),
    MenuModel(icon: Icons.logout, title: 'SignOut'),
  ];
}
