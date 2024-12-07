import 'package:flutter/material.dart';
import 'package:flutter_dashboard/const/constant.dart';

Color cssColorToColor(String cssColor) {

  
  // Define a map of simple color names to their corresponding Color values
  const colorNames = {
    'red': Colors.red,
    'blue': Colors.blue,
    'green': Colors.green,
    'yellow': Colors.yellow,
    'orange': Colors.orange,
    'purple': Colors.purple,
    'pink': Colors.pink,
    'brown': Colors.brown,
    'grey': Colors.grey,
    'black': Colors.black,
    'white': Colors.white,
  };

  // Check if the color is a simple color name
  if (colorNames.containsKey(cssColor.toLowerCase())) {
    return colorNames[cssColor.toLowerCase()]!;
  }

  // Remove the leading '#' if it exists
  if (cssColor.startsWith('#')) {
    cssColor = cssColor.substring(1);
  }

  // If the color is in the format #RRGGBB, add the alpha value (FF)
  if (cssColor.length == 6) {
    cssColor = 'FF' + cssColor;
  }

  // Parse the color string and create a Color object
  return Color(int.parse(cssColor, radix: 16));
}

String colorToCssColor(Color color) {
  // Define a map of Color values to their corresponding simple color names
  const colorNames = {
    'red': Colors.red,
    'blue': Colors.blue,
    'green': Colors.green,
    'yellow': Colors.yellow,
    'orange': Colors.orange,
    'purple': Colors.purple,
    'pink': Colors.pink,
    'brown': Colors.brown,
    'grey': Colors.grey,
    'black': Colors.black,
    'white': Colors.white,
  };

  // Check if the color is a simple color name
  if (colorNames.containsValue(color)) {
    
    return colorNames.keys.firstWhere((k) => colorNames[k] == color);
  }

  // Convert the Color object to a CSS color string in the format #AARRGGBB
  return '#${color.value.toRadixString(16).padLeft(8, '0')}';
}

class ColorInputWidget extends StatefulWidget {
  final Color initialColor;
  final ValueChanged<Color> onColorChanged;

  ColorInputWidget({required this.initialColor, required this.onColorChanged});

  @override
  _ColorInputWidgetState createState() => _ColorInputWidgetState();
}

class _ColorInputWidgetState extends State<ColorInputWidget> {
  final TextEditingController _controller = TextEditingController();
  Color? _color;

  @override
  void initState() {
    super.initState();
    _color = widget.initialColor;
    _controller.text = colorToCssColor(_color!);
  }

  void _updateColor() {
    late final Color color;
    try {
      color = cssColorToColor(_controller.text);
    } catch (e) {
      return;
    }
    
    setState(() {
    _color = color;
    widget.onColorChanged(_color!);
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
              labelText: 'CSS color',
              border: OutlineInputBorder(),
            ),
            onChanged: (text) => _updateColor(),
          ),
        ),
        if (_color != null)
          Container(
            width: 40,
            height: 40,
            margin: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              color: _color,
              border: Border.all(color: backgroundColor, width: 3),
            ),
          ),
      ],
    );
  }
}