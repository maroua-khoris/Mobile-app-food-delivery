
import 'package:application/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//import '../Home/dimension.dart';
import '../Pages/Home/dimension.dart';


class Icon_text extends  StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;
  final Color iconcolor;
  const Icon_text({Key? key, required this.text, required this.icon, this.color= Colors.grey, required this.iconcolor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconcolor,size: Dimensions.iconsize24,),
        SizedBox(width: 5,),
        Small_text(text: text, color: color,),

      ],
    );
  }
}

