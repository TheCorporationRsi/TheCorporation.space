import 'package:flutter_dashboard/const/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/model/current_user.dart' as current_user;
import 'package:flutter_dashboard/model/dashboard_pages.dart';


class SideMenuWidget extends StatefulWidget {
  const SideMenuWidget({super.key});

  @override
  State<SideMenuWidget> createState() => _SideMenuWidgetState();
}



class _SideMenuWidgetState extends State<SideMenuWidget> {
  int? hoveredIndex;
  int? hoveredSubIndex;

  @override
  Widget build(BuildContext context) {

    return  ValueListenableBuilder(
        valueListenable: selectedIndex,
        builder: (context, value, child) =>Container(
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
    ));
  }

  Widget buildMenuEntry(int index) {
    final isSelected = selectedIndex.value.$1 == index;
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
                selectedIndex.value = (index, 0);
              });
              if (menuItem.subMenu != null && menuItem.subMenu!.isNotEmpty) {
                setState(() {
                  selectedIndex.value = (index, 0);
                });
              } else {
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
                        final isSubSelected = selectedIndex.value.$2 == subIndex;
                        final isSubHovered = hoveredSubIndex == subIndex;

                        return MouseRegion(
                          onEnter: (_) =>
                              setState(() => hoveredSubIndex = subIndex),
                          onExit: (_) => setState(() => hoveredSubIndex = null),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex.value = (index, subIndex);
                              });
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
