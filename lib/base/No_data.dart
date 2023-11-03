import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class No_data extends StatelessWidget {
  final String text;
  final String pathImage;

  const No_data({Key? key, required this.text, this.pathImage="image/empty-cart.png"}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Image.asset(
        pathImage,
    ),
        SizedBox(height: MediaQuery.of(context).size.height*0.03,),
        Text(
          text,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height*0.0175,
            color: Theme.of(context).disabledColor
          ),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
