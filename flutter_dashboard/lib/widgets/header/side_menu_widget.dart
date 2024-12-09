import 'package:flutter_dashboard/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/model/menu_model.dart';
import 'package:flutter_dashboard/model/current_user.dart' as current_user;


class SideMenuWidget extends StatefulWidget {
  final Function(int, {int? subIndex}) onMenuItemSelected;
  const SideMenuWidget({super.key, required this.onMenuItemSelected});

  @override
  State<SideMenuWidget> createState() => _SideMenuWidgetState();
}


final menu = <MenuModel>[
  MenuModel(
    icon: Icons.home,
    title: 'Home',
    subMenu: [
      MenuModel(icon: Icons.flag, title: 'Welcome'),
      MenuModel(icon: Icons.schema, title: 'Structure'),
      
    ],
  ),
  if (current_user.status.value.cORPMember!)
  MenuModel(
    icon: Icons.person,
    title: 'Influence System',
    subMenu: [
      MenuModel(icon: Icons.dashboard, title: 'Status'),
      MenuModel(icon: Icons.send, title: 'Transfer'),
      MenuModel(icon: Icons.military_tech, title: 'Personnal Stats'),
      MenuModel(icon: Icons.query_stats, title: 'Global Stats'),
    ],
  ),
  if (current_user.status.value.isAdmin!)
  MenuModel(
    icon: Icons.person,
    title: 'Admin',
    subMenu: [
      MenuModel(icon: Icons.account_circle, title: 'Users'),
      MenuModel(icon: Icons.business, title: 'Departments'),
      MenuModel(icon: Icons.groups, title: 'Divisions'),
      MenuModel(icon: Icons.assignment_ind, title: 'Roles'),
    ],
  ),
  MenuModel(icon: Icons.history, title: 'Stats'),
  MenuModel(
    icon: Icons.person,
    title: 'Settings',
    subMenu: [
      MenuModel(icon: Icons.manage_accounts, title: 'Profile'),
      MenuModel(icon: Icons.security, title: 'Security'),
    ],
  ),
  MenuModel(icon: Icons.logout, title: 'SignOut'),
];

class _SideMenuWidgetState extends State<SideMenuWidget> {
  int selectedIndex = 0;
  int? selectedSubIndex = 0;
  int? hoveredIndex;
  int? hoveredSubIndex;

  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      color: cardBackgroundColor,
      child: Column(
        children: [
          Image.asset(
            'assets/logo/corp_banner.png',
            width: double.infinity, // Take up the whole width
            height: 80, // Reduce the height
            fit: BoxFit.contain,
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: menu.length,
              itemBuilder: (context, index) {
                try {
                  return buildMenuEntry(index);
                } catch (e) {
                  print('Error building menu entry at index $index: $e');
                  return SizedBox.shrink(); // Return an empty widget on error
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuEntry(int index) {
    final isSelected = selectedIndex == index;
    final isHovered = hoveredIndex == index;
    final menuItem = menu[index];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MouseRegion(
          onEnter: (_) => setState(() => hoveredIndex = index),
          onExit: (_) => setState(() => hoveredIndex = null),
          child: GestureDetector(
            onTap: () {
              if (menuItem.title == "SignOut"){
                current_user.logout();
              }
              setState(() {
                selectedIndex = index;
                selectedSubIndex = null;
              });
              if (menuItem.subMenu != null && menuItem.subMenu!.isNotEmpty) {
                setState(() {
                  selectedSubIndex = 0;
                });
                widget.onMenuItemSelected(index, subIndex: 0);
              } else {
                widget.onMenuItemSelected(index);
              }
            },
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: isSelected
                    ? primaryColor
                    : isHovered
                        ? Colors.grey[800]
                        : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(menuItem.icon,
                      color: isSelected ? secondaryColor : Colors.white),
                  const SizedBox(width: 10),
                  Text(
                    menuItem.title,
                    style: TextStyle(
                        color: isSelected ? secondaryColor : Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (menuItem.subMenu != null)
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: isSelected
                ? Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      children: menuItem.subMenu!.map((subMenu) {
                        final subIndex = menuItem.subMenu!.indexOf(subMenu);
                        final isSubSelected = selectedSubIndex == subIndex;
                        final isSubHovered = hoveredSubIndex == subIndex;

                        return MouseRegion(
                          onEnter: (_) =>
                              setState(() => hoveredSubIndex = subIndex),
                          onExit: (_) => setState(() => hoveredSubIndex = null),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedSubIndex = subIndex;
                              });
                              widget.onMenuItemSelected(index,
                                  subIndex: subIndex);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                color: isSubSelected
                                    ? primaryColor
                                    : isSubHovered
                                        ? Colors.grey[800]
                                        : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Icon(Icons.subdirectory_arrow_right,
                                      color: isSubSelected
                                          ? secondaryColor
                                          : Colors.white), // Prefix icon
                                  const SizedBox(width: 10),
                                  Icon(subMenu.icon,
                                      color: isSubSelected
                                          ? secondaryColor
                                          : Colors.white),
                                  const SizedBox(width: 10),
                                  Text(
                                    subMenu.title,
                                    style: TextStyle(
                                        color: isSubSelected
                                            ? secondaryColor
                                            : Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  )
                : Container(),
          ),
      ],
    );
  }
}
