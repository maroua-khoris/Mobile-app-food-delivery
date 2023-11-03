import 'package:application/Pages/Home/color.dart';
import 'package:application/Pages/Home/dimension.dart';
import 'package:flutter/cupertino.dart';

class App_icon extends StatelessWidget {
  final IconData icon;
  final Color background;
  final Color iconcolor;
  final double iconSize;
  final double size;
  const App_icon({Key? key, required this.icon,  this.background= const Color(0xFFfcf4e4),  this.iconcolor= const Color(0xFF756d54),  this.size=40, this.iconSize=24}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size/2),
        color: background,
      ),
      child: Icon(
        icon,
        color: iconcolor,
        size: iconSize,
      ),
    );
  }
}
