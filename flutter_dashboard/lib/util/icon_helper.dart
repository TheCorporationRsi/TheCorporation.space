import 'package:flutter/material.dart';
import 'package:flutter_dashboard/const/constant.dart';

const icons = {
  'factory': Icons.factory,
  'pallet': Icons.pallet,
  'engineering': Icons.engineering,
  'business_center': Icons.business_center,
  'health_and_safety': Icons.health_and_safety,
  'groups': Icons.groups,
  'local_police': Icons.local_police,
  'devices': Icons.devices,
  'explore': Icons.explore,
  'work_outline': Icons.work_outline,
  'error': Icons.error,
  'newspaper': Icons.newspaper,
  'rocket_launch': Icons.rocket_launch,
  'military_tech': Icons.military_tech,
  'personal_injury': Icons.personal_injury,
  'sensor_occupied': Icons.sensor_occupied,
  'two_wheeler': Icons.two_wheeler,
  'trolley': Icons.trolley,
  'forklift': Icons.forklift,
  'oil_barrel': Icons.oil_barrel,
  'campaign': Icons.campaign,
  'travel_explore': Icons.travel_explore,
  'place': Icons.place,
  'science': Icons.science,
  'account_balance': Icons.account_balance,
  'storefront': Icons.storefront,
  'description': Icons.description,
  'sports_esports': Icons.sports_esports,
  'flag': Icons.flag,
  'diversity_3': Icons.diversity_3,
};


class IconInputWidget extends StatefulWidget {
  final String? initialIcon;
  final ValueChanged<String> onIconChanged;

  IconInputWidget({required this.initialIcon, required this.onIconChanged});

  @override
  _IconInputWidgetState createState() => _IconInputWidgetState();
}

class _IconInputWidgetState extends State<IconInputWidget> {
  final TextEditingController _controller = TextEditingController();
  IconData? _icon;
  String? _selectedIcon;

  @override
  void initState() {
    super.initState();
    _selectedIcon = icons.keys.contains(widget.initialIcon) ? widget.initialIcon : 'error';
    _icon = icons[_selectedIcon] ?? Icons.error;
  }

  void _updateIcon(String? newIcon) {
    setState(() {
      _selectedIcon = newIcon;
      _icon = icons[_selectedIcon] ?? Icons.error;
      widget.onIconChanged(_selectedIcon!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownButton<String>(
            value: _selectedIcon,
            items: icons.keys.map((String key) {
              return DropdownMenuItem<String>(
                value: key,
                child: Row(
                  children: [
                    Icon(icons[key]),
                    SizedBox(width: 10),
                    Text(key),
                  ],
                ),
              );
            }).toList(),
            onChanged: _updateIcon,
          ),
        ),
      ],
    );
  }
}