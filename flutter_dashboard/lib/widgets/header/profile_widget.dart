import 'package:flutter_dashboard/const/constant.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/influence_system/components/weights_chart_widget_stub.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/influence_system/components/influence_chart_widget.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/influence_system/components/lifetime_influence_chart_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/model/current_user.dart' as current_user;
import 'package:flutter_dashboard/model/influence_account.dart' as infAccount;
import 'package:flutter_dashboard/main.dart';
import 'package:flutter_dashboard/util/css_color.dart';
import 'package:flutter_dashboard/util/icon_helper.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class ProfileWidget extends StatefulWidget {
  const ProfileWidget({super.key});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  bool _isLoading = false;
  final secureStorage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _refreshProfile();
  }

  Future<void> _refreshProfile() async {
    setState(() {
      _isLoading = true;
    });

    try {
      print('Starting profile refresh...');
      
      // Check if we have tokens
      final accessToken = await secureStorage.read(key: "corp_access_pass");
      final refreshToken = await secureStorage.read(key: "corp_refresh_pass");
      print('Access token exists: ${accessToken != null}');
      print('Refresh token exists: ${refreshToken != null}');
      
      if (accessToken == null || refreshToken == null) {
        print('No authentication tokens found, redirecting to login');
        navigatorKey.currentState?.pushNamedAndRemoveUntil('/login', (route) => false);
        return;
      }

      await current_user.update();
      
      // Add debug output for profile data
      print('After current_user.update():');
      print('RSI Handle: ${current_user.rsiHandle.value}');
      print('RSI Moniker: ${current_user.rsiMoniker.value}');
      print('Profile Picture: ${current_user.profilePicture.value}');
      print('Status: ${current_user.status.value}');
      
      // Check status reactively with multiple possible field names
      final isCorpMember = current_user.status.value['corp_member'] == true || 
                          current_user.status.value['cORP_member'] == true ||
                          current_user.status.value['CORP_member'] == true ||
                          current_user.status.value['corp_member'] == 'true' ||
                          current_user.status.value['cORP_member'] == 'true' ||
                          current_user.status.value['CORP_member'] == 'true';
      
      print('Is corp member in refresh: $isCorpMember');
      
      if (isCorpMember) {
        await infAccount.update();
        print('Influence account updated');
        print('Profile data: ${infAccount.profile.value}');
        print('Stats data: ${infAccount.stats.value}');
      }
      print('Profile refresh completed successfully');
    } catch (e) {
      print('Error refreshing profile: $e');
      // If we get a 401 or authentication error, redirect to login
      if (e.toString().contains('401') || e.toString().contains('Unauthorized')) {
        print('Authentication error detected, redirecting to login');
        navigatorKey.currentState?.pushNamedAndRemoveUntil('/login', (route) => false);
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: cardBackgroundColor,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.refresh),
                        onPressed: () {
                          navigatorKey.currentState?.pushNamed('/dashboard');
                        },
                        tooltip: 'Reload Dashboard',
                      ),
                      IconButton(
                        icon: _isLoading 
                          ? SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : Icon(Icons.sync),
                        onPressed: _isLoading ? null : _refreshProfile,
                        tooltip: 'Refresh Profile',
                      ),
                    ],
                  ),
                ),
                ValueListenableBuilder(
                  valueListenable: current_user.profilePicture,
                  builder: (context, profilePictureValue, child) {
                    print('Profile picture value: $profilePictureValue');
                    return CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[800],
                      child: (profilePictureValue.isNotEmpty && 
                              profilePictureValue != "https://www.gravatar.com/avatar/2c7d99fe281ecd3bcd65ab915bac6dd5?s=250" &&
                              !profilePictureValue.contains('loading'))
                        ? ClipOval(
                            child: Image.network(
                              profilePictureValue,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                print('Error loading profile picture: $error');
                                return Icon(
                                  Icons.person,
                                  size: 50,
                                  color: Colors.grey[400],
                                );
                              },
                              loadingBuilder: (context, child, loadingProgress) {
                                if (loadingProgress == null) return child;
                                return Center(
                                  child: CircularProgressIndicator(
                                    value: loadingProgress.expectedTotalBytes != null
                                        ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                        : null,
                                    strokeWidth: 2,
                                  ),
                                );
                              },
                            ),
                          )
                        : Icon(
                            Icons.person,
                            size: 50,
                            color: Colors.grey[400],
                          ),
                    );
                  },
                ),
                SizedBox(height: 20),
                ValueListenableBuilder(
                  valueListenable: current_user.rsiHandle,
                  builder: (context, rsiHandleValue, child) {
                    print('RSI Handle value: $rsiHandleValue');
                    return Text(
                      (rsiHandleValue.isNotEmpty && rsiHandleValue != 'loading') ? rsiHandleValue : 'Loading...',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    );
                  },
                ),
                ValueListenableBuilder(
                  valueListenable: current_user.rsiMoniker,
                  builder: (context, rsiMonikerValue, child) {
                    print('RSI Moniker value: $rsiMonikerValue');
                    return Text(
                      (rsiMonikerValue.isNotEmpty && rsiMonikerValue != 'loading') ? rsiMonikerValue : 'Loading...',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    );
                  },
                ),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 10),
                ValueListenableBuilder(
                  valueListenable: current_user.status,
                  builder: (context, statusValue, child) {
                    // Debug: Print the actual status structure
                    print('Current user status: $statusValue');
                    print('Status keys: ${statusValue.keys.toList()}');
                    
                    // Check all possible field variations
                    statusValue.forEach((key, value) {
                      if (key.toLowerCase().contains('corp') || key.toLowerCase().contains('member')) {
                        print('Found potential corp field: $key = $value (${value.runtimeType})');
                      }
                    });
                    
                    // Check multiple possible field names and values
                    final isCorpMember = statusValue['corp_member'] == true || 
                                        statusValue['cORP_member'] == true ||
                                        statusValue['CORP_member'] == true ||
                                        statusValue['corp_member'] == 'true' ||
                                        statusValue['cORP_member'] == 'true' ||
                                        statusValue['CORP_member'] == 'true' ||
                                        statusValue['corporateer'] == true ||
                                        statusValue['is_corporateer'] == true ||
                                        statusValue['member'] == true ||
                                        statusValue['is_member'] == true ||
                                        statusValue['active'] == true;
                    
                    print('Is corp member: $isCorpMember');
                    
                    if (isCorpMember) {
                      return ValueListenableBuilder(
                          valueListenable: current_user.roles,
                          builder: (context, rolesValue, child) => Column(
                                children: [
                                  Text(
                                    'Roles',
                                    style: TextStyle(
                                        fontSize: 18, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                  if (rolesValue
                                      .where((role) => role['type'] == 'Leadership')
                                      .toList()
                                      .isNotEmpty) ...[
                                    Text(
                                      'Leadership',
                                      style: TextStyle(
                                          fontSize: 14, fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(height: 10),
                                    Wrap(
                                      spacing: 8.0,
                                      runSpacing: 4.0,
                                      children: [
                                        for (var role in rolesValue
                                            .where(
                                                (role) => role['type'] == 'Leadership')
                                              .toList()
                                              ..sort((a, b) {
                                              if (a['department'] != null && b['department'] != null) {
                                                return a['department']!.compareTo(b['department']!);
                                              } else if (a['department'] != null) {
                                                return -1;
                                              } else if (b['department'] != null) {
                                                return 1;
                                              } else {
                                                return 0;
                                              }
                                              }))
                                          Chip(
                                            avatar: Icon(
                                                icons[role['logo']] ?? Icons.error,
                                                color: role['color'] != null
                                                    ? cssColorToColor(role['color']!)
                                                    : Colors.grey),
                                            label: Text(role['title'] ?? 'Unknown'),
                                            shape: StadiumBorder(
                                              side: BorderSide(
                                                color: role['color'] != null
                                                    ? cssColorToColor(role['color']!)
                                                    : Colors.grey,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                  if (rolesValue
                                      .where((role) => role['type'] == 'Membership')
                                      .toList()
                                      .isNotEmpty) ...[
                                    Text(
                                      'Membership',
                                      style: TextStyle(
                                          fontSize: 14, fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(height: 10),
                                    Wrap(
                                      spacing: 8.0,
                                      runSpacing: 4.0,
                                      children: [
                                        for (var role in rolesValue
                                            .where(
                                                (role) => role['type'] == 'Membership')
                                            .toList()..sort((a, b) {
                                              if (a['department'] != null && b['department'] != null) {
                                                return a['department']!.compareTo(b['department']!);
                                              } else if (a['department'] != null) {
                                                return -1;
                                              } else if (b['department'] != null) {
                                                return 1;
                                              } else {
                                                return 0;
                                              }
                                              }))
                                          Chip(
                                            avatar: Icon(
                                                icons[role['logo']] ?? Icons.error,
                                                color: role['color'] != null
                                                    ? cssColorToColor(role['color']!)
                                                    : Colors.grey),
                                            label: Text(role['title'] ?? 'Unknown'),
                                            shape: StadiumBorder(
                                              side: BorderSide(
                                                color: role['color'] != null
                                                    ? cssColorToColor(role['color']!)
                                                    : Colors.grey,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    SizedBox(height: 10),
                                  ],
                                  if (rolesValue.where((role) => role['type'] == 'Other').toList().isNotEmpty) ...[
                                    Text(
                                      'Others',
                                      style: TextStyle(
                                          fontSize: 14, fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(height: 10),
                                    Wrap(
                                      spacing: 8.0,
                                      runSpacing: 4.0,
                                      children: [
                                        for (var role in rolesValue.where((role) => role['type'] == 'Other').toList()..sort((a, b) {
                                              if (a['department'] != null && b['department'] != null) {
                                                return a['department']!.compareTo(b['department']!);
                                              } else if (a['department'] != null) {
                                                return -1;
                                              } else if (b['department'] != null) {
                                                return 1;
                                              } else {
                                                return 0;
                                              }
                                              }))
                                          Chip(
                                            avatar: Icon(
                                                icons[role['logo']] ?? Icons.error,
                                                color: role['color'] != null
                                                    ? cssColorToColor(role['color']!)
                                                    : Colors.grey),
                                            label: Text(role['title'] ?? 'Unknown'),
                                            shape: StadiumBorder(
                                              side: BorderSide(
                                                color: role['color'] != null
                                                    ? cssColorToColor(role['color']!)
                                                    : Colors.grey,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ]
                                ],
                              ));
                    } else {
                      return Text(
                        'Must be a CORP member to see roles',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      );
                    }
                  },
                ),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 20),
                ValueListenableBuilder(
                  valueListenable: current_user.status,
                  builder: (context, statusValue, child) {
                    final isCorpMember = statusValue['corp_member'] == true || 
                                        statusValue['cORP_member'] == true ||
                                        statusValue['CORP_member'] == true ||
                                        statusValue['corp_member'] == 'true' ||
                                        statusValue['cORP_member'] == 'true' ||
                                        statusValue['CORP_member'] == 'true';
                    
                    if (isCorpMember) {
                      return ValueListenableBuilder(
                          valueListenable: infAccount.profile,
                          builder: (context, value, child) {
                            print('Influence account profile data: $value');
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(8.0),
                                ),
                                color: backgroundColor,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "Rank",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          value['rank']?.toString() ?? 'Unknown',
                                          style: const TextStyle(fontSize: 13),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Text(
                                          "Tribute",
                                          style: const TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const SizedBox(height: 2),
                                        Text(
                                          (value['tribute'] ?? 0).toString(),
                                          style: const TextStyle(fontSize: 13),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ));
                          });
                    } else {
                      return Text(
                        'Must be a CORP member to view Influence Account',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      );
                    }
                  },
                ),
                SizedBox(height: 20),
                Divider(),
                SizedBox(height: 10),
                ValueListenableBuilder(
                  valueListenable: current_user.status,
                  builder: (context, statusValue, child) {
                    final isCorpMember = statusValue['corp_member'] == true || 
                                        statusValue['cORP_member'] == true ||
                                        statusValue['CORP_member'] == true ||
                                        statusValue['corp_member'] == 'true' ||
                                        statusValue['cORP_member'] == 'true' ||
                                        statusValue['CORP_member'] == 'true';
                    
                    if (isCorpMember) {
                      return ValueListenableBuilder(
                        valueListenable: infAccount.stats,
                        builder: (context, value, child) {
                          print('Influence account stats data: $value');
                          final departments = (value['departments'] as List<dynamic>?) ?? [];
                          print('Departments: $departments');
                          
                          return Wrap(
                            spacing: 8.0,
                            runSpacing: 4.0,
                            children: <Widget>[
                              for (var department in departments)
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 16,
                                      height: 16,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.rectangle,
                                        color: department['color'] != null
                                            ? cssColorToColor(department['color']!)
                                            : Colors.grey,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      department['departmentTitle'] ?? "Unknown",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                            ],
                          );
                        },
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
                SizedBox(height: 20),
                ValueListenableBuilder(
                  valueListenable: current_user.status,
                  builder: (context, statusValue, child) {
                    final isCorpMember = statusValue['corp_member'] == true || 
                                        statusValue['cORP_member'] == true ||
                                        statusValue['CORP_member'] == true ||
                                        statusValue['corp_member'] == 'true' ||
                                        statusValue['cORP_member'] == 'true' ||
                                        statusValue['CORP_member'] == 'true';
                    
                    if (isCorpMember) {
                      return Column(
                        children: [
                          Divider(),
                          SizedBox(height: 20),
                          SizedBox(
                              height: 200,
                              child: InfluenceChartWidget()),
                          SizedBox(height: 10),
                          Text(
                            'Influence',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 20),
                          Divider(),
                          SizedBox(height: 20),
                          SizedBox(
                              height: 200,
                              child: WeightsChartWidget()),
                          SizedBox(height: 10),
                          Text(
                            'Weights',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          SizedBox(height: 20),
                          Divider(),
                          SizedBox(height: 20),
                          SizedBox(
                              height: 200,
                              child: LifetimeInfluenceChartWidget()),
                          SizedBox(height: 10),
                          Text(
                            'Lifetime Influence',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ],
                      );
                    } else {
                      return SizedBox.shrink();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
