import 'package:corp_api/corp_api.dart';
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
  BuiltList<GetUsers200ResponseInner> users = BuiltList<GetUsers200ResponseInner>();
  BuiltList<GetUsers200ResponseInner> filteredUsers = BuiltList<GetUsers200ResponseInner>();
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
        final matchesSearch = user.rSIHandle.toString().toLowerCase().contains(_searchQuery.toLowerCase());
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
            trailing: IconButton(
              icon: Icon(_dropdownOpen[userIndex] == true ? Icons.arrow_drop_up : Icons.more_vert),
              onPressed: () {
                setState(() {
                  _dropdownOpen[userIndex] = !_dropdownOpen[userIndex]!;
                });
              },
            ),
          ),
          if (_dropdownOpen[userIndex] == true)
            _buildDropdownContent(user),
        ],
      ),
    );
  }

  Widget _buildDropdownContent(GetUsers200ResponseInner user) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Security level: ${user.securityLevel}'),
          Text('Disabled: ${user.disabled.toString()}'),
          // Add more details as needed
        ],
      ),
    );
  }
}
