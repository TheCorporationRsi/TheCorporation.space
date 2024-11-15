import 'package:flutter_dashboard/const/constant.dart';
import 'package:flutter_dashboard/data/side_menu_data.dart';
import 'package:flutter/material.dart';

class SideMenuWidget extends StatefulWidget {
  final Function(int, {int? subIndex}) onMenuItemSelected;

  const SideMenuWidget({super.key, required this.onMenuItemSelected});

  @override
  State<SideMenuWidget> createState() => _SideMenuWidgetState();
}

class _SideMenuWidgetState extends State<SideMenuWidget> with TickerProviderStateMixin {
  int selectedIndex = 0;
  int? selectedSubIndex;
  int? hoveredIndex;
  int? hoveredSubIndex;

  @override
  Widget build(BuildContext context) {
    final data = SideMenuData();

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
              itemCount: data.menu.length,
              itemBuilder: (context, index) => buildMenuEntry(data, index),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMenuEntry(SideMenuData data, int index) {
    final isSelected = selectedIndex == index;
    final isHovered = hoveredIndex == index;
    final menu = data.menu[index];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MouseRegion(
          onEnter: (_) => setState(() => hoveredIndex = index),
          onExit: (_) => setState(() => hoveredIndex = null),
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
                selectedSubIndex = null;
              });
              if (menu.subMenu != null && menu.subMenu!.isNotEmpty) {
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
                color: isSelected ? primaryColor : isHovered ? Colors.grey[800] : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Icon(menu.icon, color: isSelected ? secondaryColor : Colors.white),
                  const SizedBox(width: 10),
                  Text(
                    menu.title,
                    style: TextStyle(color: isSelected ? secondaryColor : Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
        if (menu.subMenu != null)
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            child: isSelected
                ? Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Column(
                      children: menu.subMenu!.map((subMenu) {
                        final subIndex = menu.subMenu!.indexOf(subMenu);
                        final isSubSelected = selectedSubIndex == subIndex;
                        final isSubHovered = hoveredSubIndex == subIndex;

                        return MouseRegion(
                          onEnter: (_) => setState(() => hoveredSubIndex = subIndex),
                          onExit: (_) => setState(() => hoveredSubIndex = null),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedSubIndex = subIndex;
                              });
                              widget.onMenuItemSelected(index, subIndex: subIndex);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                color: isSubSelected ? primaryColor : isSubHovered ? Colors.grey[800] : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Icon(Icons.subdirectory_arrow_right, color: isSubSelected ? secondaryColor : Colors.white), // Prefix icon
                                  const SizedBox(width: 10),
                                  Icon(subMenu.icon, color: isSubSelected ? secondaryColor : Colors.white),
                                  const SizedBox(width: 10),
                                  Text(
                                    subMenu.title,
                                    style: TextStyle(color: isSubSelected ? secondaryColor : Colors.white),
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
