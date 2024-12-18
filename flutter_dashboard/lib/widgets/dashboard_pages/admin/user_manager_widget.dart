import 'package:corp_api/corp_api.dart';
import 'package:flutter_dashboard/model/current_user.dart';
import 'package:flutter_dashboard/util/responsive.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/influence_system/components/influence_details_card.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/components/line_chart_card.dart';
import 'package:flutter/material.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter_dashboard/const/constant.dart';
import 'package:flutter_dashboard/main.dart';

class UserManagerWidget extends StatefulWidget {
  const UserManagerWidget({super.key});

  @override
  _UserManagerWidgetState createState() => _UserManagerWidgetState();
}

class _UserManagerWidgetState extends State<UserManagerWidget> {
  BuiltList<GetUsers200ResponseInner> users =
      BuiltList<GetUsers200ResponseInner>();
  BuiltList<GetRoles200ResponseInner> roles =
      BuiltList<GetRoles200ResponseInner>();
  BuiltList<GetUsers200ResponseInner> filteredUsers =
      BuiltList<GetUsers200ResponseInner>();
  Map<int, bool> _dropdownOpen = {};

  bool _isLoading = true;
  final corpSecurityClient = corpApi.getSecurityApi();
  String _searchQuery = '';
  String _filter = 'All';

