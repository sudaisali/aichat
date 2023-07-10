import 'dart:developer';
import 'package:aichat/constants/constants.dart';
import 'package:aichat/model/chatmodel.dart';
import 'package:aichat/services/model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../provider/model_provider.dart';
import '../services/api_model_services.dart';
import '../widgets/chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomeScreen> {
  List<ChatModel> chatList = [];
  bool _isTyping = false;
  TextEditingController promptcontroller =  TextEditingController();
   FocusNode focusNode = FocusNode();
   ScrollController _listscrollcontroller = ScrollController();
  @override
  Widget build(BuildContext context) {
    final modelProvider = Provider.of<ModelProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 10,
        leading: const Icon(
          Icons.smart_toy_outlined,
          size: 30,
        ),
        title: const Text(
          "AI CHAT",
          style: TextStyle(
              fontWeight: FontWeight.w500, fontStyle: FontStyle.italic),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                await Service.showBottomsheet(context: context);
              },
              icon: const Icon(Icons.more_vert)),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                controller: _listscrollcontroller,
                  itemCount: chatList.length,
                  itemBuilder: (context, index) {
                    return ChatScreen(
                      chatMsg: chatList[index].chatMessage,
                      chatIndex:
                          chatList[index].chatIndex);

                  }),
            ),
            if (_isTyping) ...[
              const SpinKitThreeBounce(
                color: Colors.black54,
                size: 18,
              )
            ],
            Card(
              elevation: 10,
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          focusNode: focusNode,
                          controller: promptcontroller,
                          style: const TextStyle(fontSize: 18),
                          decoration: const InputDecoration.collapsed(
                            hintText: "How I can help you",
                          ),
                          onSubmitted: (value) async {
                            //TODO SEND MESSAGE
                            await sendMessageFCT(modelProvider: modelProvider);
                          },
                        ),
                      )),
                  IconButton(
                      onPressed: () async{
                        await sendMessageFCT(modelProvider: modelProvider);

                      },
                      icon: Icon(Icons.send))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
  void scrollListToEnd(){
    _listscrollcontroller.animateTo(_listscrollcontroller.position.maxScrollExtent,
        duration: Duration(seconds: 2), curve: Curves.easeIn);
  }
  Future<void> sendMessageFCT({required ModelProvider modelProvider}) async {
    if(_isTyping){
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(
              "Please Type a message"

          ),backgroundColor: Colors.red,
          )
      );
      return;
    }
         if(promptcontroller.text.isEmpty){
           ScaffoldMessenger.of(context).showSnackBar(
               SnackBar(content: Text(
                 "Please Type a message"

               ),backgroundColor: Colors.red,
               )
           );
           return;
         }
    //TODO SEND MESSAGE
    try {
      String msg = promptcontroller.text;
      setState(() {
        _isTyping = true;
        chatList.add(ChatModel(chatMessage: msg, chatIndex: 0));
        promptcontroller.clear();
        focusNode.unfocus();
      });
      print("request send");
      chatList.addAll(await ApiServices.chatModels(
          chatMessage: msg,
          modelId: modelProvider.getcurrentModel));
      print(promptcontroller.text);
          setState(() {

      });

    } catch (error) {
      print('Error $error');
      ScaffoldMessenger.of(context).showSnackBar(
       SnackBar(content: Text(
         error.toString(),

       ),backgroundColor: Colors.red,
       )
      );
    } finally {
      setState(() {
        scrollListToEnd();
        _isTyping = false;
      });
    }
  }
  

}