import 'package:corp_api/corp_api.dart';
import 'package:flutter_dashboard/util/responsive.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/Influence_system/components/influence_details_card.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/components/line_chart_card.dart';
import 'package:flutter/material.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter_dashboard/const/constant.dart';
import 'package:flutter_dashboard/main.dart';

class DepartmentManagerWidget extends StatefulWidget {
  const DepartmentManagerWidget({super.key});

  @override
  _DepartmentManagerWidgetState createState() => _DepartmentManagerWidgetState();
}

class _DepartmentManagerWidgetState extends State<DepartmentManagerWidget> {
  BuiltList<GetDepartments200ResponseInner> departments =
      BuiltList<GetDepartments200ResponseInner>();
  BuiltList<GetDepartments200ResponseInner> filteredItems =
      BuiltList<GetDepartments200ResponseInner>();
  Map<int, bool> _dropdownOpen = {};

  bool _isLoading = true;
  final corpStructureClient = corpApi.getStructureApi();
  String _searchQuery = '';
  String _filter = 'All';

  Future<void> _initialize() async {
    try {
      final response = await corpStructureClient.getDepartments();
      if (response.data != null) {
        departments = response.data ?? departments;
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
      filteredItems = departments.where((department) {
        final matchesSearch = department.title
            .toString()
            .toLowerCase()
            .contains(_searchQuery.toLowerCase());
        return matchesSearch;
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
              hintText: 'Search departments...',
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
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _showAddDepartmentDialog();
          },
        ),
        SizedBox(width: 10),
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

  void _showAddDepartmentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String title = '';
        return AlertDialog(
          backgroundColor: cardBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Text(
            'Add Department',
            style: TextStyle(
              color: primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  title = value;
                },
                decoration: InputDecoration(hintText: "Title"),
              ),
            ],
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
                backgroundColor: WidgetStateProperty.all<Color>(primaryColor),
                padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              onPressed: () {
                _addDepartment(title);
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

  void _addDepartment(String title) async {
    final headers = await getAuthHeader();
    try {
      //final response = await corpStructureClient.create_department(headers: headers);
      
      _applySearchAndFilter();

    } catch (error) {
      print(error);
    }

    setState(() {
      _applySearchAndFilter();
    });
  }

  Widget _buildUserList() {
    if (filteredItems.isEmpty) {
      return Center(
        child: Text(
          'No departments found.',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final department = filteredItems[index];
        return _buildUserItem(department);
      },
    );
  }

  Widget _buildUserItem(GetDepartments200ResponseInner department) {
    int departmentIndex = departments.indexOf(department);
    _dropdownOpen.putIfAbsent(departmentIndex, () => false);
    return Card(
      color: cardBackgroundColor,
      child: Column(
        children: [
          ListTile(
            title: Text(department.title.toString()),
            subtitle: Text(department.motto.toString()),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _showDeleteDialog(department);
                  },
                ),
                IconButton(
                  icon: Icon(_dropdownOpen[departmentIndex] == true
                      ? Icons.arrow_drop_up
                      : Icons.more_vert),
                  onPressed: () {
                    setState(() {
                      _dropdownOpen[departmentIndex] = !_dropdownOpen[departmentIndex]!;
                    });
                  },
                ),
              ],
            ),
          ),
          if (_dropdownOpen[departmentIndex] == true) _buildDropdownContent(department),
        ],
      ),
    );
  }

  void _showDeleteDialog(GetDepartments200ResponseInner department) {
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
            'Deleting ${department.title.toString()}',
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
        _deleteDepartment(department);
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

  void _deleteDepartment(GetDepartments200ResponseInner department) {
    setState(() {
      departments = departments.rebuild((b) => b.remove(department));
      _applySearchAndFilter();
    });
  }

  Widget _buildDropdownContent(GetDepartments200ResponseInner department) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetailRow('Heads', department.heads.toString()),
          _buildDetailRow('Proxys', department.proxys.toString()),
          // Add more details as needed
        ],
      ),
    );
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
