import 'package:flutter_dashboard/model/current_user.dart' as current_user;
import 'package:flutter/material.dart';

import 'package:flutter_dashboard/widgets/dashboard_pages/dashboard_widget.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/Influence_system/influence_widget.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/Influence_system/transfer_widget.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/Influence_system/pers_stats_widget.dart';

import 'package:flutter_dashboard/widgets/dashboard_pages/admin/user_manager_widget.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/admin/department_manager_widget.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/admin/division_manager_widget.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/admin/role_manager_widget.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/home/welcome_widget.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/home/structure_widget.dart';

class MenuModel {
  final IconData icon;
  final String title;
  final Object? page;
  final List<MenuModel>? subMenu;


  const MenuModel({
    required this.icon,
    required this.title,
    this.page,
    this.subMenu,
  });
}

ValueNotifier<(int, int)> selectedIndex = ValueNotifier((0, 0));

final menu = <MenuModel>[
  MenuModel(
    icon: Icons.home,
    title: 'Home',
    subMenu: [
      MenuModel(icon: Icons.flag, title: 'Welcome', page: WelcomeWidget()),
      MenuModel(icon: Icons.schema, title: 'Structure', page: StructureWidget()),
      
    ],
  ),
  if (current_user.status.value.cORPMember!)
  MenuModel(
    icon: Icons.person,
    title: 'Influence System',
    subMenu: [
      MenuModel(icon: Icons.dashboard, title: 'Status', page: InfluenceWidget()),
      MenuModel(icon: Icons.send, title: 'Transfer', page: InfTransferWidget()),
      MenuModel(icon: Icons.military_tech, title: 'Personal Stats', page: InfPersonalStatsWidget()),
      MenuModel(icon: Icons.query_stats, title: 'Global Stats', page: InfTransferWidget()),
    ],
  ),
  if (current_user.status.value.isAdmin!)
  MenuModel(
    icon: Icons.person,
    title: 'Admin',
    subMenu: [
      MenuModel(icon: Icons.account_circle, title: 'Users', page: UserManagerWidget()),
      MenuModel(icon: Icons.business, title: 'Departments', page: DepartmentManagerWidget()),
      MenuModel(icon: Icons.groups, title: 'Divisions', page: DivisionManagerWidget()),
      MenuModel(icon: Icons.assignment_ind, title: 'Roles', page: RoleManagerWidget()),
    ],
  ),
  MenuModel(icon: Icons.history, title: 'Stats', page: InfluenceWidget()),
  MenuModel(
    icon: Icons.person,
    title: 'Settings',
    subMenu: [
      MenuModel(icon: Icons.manage_accounts, title: 'Profile', page: DashboardWidget()),
      MenuModel(icon: Icons.security, title: 'Security', page: InfluenceWidget()),
    ],
  ),
  MenuModel(icon: Icons.logout, title: 'SignOut', page: InfluenceWidget()),
];