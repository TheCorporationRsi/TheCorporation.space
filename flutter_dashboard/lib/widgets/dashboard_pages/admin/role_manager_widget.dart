import 'package:corp_api/corp_api.dart';
import 'package:flutter_dashboard/model/current_user.dart';
import 'package:flutter_dashboard/util/responsive.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/Influence_system/components/influence_details_card.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/components/line_chart_card.dart';
import 'package:flutter/material.dart';
import 'package:built_collection/built_collection.dart';
import 'package:flutter_dashboard/const/constant.dart';
import 'package:flutter_dashboard/main.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

import 'package:flutter_dashboard/util/css_color.dart';
import 'package:flutter_dashboard/util/icon_helper.dart';

class RoleManagerWidget extends StatefulWidget {
  const RoleManagerWidget({super.key});

  @override
  _RoleManagerWidgetState createState() => _RoleManagerWidgetState();
}

class _RoleManagerWidgetState extends State<RoleManagerWidget> {
  BuiltList<GetRoles200ResponseInner> roles = BuiltList<GetRoles200ResponseInner>();
  BuiltList<GetDepartments200ResponseInner> departments = BuiltList<GetDepartments200ResponseInner>();
  BuiltList<GetDivisions200ResponseInner> divisions = BuiltList<GetDivisions200ResponseInner>();
  BuiltList<GetRoles200ResponseInner> filteredItems = BuiltList<GetRoles200ResponseInner>();
  Map<int, bool> _dropdownOpen = {};
  Map<int, GlobalKey<FormState>> _formKeys = {};

  bool _isLoading = true;
  final corpStructureClient = corpApi.getStructureApi();
  final corpAdminClient = corpApi.getAdminApi();
  String _searchQuery = '';
  String _filter = 'All';
  String _selectedDepartmentFilter = 'All';
  String _selectedDivisionFilter = 'All';

  Future<void> _initialize() async {
    try {
      final response = await corpStructureClient.getRoles();
      if (response.data != null) {
        roles = response.data ?? roles;
        _applySearchAndFilter();
      }
    } catch (error) {
      print(error);
    }

    try {
      final response = await corpStructureClient.getDepartments();
      if (response.data != null) {
        departments = response.data ?? departments;
      }
    } catch (error) {
      print(error);
    }

    try {
      final response = await corpStructureClient.getDivisions();
      if (response.data != null) {
        divisions = response.data ?? divisions;
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
      filteredItems = roles.where((role) {
        final matchesSearch = role.title
            .toString()
            .toLowerCase()
            .contains(_searchQuery.toLowerCase());
        final matchesDepartment = _selectedDepartmentFilter == 'All' ||
            role.department == _selectedDepartmentFilter;
        final matchesDivision = _selectedDivisionFilter == 'All' ||
            role.division == _selectedDivisionFilter;
        return matchesSearch && matchesDepartment;
      }).toBuiltList();
    });
  }

