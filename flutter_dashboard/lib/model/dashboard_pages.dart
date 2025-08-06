import 'package:flutter_dashboard/model/current_user.dart' as current_user;
import 'package:flutter/material.dart';

// Core working widgets
import 'package:flutter_dashboard/widgets/dashboard_pages/main/welcome_widget.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/main/usage_guide_widget.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/main/structure_widget.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/tools/refinery_widget.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/admin/department_manager_widget.dart';

// Stub widgets for features under migration
import 'package:flutter_dashboard/widgets/dashboard_pages/influence_system/pers_stats_widget_stub.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/admin/user_manager_widget.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/admin/division_manager_widget_stub.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/admin/role_manager_widget_stub.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/admin/rank_manager_widget_stub.dart';

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
      MenuModel(icon: Icons.help, title: 'Usage Guide', page: UsageGuideWidget()),
      MenuModel(icon: Icons.schema, title: 'Structure', page: StructureWidget()),
      
    ],
  ),
  MenuModel(
    icon: Icons.handyman,
    title: 'Tools',
    subMenu: [
      MenuModel(icon: Icons.factory_sharp, title: 'Refinery', page: RefineryWidget()),
    ],
  ),
  if (current_user.status.value['corp_member'] == true)
  MenuModel(
    icon: Icons.person,
    title: 'Influence System',
    subMenu: [
      MenuModel(icon: Icons.military_tech, title: 'Personal Stats', page: InfPersonalStatsWidget()),
      // MenuModel(icon: Icons.send, title: 'Transfer', page: InfTransferWidget()),
      // MenuModel(icon: Icons.bar_chart, title: 'Auction', page: AuctionWidget()),
      // MenuModel(icon: Icons.military_tech, title: 'Ranks', page: RanksDocumentationWidget()),
      //MenuModel(icon: Icons.query_stats, title: 'Global Stats', page: InfGlobalStatsWidget()),
    ],
  ),
  if (current_user.status.value['is_admin'] == true)
  MenuModel(
    icon: Icons.admin_panel_settings,
    title: 'Admin',
    subMenu: [
      MenuModel(icon: Icons.account_circle, title: 'Users', page: UserManagerWidget()),
      MenuModel(icon: Icons.business, title: 'Departments', page: DepartmentManagerWidget()),
      MenuModel(icon: Icons.groups, title: 'Divisions', page: DivisionManagerWidget()),
      MenuModel(icon: Icons.assignment_ind, title: 'Roles', page: RoleManagerWidget()),
      MenuModel(icon: Icons.military_tech, title: 'Rank', page: RankManagerWidget()),
    ],
  ),
  //MenuModel(icon: Icons.history, title: 'Stats', page: InfluenceWidget()),
  MenuModel(
    icon: Icons.settings,
    title: 'Settings',
    subMenu: [
      // if (current_user.status.value['corp_member'] == true)
      // MenuModel(icon: Icons.manage_accounts, title: 'Weights', page: ProfileSettingsWidget()),
      // MenuModel(icon: Icons.security, title: 'Security', page: SecuritySettingsWidget()),
    ],
  ),
  MenuModel(icon: Icons.logout, title: 'SignOut', page: WelcomeWidget()),
];