  Future<void> _initialize() async {
    final headers = await getAuthHeader();
    try {
      final response = await corpSecurityClient.getUsers(headers: headers);
      if (response.data != null) {
        users = response.data ?? users;
        _applySearchAndFilter();
      }
    } catch (error) {
      print(error);
    }
    try {
      final response = await corpStructureClient.getRoles(headers: headers);
      if (response.data != null) {
        roles = response.data ?? roles;
      }
    } catch (error) {
      print(error);
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _applySearchAndFilter() {
    setState(() {
      filteredUsers = users.where((user) {
        final matchesSearch = user.rSIHandle
            .toString()
            .toLowerCase()
            .contains(_searchQuery.toLowerCase());
        final matchesFilter = _filter == 'All' ||
            (_filter == 'Verified' && user.rSIConfirmed!) ||
            (_filter == 'CORP' && user.cORPConfirmed!);
        return matchesSearch && matchesFilter;
      }).toBuiltList();
    });
  }

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        color: cardBackgroundColor,
        child: CircularProgressIndicator(),
      );
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        child: Column(
          children: [
            SizedBox(height: 10),
            _buildFilterAndSearchSection(),
            SizedBox(height: 10),
            _buildUserList(),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterAndSearchSection() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search users...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onChanged: (value) {
              _searchQuery = value;
              _applySearchAndFilter();
            },
          ),
        ),
        SizedBox(width: 10),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: DropdownButton<String>(
            hint: Text('Filter by'),
            value: _filter,
            items: <String>['Verified', 'CORP', 'All'].map((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                _filter = newValue;
                _applySearchAndFilter();
              }
            },
          ),
        ),
        IconButton(
          icon: Icon(Icons.refresh),
          onPressed: () {
            setState(() {
              _isLoading = true;
            });
            _initialize();
          },
        ),
      ],
    );
  }

  Widget _buildUserList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: filteredUsers.length,
      itemBuilder: (context, index) {
        final user = filteredUsers[index];
        return _buildUserItem(user);
      },
    );
  }

  Widget _buildUserItem(GetUsers200ResponseInner user) {
    int userIndex = users.indexOf(user);
    _dropdownOpen.putIfAbsent(userIndex, () => false);
    return Card(
      color: cardBackgroundColor,
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(user.picture.toString()),
            ),
            title: Text(user.rSIHandle.toString()),
            subtitle: Row(
              children: [
                if (user.rSIConfirmed!)
                  Icon(Icons.verified, color: Colors.blue, size: 16),
                if (user.cORPConfirmed!)
                  Icon(Icons.business, color: Colors.green, size: 16),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (user.rSIConfirmed == false)
                IconButton(
                  icon: Icon(Icons.verified, color: Colors.blue),
                  onPressed: () {
                    if (!user.rSIConfirmed!) {
                      _showVerifyDialog(user);
                    }
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _showDeleteDialog(user);
                  },
                ),
                IconButton(
                  icon: Icon(_dropdownOpen[userIndex] == true
                      ? Icons.arrow_drop_up
                      : Icons.more_vert),
                  onPressed: () {
                    setState(() {
                      _dropdownOpen[userIndex] = !_dropdownOpen[userIndex]!;
                    });
                  },
                ),
              ],
            ),
          ),
          if (_dropdownOpen[userIndex] == true) _buildDropdownContent(user),
        ],
      ),
    );
  }

  void _showDeleteDialog(GetUsers200ResponseInner user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String confirmation = '';
        return AlertDialog(
          backgroundColor: cardBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Text(
            'Deleting ${user.rSIHandle.toString()}',
            style: TextStyle(
              color: primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            onChanged: (value) {
              confirmation = value;
            },
            decoration: InputDecoration(hintText: "Enter handle to delete"),
            keyboardType: TextInputType.number,
          ),
          actions: [
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.red),
                padding: WidgetStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              onPressed: () {
                if (confirmation == user.rSIHandle) {
                  // Replace '1234' with the actual pincode logic
                  _deleteUser(user);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Username does not match'),
                      backgroundColor: Colors.red,
                    )

                  );
                }
              },
              child: Text(
                'Delete',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _deleteUser(GetUsers200ResponseInner user) async {

    final headers = await getAuthHeader();

    try {
      final response = await corpSecurityClient.deleteUser(
          headers: headers, username: user.rSIHandle.toString());
      
      if (response.data!.msg == "User deleted") {
        setState(() {
          _isLoading = true;
        });
        _initialize();
      }
      
      _applySearchAndFilter();
    } catch (error) {
      print(error);
    }
  }

  Widget _buildDropdownContent(GetUsers200ResponseInner user) {
    GetUser200Response full_user = GetUser200Response();

    void _getFullUser() async {
      final headers = await getAuthHeader();

      try {
        final response = await corpSecurityClient.getUser(
            headers: headers, username: user.rSIHandle.toString());

        full_user = response.data ?? full_user;
      } catch (error) {
        print(error);
      }
    }
    _getFullUser();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow('Security level', user.securityLevel.toString()),
          _buildDetailRow('Disabled', user.disabled.toString()),
          // Add more details as needed
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              _showAddRoleDialog(full_user);
            },
            child: Text('Add Role'),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              _showRemoveRoleDialog(full_user);
            },
            child: Text('Remove Role'),
          ),
        ],
      ),
    );
  }

  void _showAddRoleDialog(GetUser200Response user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String? selectedRole;
        List<String> userRoles = user.roles!.map((role) => role.title.toString()).toList();
        List<GetRoles200ResponseInner> availableRoles = roles.where((role) => !userRoles.contains(role.title.toString())).toList();

        return AlertDialog(
          backgroundColor: cardBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Text(
            'Add Role to ${user.rSIHandle.toString()}',
            style: TextStyle(
              color: primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: DropdownButtonFormField<String>(
            hint: Text('Select Role'),
            value: selectedRole,
            items: availableRoles.map((GetRoles200ResponseInner role) {
              return DropdownMenuItem<String>(
                value: role.title.toString(),
                child: Text(role.title.toString()),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedRole = newValue;
              });
            },
          ),
          actions: [
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              onPressed: () {
                if (selectedRole != null) {
                  _addRoleToUser(user, selectedRole!);
                  Navigator.of(context).pop();
                } else {
                  // Show error message or handle no role selected
                }
              },
              child: Text(
                'Add',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _addRoleToUser(GetUser200Response user, String role) async {
    final headers = await getAuthHeader();

    final AddUserRoleRequest addUserRoleRequest = AddUserRoleRequest((b) => b
      ..roleTitle = role
      ..rsiHandle = user.rSIHandle);

    try {
      final response = await corpStructureClient.addUserRole(
          headers: headers, addUserRoleRequest: addUserRoleRequest);

      if (response.data!.msg == "Role added") {
        setState(() {
          _isLoading = true;
        });
        _initialize();
      }

      _applySearchAndFilter();
    } catch (error) {
      print(error);
    }
  }

  void _showRemoveRoleDialog(GetUser200Response user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String? selectedRole;


        return AlertDialog(
          backgroundColor: cardBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Text(
            'Remove Role from ${user.rSIHandle.toString()}',
            style: TextStyle(
              color: primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: DropdownButtonFormField<String>(
            hint: Text('Select Role'),
            value: selectedRole,
            items: user.roles!.map<DropdownMenuItem<String>>((GetUser200ResponseRolesInner role) {
              return DropdownMenuItem<String>(
                value: role.title.toString(),
                child: Text(role.title.toString()),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                selectedRole = newValue;
              });
            },
          ),
          actions: [
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
                padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              onPressed: () {
                if (selectedRole != null) {
                  _removeRoleFromUser(user, selectedRole!);
                  Navigator.of(context).pop();
                } else {
                  // Show error message or handle no role selected
                }
              },
              child: Text(
                'Remove',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _removeRoleFromUser(GetUser200Response user, String role) async {
    final headers = await getAuthHeader();

    final AddUserRoleRequest removeUserRoleRequest = AddUserRoleRequest((b) => b
      ..roleTitle = role
      ..rsiHandle = user.rSIHandle);

    try {
      final response = await corpStructureClient.removeUserRole(
          headers: headers, addUserRoleRequest: removeUserRoleRequest);

      if (response.data!.msg == "Role removed") {
        setState(() {
          _isLoading = true;
        });
        _initialize();
      }

      _applySearchAndFilter();
    } catch (error) {
      print(error);
    }
  }

  void _showVerifyDialog(GetUsers200ResponseInner user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: cardBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Text(
            'Verify ${user.rSIHandle.toString()}',
            style: TextStyle(
              color: primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text('Are you sure you want to verify this user?'),
          actions: [
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
                padding: MaterialStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              onPressed: () {
                _verifyUser(user);
                Navigator.of(context).pop();
              },
              child: Text(
                'Verify',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _verifyUser(GetUsers200ResponseInner user) async {
    final headers = await getAuthHeader();

    try {
      final response = await corpSecurityClient.manualyVerifyUser(
          headers: headers, username: user.rSIHandle.toString());

      if (response.data!.msg == "User verified") {
        setState(() {
          _isLoading = true;
        });
        _initialize();
      }

      _applySearchAndFilter();
    } catch (error) {
      print(error);
    }
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          SizedBox(
            width: 120, // Adjust width as needed
            child: Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Text(value),
        ],
      ),
    );
  }
}
