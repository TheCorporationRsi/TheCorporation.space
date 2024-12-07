import 'package:corp_api/corp_api.dart';
import 'package:flutter_dashboard/model/current_user.dart';
import 'package:flutter_dashboard/util/responsive.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/Influence_system/components/influence_details_card.dart';
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
        String pincode = '';
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
              pincode = value;
            },
            decoration: InputDecoration(hintText: "Pin code"),
            keyboardType: TextInputType.number,
            obscureText: true,
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
      padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    ),
    onPressed: () {
      if (pincode == '1234') { // Replace '1234' with the actual pincode logic
        _deleteUser(user);
        Navigator.of(context).pop();
      } else {
        // Show error message or handle invalid pincode
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

  void _deleteUser(GetUsers200ResponseInner user) {
    setState(() {
      users = users.rebuild((b) => b.remove(user));
      _applySearchAndFilter();
    });
  }

  Widget _buildDropdownContent(GetUsers200ResponseInner user) {
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
              _showAddRoleDialog(user);
            },
            child: Text('Add Role'),
          ),
        ],
      ),
    );
  }

  void _showAddRoleDialog(GetUsers200ResponseInner user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String role = '';
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
          content: TextField(
            onChanged: (value) {
              role = value;
            },
            decoration: InputDecoration(hintText: "Role"),
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
                _addRoleToUser(user, role);
                Navigator.of(context).pop();
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

  void _addRoleToUser(GetUsers200ResponseInner user, String role) async {
    final headers = await getAuthHeader();

    final AddUserRoleRequest addUserRoleRequest =
        AddUserRoleRequest((b) => b
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
