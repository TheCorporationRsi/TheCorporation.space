import 'package:flutter_dashboard/const/constant.dart';
import 'package:flutter_dashboard/util/responsive.dart';
import 'package:flutter_dashboard/widgets/dashboard_pages/components/custom_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dashboard/model/current_user.dart' as current_user;
import 'package:flutter_dashboard/model/influence_account.dart' as infAccount;
import 'package:auto_size_text/auto_size_text.dart';
class DepartmentSelectionCard extends StatelessWidget {
  const DepartmentSelectionCard({super.key});

  @override
  Widget build(BuildContext context) {
    
    return ValueListenableBuilder(
      valueListenable: infAccount.profile,
      builder: (context, value, child) => 

      DropdownButton<String>(
        value: "HR",
        onChanged: (String? newValue) {
          infAccount.profile.value = infAccount.profile.value.copyWith(department: newValue);
        },
        items: <String>['HR', 'Engineering', 'Marketing', 'Sales']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      )
    );
  }
}