  @override
  void initState() {
    super.initState();
    _initialize();
    for (int i = 0; i < roles.length; i++) {
      _formKeys[i] = GlobalKey<FormState>();
    }
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
            _buildRoleList(),
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
              hintText: 'Search roles...',
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
        DropdownButton<String>(
          value: _selectedDepartmentFilter,
          items: ['All', ...departments.map((d) => d.title!).toList()]
              .map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedDepartmentFilter = value!;
              _applySearchAndFilter();
            });
          },
        ),
        SizedBox(width: 10),
        DropdownButton<String>(
          value: _selectedDivisionFilter,
          items: ['All', ...divisions.map((d) => d.title!).toList()]
              .map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedDivisionFilter = value!;
              _applySearchAndFilter();
            });
          },
        ),
        SizedBox(width: 10),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () {
            _showAddRoleDialog();
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

  void _showAddRoleDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String title = '';
        String selectedDepartment = '';
        String selectedDivision = '';
        return AlertDialog(
          backgroundColor: cardBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          title: Text(
            'Add Role',
            style: TextStyle(
              color: primaryColor,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Department',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedDepartment.isEmpty ? null : selectedDepartment,
                items: selectedDivision.isNotEmpty
                ? departments.where((department) =>
                    divisions.any((division) =>
                      division.departmentTitle == department.title &&
                      division.title == selectedDivision))
                  .map((department) {
                    return DropdownMenuItem<String>(
                      value: department.title,
                      child: Text(department.title!, style: TextStyle(color: cssColorToColor(department.color!))),
                    );
                  }).toList()
                : departments.map((department) {
                  return DropdownMenuItem<String>(
                    value: department.title,
                    child: Text(department.title!, style: TextStyle(color: cssColorToColor(department.color!))),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedDepartment = value!;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Select Department',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Select Division',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: selectedDivision.isEmpty ? null : selectedDivision,
                items: selectedDepartment.isEmpty
                  ? divisions.map((division) {
                      return DropdownMenuItem<String>(
                        value: division.title,
                        child: Text(division.title!, style: TextStyle(color: cssColorToColor(division.color!))),
                      );
                    }).toList()
                  : divisions.where((division) =>
                      division.departmentTitle == selectedDepartment)
                    .map((division) {
                      return DropdownMenuItem<String>(
                        value: division.title,
                        child: Text(division.title!, style: TextStyle(color: cssColorToColor(division.color!))),
                      );
                    }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedDivision = value!;
                    selectedDepartment = divisions
                      .firstWhere((division) => division.title == value)
                      .departmentTitle!;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Select Division',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 10),
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
                padding: WidgetStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              onPressed: () {
                _addRole(title, selectedDepartment, selectedDivision);
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

  void _addRole(String title, String? departmentTitle, String? divisionTitle) async {
    final headers = await getAuthHeader();

    final CreateRoleRequest createRoleRequest =
        CreateRoleRequest((b) => b
          ..title = title
          ..departmentTitle = departmentTitle
          ..divisionTitle = divisionTitle
          );

    try {
      final response = await corpStructureClient.createRole(
          headers: headers, createRoleRequest: createRoleRequest);

      if (response.data!.msg == "Role created") {
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

  Widget _buildRoleList() {
    if (filteredItems.isEmpty) {
      return Center(
        child: Text(
          'No roles found.',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final role = filteredItems[index];
        return _buildRoleItem(role);
      },
    );
  }

  Widget _buildRoleItem(GetRoles200ResponseInner role) {
    int roleIndex = roles.indexOf(role);
    _dropdownOpen.putIfAbsent(roleIndex, () => false);
    return Card(
      color: cardBackgroundColor,
      child: Column(
        children: [
          ListTile(
            leading: Icon(icons[role.logo] ?? Icons.error,
                color: role.color != null
                    ? cssColorToColor(role.color!)
                    : Colors.grey),
            title: Text(role.title.toString(),
                style: TextStyle(
                  color: role.color != null
                      ? cssColorToColor(role.color!)
                      : Colors.grey,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                )),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    _showDeleteDialog(role);
                  },
                ),
                IconButton(
                  icon: Icon(_dropdownOpen[roleIndex] == true
                      ? Icons.arrow_drop_up
                      : Icons.more_vert),
                  onPressed: () {
                    setState(() {
                      _dropdownOpen[roleIndex] =
                          !_dropdownOpen[roleIndex]!;
                    });
                  },
                ),
              ],
            ),
          ),
          if (_dropdownOpen[roleIndex] == true)
            _buildDropdownContent(role),
        ],
      ),
    );
  }

  void _showDeleteDialog(GetRoles200ResponseInner role) {
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
            'Deleting ${role.title.toString()}',
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
            decoration: InputDecoration(hintText: "Enter title to delete"),
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
                padding: WidgetStateProperty.all<EdgeInsets>(
                    EdgeInsets.symmetric(horizontal: 20, vertical: 10)),
                shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              onPressed: () {
                if (confirmation == role.title.toString()) {
                  _deleteRole(role);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Title does not match'),
                      backgroundColor: Colors.red,
                    ),
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

  void _deleteRole(GetRoles200ResponseInner role) async {
    final headers = await getAuthHeader();

    final DeleteRoleRequest deleteRoleRequest =
        DeleteRoleRequest((b) => b
        ..roleTitle = role.title
        );

    try {
      final response = await corpStructureClient.deleteRole(
          headers: headers, deleteRoleRequest: deleteRoleRequest);

      if (response.data!.msg == "Role deleted") {
        setState(() {
          roles = roles.rebuild((b) => b.remove(role));
          _applySearchAndFilter();
        });
      }
    } catch (error) {
      print(error);
    }
  }

  Widget _buildDropdownContent(GetRoles200ResponseInner role) {
    Color currentColor = role.color != null
        ? cssColorToColor(role.color!)
        : Colors.grey;
    int roleIndex = roles.indexOf(role);
    String title = role.title ?? '';
    String discordID = role.discordId ?? '';
    String logo = role.logo ?? '';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: TextEditingController(text: title),
            onChanged: (value) {
              title = value;
            },
            decoration: InputDecoration(
              labelText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          if (role.division == null && role.department == null) 
          IconInputWidget(initialIcon: logo, onIconChanged: (newLogo) {
            logo = newLogo;
          }),
          if (role.division == null && role.department == null) 
          SizedBox(height: 10),
          TextField(
            controller: TextEditingController(text: discordID),
            onChanged: (value) {
              discordID = value;
            },
            decoration: InputDecoration(
              labelText: 'Discord ID',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 10),
          if (role.type != "Membership" && role.type != "Leadership")
          ColorInputWidget(
            initialColor: currentColor,
            onColorChanged: (color) {
              currentColor = color;
            },
          ),
          SizedBox(height: 10),
          SizedBox(height: 10),
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              onPressed: () {
                _updateRole(role, title, colorToCssColor(currentColor), discordID, logo);
              },
              child: Text('Save'),
            ),
          ),
        ],
      ),
    );
  }

  void _updateRole(GetRoles200ResponseInner role,
    String title, String color, String discordID, String logo) async {
    final headers = await getAuthHeader();

    final UpdateRoleRequest updateRoleRequest = UpdateRoleRequest((b) => b
          ..roleTitle = role.title
          ..newTitle = title
          ..newColor = color
          ..newDiscordId = discordID
          ..newLogo = logo
          );

    try {
      final response = await corpStructureClient.updateRole(
          headers: headers, updateRoleRequest: updateRoleRequest);

      if (response.data!.msg == "Role updated") {
        setState(() {
          _isLoading = true;
        });
        _initialize();
      }

      _applySearchAndFilter();
    } catch (error) {
      print(error);
    }

    setState(() {
      _applySearchAndFilter();
    });
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
