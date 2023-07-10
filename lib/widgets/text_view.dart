import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String title;
  final double fontSize;
  final Color? color;
  final int? chatindex;
  final FontWeight? fontWeight;
  const MyText({
     this.chatindex,
    required this.title,
    this.fontSize = 18,
    this.fontWeight,
    this.color,
    Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(title, style: TextStyle(
        fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle :chatindex == 0 ? FontStyle.italic:FontStyle.normal,
      color: color ,
    ),);
  }
}
