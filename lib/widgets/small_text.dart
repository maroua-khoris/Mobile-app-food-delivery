
import 'package:flutter/cupertino.dart';

class Small_text extends StatelessWidget {
  Color? color;
  final String text;
  double size;
  double height;

  Small_text({Key? key,
    this.color = const  Color(0xFF332d2b), required this.text, this.size=12, this.height=1.2
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: color,
          fontFamily: 'Roboto',
          fontSize: size,
          height: height
      ),
    );
  }
}
