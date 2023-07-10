import 'package:aichat/constants/constants.dart';
import 'package:aichat/provider/model_provider.dart';
import 'package:aichat/services/api_model_services.dart';
import 'package:aichat/widgets/text_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../model/modelsmodel.dart';

class ModelDropDown extends StatefulWidget {
  const ModelDropDown({Key? key}) : super(key: key);

  @override
  State<ModelDropDown> createState() => _ModelDropDownState();
}

class _ModelDropDownState extends State<ModelDropDown> {
  String? currentModel;
  @override
  Widget build(BuildContext context) {
    final modelProvider =Provider.of<ModelProvider>(context , listen: false);
    currentModel = modelProvider.getcurrentModel;
    return FutureBuilder <List<ModelsModel>>(
        future: modelProvider.getAllModels(),
        builder: (context , snapshot){
       if(snapshot.hasError){
         return Center(child: MyText(title: snapshot.error.toString(),),);
       }
       return snapshot.data == null || snapshot.data!.isEmpty ? const
       SizedBox(): FittedBox(
         child: DropdownButton(
             items: List<DropdownMenuItem<String>>.generate(
                 snapshot.data!.length,
                     (index) => DropdownMenuItem(
                     value: snapshot.data![index].id,
                     child: MyText(
                       title: snapshot.data![index].id,
                       fontSize: 15,
                     ))),
             value: currentModel,
             onChanged: (value){
               setState(() {
                 currentModel = value.toString();
               });
               modelProvider.setCurrentModel(value.toString());
             }),
       );

    });
  }
}
