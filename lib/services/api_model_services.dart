import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:aichat/model/chatmodel.dart';
import 'package:aichat/model/modelsmodel.dart';
import 'package:http/http.dart' as http;

import '../constants/api_constants.dart';

class ApiServices {
  static Future<List<ModelsModel>> getModels() async {
    try {
      var response = await http.get(
        Uri.parse("$BASE_URL/models"),
        headers: {'Authorization': 'Bearer $API_KEY'},
      );
      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        print("jsonResponseError:${jsonResponse['error']['message']}");
        throw HttpException(jsonResponse['error']['message']);
      }
      // print(jsonResponse);
      List temp = [];
      for (var value in jsonResponse['data']) {
        temp.add(value);
        print("temp ${value["id"]}");
      }
      return ModelsModel.modelsFromSnapshot(temp);
    } catch (error) {
      print("Error: $error");
      rethrow;
    }
  }

  static Future<List<ChatModel>> chatModels(
      {required String modelId, required String chatMessage}) async {
    try {
      var response = await http.post(
        Uri.parse("$BASE_URL/chat/completions"),
        headers: {
          'Authorization': 'Bearer $API_KEY',
          "Content-Type": "application/json"
        },
        body: jsonEncode({
          "model": "gpt-3.5-turbo",
          "messages": [
            {"role": "user", "content": chatMessage}
          ],
          "temperature": 1
        }),
      );
      Map jsonResponse = jsonDecode(response.body);
      if (jsonResponse['error'] != null) {
        print("jsonResponseError:${jsonResponse['error']['message']}");
        throw HttpException(jsonResponse['error']['message']);
      }
      List<ChatModel> chatList = [];
      if (jsonResponse['choices'].length > 0) {
        // print("JsonResponce[choices]: "
        //     "${jsonResponse["choices"][0]["message"]["content"]}");
        chatList = List.generate(
            jsonResponse['choices'].length,
            (index) => ChatModel(
                chatMessage: jsonResponse["choices"][0]["message"]["content"],
                chatIndex: 1));
      }
      return chatList;
    } catch (error) {
      print("Error: $error");
      rethrow;
    }
  }
}
