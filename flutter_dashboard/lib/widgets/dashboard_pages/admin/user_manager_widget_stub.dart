import 'package:flutter/material.dart';
import 'package:flutter_dashboard/const/constant.dart';
import 'package:flutter_dashboard/services/service_locator.dart';

class UserManagerWidget extends StatefulWidget {
  const UserManagerWidget({super.key});

  @override
  State<UserManagerWidget> createState() => _UserManagerWidgetState();
}

class _UserManagerWidgetState extends State<UserManagerWidget> {
  List<Map<String, dynamic>> _users = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  Future<void> _loadUsers() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final apiService = ServiceLocator().corpApiService;
      final response = await apiService.getUsers();
      
      if (response.data != null) {
        setState(() {
          _users = List<Map<String, dynamic>>.from(response.data);
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = 'No data received from server';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Failed to load users: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Card(
        color: cardBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'User Manager',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.refresh, color: primaryColor),
                    onPressed: _loadUsers,
                    tooltip: 'Refresh users',
                  ),
                ],
              ),
              SizedBox(height: 20),
              if (_isLoading)
                Center(
                  child: Column(
                    children: [
                      CircularProgressIndicator(color: primaryColor),
                      SizedBox(height: 16),
                      Text('Loading users...', style: TextStyle(color: Colors.grey)),
                    ],
                  ),
                )
              else if (_error != null)
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.red.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.red),
                  ),
                  child: Column(
                    children: [
                      Icon(Icons.error, color: Colors.red, size: 48),
                      SizedBox(height: 12),
                      Text(
                        'Error Loading Users',
                        style: TextStyle(color: Colors.red, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Text(
                        _error!,
                        style: TextStyle(color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              else
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Header row
                        Container(
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            children: [
                              Expanded(flex: 2, child: Text('Username', style: TextStyle(fontWeight: FontWeight.bold))),
                              Expanded(flex: 2, child: Text('RSI Handle', style: TextStyle(fontWeight: FontWeight.bold))),
                              Expanded(flex: 1, child: Text('Member', style: TextStyle(fontWeight: FontWeight.bold))),
                              Expanded(flex: 1, child: Text('Admin', style: TextStyle(fontWeight: FontWeight.bold))),
                              Expanded(flex: 1, child: Text('Verified', style: TextStyle(fontWeight: FontWeight.bold))),
                            ],
                          ),
                        ),
                        SizedBox(height: 8),
                        // User rows
                        ...(_users.map((user) => Container(
                          margin: EdgeInsets.only(bottom: 4),
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                          decoration: BoxDecoration(
                            color: backgroundColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey.withOpacity(0.3)),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 2, 
                                child: Text(
                                  user['username'] ?? 'N/A',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Expanded(
                                flex: 2, 
                                child: Text(
                                  user['RSI_handle'] ?? 'N/A',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Expanded(
                                flex: 1, 
                                child: Icon(
                                  user['corp_member'] == true ? Icons.check_circle : Icons.cancel,
                                  color: user['corp_member'] == true ? Colors.green : Colors.red,
                                  size: 20,
                                ),
                              ),
                              Expanded(
                                flex: 1, 
                                child: Icon(
                                  user['is_admin'] == true ? Icons.admin_panel_settings : Icons.person,
                                  color: user['is_admin'] == true ? Colors.orange : Colors.grey,
                                  size: 20,
                                ),
                              ),
                              Expanded(
                                flex: 1, 
                                child: Icon(
                                  user['RSI_verified'] == true ? Icons.verified : Icons.warning,
                                  color: user['RSI_verified'] == true ? Colors.blue : Colors.orange,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        )).toList()),
                        if (_users.isEmpty)
                          Container(
                            padding: EdgeInsets.all(32),
                            child: Column(
                              children: [
                                Icon(Icons.people_outline, color: Colors.grey, size: 64),
                                SizedBox(height: 16),
                                Text(
                                  'No users found',
                                  style: TextStyle(color: Colors.grey, fontSize: 18),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
          ),
        ),
      ),
    );
  }
}
