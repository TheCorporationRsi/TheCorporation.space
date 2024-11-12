import 'package:flutter_dashboard/util/responsive.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/dashboard_widget.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/influence_widget.dart';
import 'package:flutter_dashboard/widgets/header/side_menu_widget.dart';
import 'package:flutter_dashboard/widgets/header/summary_widget.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  int? selectedSubIndex;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;
  late Widget currentPage;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _offsetAnimation = Tween<Offset>(
      begin: const Offset(0.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    currentPage = getSelectedPage();
    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void onMenuItemSelected(int index, {int? subIndex}) {
    print('Menu item selected: index=$index, subIndex=$subIndex');
    if (index != selectedIndex || subIndex != selectedSubIndex) {
      _controller.reverse().then((_) {
        setState(() {
          selectedIndex = index;
          selectedSubIndex = subIndex;
          currentPage = getSelectedPage();
          _controller.forward();
        });
      });
    }
  }

  Widget getSelectedPage() {
    print('Selected Index: $selectedIndex, Selected SubIndex: $selectedSubIndex');
    
    if (selectedSubIndex != null) {
      switch (selectedIndex) {
        case 0:
          switch (selectedSubIndex) {
            case 0:
              return const DashboardWidget();
            case 1:
              return const InfluenceWidget();
          }
          break;
        case 1:
          switch (selectedSubIndex) {
            case 0:
              return const DashboardWidget();
            case 1:
              return const InfluenceWidget();
          }
          break;
      }
    } else {
      switch (selectedIndex) {
        case 0:
          return const DashboardWidget();
        case 1:
          return const DashboardWidget();
        case 2:
          return const InfluenceWidget();
        case 3:
          return const DashboardWidget();
        case 4:
          return const DashboardWidget();
        case 5:
          return const InfluenceWidget();
      }
    }
    return const DashboardWidget();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      drawer: !isDesktop
          ? SizedBox(
              width: 250,
              child: SideMenuWidget(onMenuItemSelected: onMenuItemSelected),
            )
          : null,
      endDrawer: Responsive.isMobile(context)
          ? SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: const SummaryWidget(),
            )
          : null,
      body: SafeArea(
        child: Row(
          children: [
            if (isDesktop)
              Expanded(
                flex: 2,
                child: SizedBox(
                  child: SideMenuWidget(onMenuItemSelected: onMenuItemSelected),
                ),
              ),
            Expanded(
              flex: 7,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _offsetAnimation,
                  child: currentPage,
                ),
              ),
            ),
            if (isDesktop)
              Expanded(
                flex: 3,
                child: const SummaryWidget(),
              ),
          ],
        ),
      ),
    );
  }
}
