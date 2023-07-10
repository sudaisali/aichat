import 'package:aichat/widgets/text_view.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class ChatScreen extends StatelessWidget {
  final String chatMsg;
  final int chatIndex;

  const ChatScreen({required this.chatIndex, required this.chatMsg, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: chatIndex == 0 ? 0 : 10,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  chatIndex == 0 ? Icons.person : Icons.smart_toy_sharp,
                  size: 20,
                ),
                const SizedBox(
                  width: 5,
                ),
                Expanded(child:

                chatIndex == 0 ?
                MyText(title: chatMsg, chatindex: chatIndex):
                DefaultTextStyle(
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.black
                  ),
                  child: AnimatedTextKit(
                      displayFullTextOnTap: true,
                    totalRepeatCount: 1,
                    repeatForever: false,
                    isRepeatingAnimation : false,
                    animatedTexts: [
                    TyperAnimatedText(chatMsg.trim())
                  ],),
                )),
                chatIndex == 0
                    ? const SizedBox.shrink()
                    : const Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.thumb_up_alt_outlined),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.thumb_down_alt_outlined)
                        ],
                      )
              ],
            ),
          ),
        )
      ],
    );
  }
}
