import 'package:flutter/material.dart';

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