import 'package:aichat/widgets/drop_down.dart';
import 'package:flutter/material.dart';
import '../widgets/text_view.dart';

class Service{
  static Future<void> showBottomsheet({required BuildContext context}) async {
    await showModalBottomSheet(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(25))
        ),
        context: context, builder: (context){
      return const Padding(
        padding:  EdgeInsets.all(18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Flexible(child: MyText(title: "Choose Model:")),
            Flexible( child: ModelDropDown()),
          ],
        ),
      );
    });
  }
}