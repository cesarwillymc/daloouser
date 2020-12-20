import 'dart:ui';


import 'package:daloouser/data/network/NavigationService.dart';
import 'package:daloouser/src/pages/history/HistoryPreviewPage.dart';
import 'package:daloouser/src/widget/card/CardHistorialItem.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:daloouser/viewModel/ProductsViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../Locator.dart';
import '../../main.dart';
import 'MiPedidoPage.dart';

class HistorialPage extends StatefulWidget {

  @override
  _HistorialPageState createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  List<Widget> pages;

  @override
  Widget build(BuildContext context) {
    var noEstaVacio=boxList[3].isNotEmpty;
    var texto =
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
    return ViewModelBuilder<ProductsViewModel>.reactive(
      builder: (context, model, child) =>
      noEstaVacio?SafeArea(
            child: Scaffold(
              body: model.busy?Center(child: CircularProgressIndicator(),):ListView.builder(
                itemCount: model.getHistory.length,
                itemBuilder: (context,index){
                  return     GestureDetector(
                      onTap: (){
                        locator<NavigationService>().navigateTo(HistoryPreviewPageViewRoute,arguments: model.getHistory[index].sId);
                      },
                      child: CardHistorialItem(model.getHistory[index]));
                },),
            ),
          ):SafeArea(
              child: Center(
                child: Column(
                  children: [
                    Image.asset(
                      "assets/no_connection.png",
                      width: 300,
                      height: 300,
                    ),
                    Text(
                      "MENSAJE",
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "No estas logeado",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: primaryColor),
                    ),
                  ],
                ),
              )), viewModelBuilder: () => ProductsViewModel(),
      onModelReady: (model) => model.getHistoryItems(),);
  }

}

