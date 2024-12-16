import 'package:flutter/material.dart';
import 'package:flutter_dashboard/const/constant.dart';
import 'package:flutter_dashboard/util/responsive.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/dashboard_widget.dart';
import 'package:flutter_dashboard/widgets/header/profile_widget.dart';
import 'package:flutter_dashboard/widgets/header/side_menu_widget.dart';

import 'package:corp_api/corp_api.dart';
import 'package:flutter_dashboard/util/restrictions.dart';
import 'package:flutter_dashboard/model/current_user.dart' as current_user;
import 'package:flutter_dashboard/model/influence_account.dart' as infAccount;
import 'package:flutter_dashboard/model/information.dart' as information;

import 'package:flutter_dashboard/model/dashboard_pages.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  bool _isLoading = true;
  late AnimationController _controller;
  late Animation<Offset> _offsetAnimation;
  late Animation<double> _fadeAnimation;

  final GlobalKey<ScaffoldState> _headerScaffoldKey =
      GlobalKey<ScaffoldState>();
  final ValueNotifier<bool> _isSideMenuVisible = ValueNotifier<bool>(true);
  final ValueNotifier<bool> _isRightSideMenuVisible = ValueNotifier<bool>(true);

  Future<void> _initialize() async {
    await checkSecurityLevel(context, 'rsiVerified');
    await current_user.update();
    if (current_user.status.value.cORPMember!) {
      await infAccount.update();
    }
    await information.update();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _initialize();

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
    _controller.forward(from: 0.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }



  Widget getSelectedPage() {
    print(
        'Selected Index: ${selectedIndex.value.$1}, Selected SubIndex: ${selectedIndex.value.$1}');
    if (menu[selectedIndex.value.$1].page == null) {
      return menu[selectedIndex.value.$1].subMenu![selectedIndex.value.$2!].page
          as Widget;
    } else {
      return menu[selectedIndex.value.$1].page as Widget;
    }
  }

  void toggleSideMenu() {
    _isSideMenuVisible.value = !_isSideMenuVisible.value;
  }

  void toggleRightSideMenu() {
    _isRightSideMenuVisible.value = !_isRightSideMenuVisible.value;
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final isDesktop = Responsive.isDesktop(context);
    return Scaffold(
      key: _headerScaffoldKey,
      drawer: Drawer(
        child: SizedBox(
          width: 250,
          child: SideMenuWidget(),
        ),
      ),
      body: SafeArea(
        child: Row(
          children: [
            if (isDesktop)
              ValueListenableBuilder<bool>(
                valueListenable: _isSideMenuVisible,
                builder: (context, isVisible, child) {
                  return isVisible
                      ? Expanded(
                          flex: 3,
                          child: SideMenuWidget(),
                        )
                      : SizedBox.shrink();
                },
              ),
            ValueListenableBuilder(
                valueListenable: selectedIndex,
                
                builder: (context, value, child) => Expanded(
                      flex: 7,
                      child: Scaffold(
                        appBar: AppBar(
                          surfaceTintColor: cardBackgroundColor,
                          backgroundColor: backgroundColor,
                          foregroundColor: Colors.white,
                          leadingWidth: _isSideMenuVisible.value ? 110 : 20,
                          leading: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Row(children: [
                              if (!isDesktop)
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Image.asset(
                                    'assets/logo/corp_logo.png', // Replace with your logo asset path
                                    height: 40,
                                    width:
                                        40, // Add width to ensure the logo is not smaller
                                    fit: BoxFit
                                        .cover, // Ensure the logo fits within the given dimensions
                                  ),
                                ),
                              ValueListenableBuilder<bool>(
                                valueListenable: _isSideMenuVisible,
                                builder: (context, isVisible, child) {
                                  return isVisible
                                      ? SizedBox.shrink()
                                      : Padding(
                                          padding:
                                              const EdgeInsets.only(right: 20),
                                          child: Image.asset(
                                            'assets/logo/corp_logo.png', // Replace with your logo asset path
                                            height: 40,
                                            width:
                                                40, // Add width to ensure the logo is not smaller
                                            fit: BoxFit
                                                .cover, // Ensure the logo fits within the given dimensions
                                          ),
                                        );
                                },
                              ),
                              if (!isDesktop)
                                InkWell(
                                  onTap: () => _headerScaffoldKey.currentState
                                      ?.openDrawer(),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 20, bottom: 20),
                                    child: Icon(
                                      Icons.menu,
                                      color: Colors.grey,
                                      size: 25,
                                    ),
                                  ),
                                )
                              else
                                InkWell(
                                  onTap: toggleSideMenu,
                                  child: ValueListenableBuilder<bool>(
                                    valueListenable: _isSideMenuVisible,
                                    builder: (context, isVisible, child) {
                                      return Icon(
                                        isVisible
                                            ? Icons.arrow_back
                                            : Icons.menu,
                                        color: Colors.white,
                                        size: 25,
                                      );
                                    },
                                  ),
                                ),
                            ]),
                          ),
                          title: Padding(
                            padding: const EdgeInsets.only(top: 20, bottom: 20),
                            child: Text(menu[selectedIndex.value.$1].subMenu?[selectedIndex.value.$2]?.title ?? menu[selectedIndex.value.$1].title,
                            ),
                          ),
                          actions: [
                            if (!isDesktop)
                              Padding(
                                padding: const EdgeInsets.all(
                                    20), // Adjust the padding as needed
                                child: InkWell(
                                  onTap: () => _headerScaffoldKey.currentState
                                      ?.openEndDrawer(),
                                  child: Icon(
                                    Icons.account_circle,
                                    color: Colors.white,
                                    size: 25,
                                  ),
                                ),
                              )
                            else
                              Padding(
                                padding: const EdgeInsets.all(
                                    20), // Adjust the padding as needed
                                child: InkWell(
                                  onTap: toggleRightSideMenu,
                                  child: ValueListenableBuilder<bool>(
                                    valueListenable: _isRightSideMenuVisible,
                                    builder: (context, isVisible, child) {
                                      return Icon(
                                        isVisible
                                            ? Icons.arrow_forward
                                            : Icons.account_circle,
                                        color: Colors.white,
                                        size: 25,
                                      );
                                    },
                                  ),
                                ),
                              ),
                          ],
                        ),
                        body: FadeTransition(
                          opacity: _fadeAnimation,
                          child: getSelectedPage(),
                        ),
                      ),
                    )),
            if (isDesktop)
              ValueListenableBuilder<bool>(
                valueListenable: _isRightSideMenuVisible,
                builder: (context, isVisible, child) {
                  return isVisible
                      ? Expanded(
                          flex: 3,
                          child: ProfileWidget(),
                        )
                      : SizedBox.shrink();
                },
              ),
          ],
        ),
      ),
      endDrawer: Drawer(
        child: SizedBox(
          width: 250,
          child: ProfileWidget(),
        ),
      ),
    );
  }
}
