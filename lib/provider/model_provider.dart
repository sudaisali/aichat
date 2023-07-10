import 'package:aichat/services/api_model_services.dart';
import 'package:flutter/material.dart';

import '../model/modelsmodel.dart';

class ModelProvider with ChangeNotifier{
  String currentModel = "whisper-1";
  String get getcurrentModel{
    return currentModel;
  }

  void setCurrentModel(String newModel){
    currentModel = newModel;
    notifyListeners();
  }

  List<ModelsModel> modelList =[];

  List<ModelsModel> get getModels{
    return modelList;
  }

  Future<List<ModelsModel>>  getAllModels() async{
   modelList = await ApiServices.getModels();
   return modelList;
}

}