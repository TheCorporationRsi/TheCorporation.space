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

  bool _isLoading = true;
  final corpSecurityClient = corpApi.getSecurityApi();

  Future<void> _initialize() async {
    final headers = await getAuthHeader();
    try {
      final response = await corpSecurityClient.getUsers(headers: headers);
      if (response.data != null) {
        users = response.data ?? users;
      }
    } catch (error) {
      print(error);
    }
    setState(() {
      _isLoading = false;
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
          ),
        ),
        SizedBox(width: 10),
        DropdownButton<String>(
          hint: Text('Filter by'),
          items: <String>['Verified', 'CORP', 'All'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            // Handle filter change
          },
        ),
      ],
    );
  }

  Widget _buildUserList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return _buildUserItem(user);
      },
    );
  }

  Widget _buildUserItem(GetUsers200ResponseInner user) {
    return Card(
      child: ListTile(
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
          icon: Icon(Icons.more_vert),
          onPressed: () {
            // Handle dropdown section
          },
        ),
      ),
    );
  }
}
