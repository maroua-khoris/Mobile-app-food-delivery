
import 'package:flutter/cupertino.dart';

//import '../Home/dimension.dart';
import '../Pages/Home/dimension.dart';


class Police_text extends StatelessWidget {
   Color? color;
  final String text;
  double size;
  TextOverflow overFlow;
   Police_text({Key? key,
    this.color = const  Color(0xFF332d2b), required this.text, this.overFlow=TextOverflow.ellipsis, this.size=20
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
      maxLines: 1,
      overflow: overFlow,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.w400,
        fontFamily: 'Roboto',
        fontSize: size == 0?Dimensions.font20:size
      ),
    );
  }
}
