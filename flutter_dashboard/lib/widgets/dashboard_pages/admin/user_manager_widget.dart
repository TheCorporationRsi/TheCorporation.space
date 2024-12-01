import 'package:flutter_dashboard/util/responsive.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/Influence_system/components/influence_details_card.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/components/line_chart_card.dart';
import 'package:flutter/material.dart';

class UserManagerWidget extends StatefulWidget {
  const UserManagerWidget({super.key});

  @override
  _UserManagerWidgetState createState() => _UserManagerWidgetState();
}

class _UserManagerWidgetState extends State<UserManagerWidget> {
  @override
  Widget build(BuildContext context) {
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
    // Dummy user data
    final List<Map<String, dynamic>> users = [
      {
        'profilePicture': 'path/to/profile1.png',
        'name': 'User One',
        'isVerified': true,
        'isCorp': false,
      },
      {
        'profilePicture': 'path/to/profile2.png',
        'name': 'User Two',
        'isVerified': false,
        'isCorp': true,
      },
      // Add more users here
    ];

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

  Widget _buildUserItem(Map<String, dynamic> user) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: AssetImage(user['profilePicture']),
        ),
        title: Text(user['name']),
        subtitle: Row(
          children: [
            if (user['isVerified'])
              Icon(Icons.verified, color: Colors.blue, size: 16),
            if (user['isCorp'])
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
