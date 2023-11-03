import 'package:application/Pages/Home/color.dart';
import 'package:application/Pages/Home/dimension.dart';
import 'package:application/widgets/small_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Expandable_text extends StatefulWidget {
  final String text;
  const Expandable_text({Key? key, required this.text}) : super(key: key);

  @override
  State<Expandable_text> createState() => _Expandable_textState();
}

class _Expandable_textState extends State<Expandable_text> {
  late String firsthalf;
  late String secondhalf;
  bool hidentext=true;
  double textheight= Dimensions.screenheight/5.63;

  @override
  void initState(){
    super.initState();
    if(widget.text.length>textheight){
      firsthalf = widget.text.substring(0,textheight.toInt());
      secondhalf=widget.text.substring(textheight.toInt()+1,widget.text.length);
    }else {
      firsthalf=widget.text;
      secondhalf="";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondhalf.isEmpty? Small_text(text: firsthalf, color: Colors.grey,size: Dimensions.font16,height: 1.5):Column(
        children: [
          Small_text(text: hidentext?(firsthalf+"..."):(firsthalf+secondhalf), color: Colors.grey, size: Dimensions.font16, height: 1.5,),
          InkWell(
            onTap: (){
              setState(() {
                hidentext=!hidentext;
              });
            },
            child: Row(
              children: [
                hidentext?Small_text(text: "voir plus", color: color.maincolor, size: Dimensions.font15,):Small_text(text: "voir moins", color: color.maincolor,size: Dimensions.font15,),
                Icon(hidentext?Icons.arrow_drop_down:Icons.arrow_drop_up, color: color.maincolor,)
              ],
            ),
          )

        ],
      )
    );
  }
}
