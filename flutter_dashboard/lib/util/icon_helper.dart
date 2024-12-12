import 'package:flutter/material.dart';
import 'package:flutter_dashboard/const/constant.dart';


class IconInputWidget extends StatefulWidget {
  final IconData initialIcon;
  final ValueChanged<IconData> onIconChanged;

  IconInputWidget({required this.initialIcon, required this.onIconChanged});

  @override
  _IconInputWidgetState createState() => _IconInputWidgetState();
}

class _IconInputWidgetState extends State<IconInputWidget> {
  final TextEditingController _controller = TextEditingController();
  IconData? _icon;

  @override
  void initState() {
    super.initState();
    _icon = widget.initialIcon;
  }

  void _updateColor() {
    late final IconData icon;
    try {
      icon = IconData(int.parse(_controller.text), fontFamily: 'MaterialIcons');
    } catch (e) {
      return;
    }
    
    setState(() {
    _icon = icon;
    widget.onIconChanged(_icon!);
    });
    
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: 
          TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'Icon code',
              border: OutlineInputBorder(),
            ),
            onChanged: (text) => _updateColor(),
          ),
        ),
        if (_icon != null)
            Container(
            width: 40,
            height: 40,
            margin: EdgeInsets.only(left: 10),
            child: Icon(_icon, size: 30),
            ),
          
      ],
    );
  }
}