

import 'package:daloouser/data/model/HistoryModel.dart';
import 'package:daloouser/src/widget/imput/InputField.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:daloouser/utils/FunctionsUitls.dart';
import 'package:daloouser/viewModel/ProductsViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

class HistoryPreviewPage extends StatefulWidget {
  String id;
  HistoryPreviewPage(this.id);

  @override
  _HistoryPreviewPageState createState() => _HistoryPreviewPageState();
}

class _HistoryPreviewPageState extends State<HistoryPreviewPage> {
  var textStyleTitle = TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: primaryColor);
  final textPhoneController = TextEditingController();
  final textCodeController = TextEditingController();
  var textStyleSubTitle = TextStyle(
      fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black);
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {

    return  ViewModelBuilder<ProductsViewModel>.reactive(builder: (aaaaa,model,child)=>
        SafeArea(
            child: model.busy?Center(child: CircularProgressIndicator(),):Scaffold(
              body: ListView.builder(
                itemCount: model.historyById.items.length,
                itemBuilder: (kkkk, index) {
                  return GestureDetector(onTap: () {}, child: _cardview(context, model.historyById.items[index]));
                },
              ),
              appBar:  AppBar(
                backgroundColor: primaryColor,
                title: Text("REVISAR PEDIDO",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
              ),
              bottomNavigationBar: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Card(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Delivery",
                            style: textStyleTitle,
                          ),
                          Text(
                            "S/. ${model.historyById.riderPrice}",
                            style: textStyleSubTitle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      padding: EdgeInsets.symmetric(vertical: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Total",
                            style: textStyleTitle,
                          ),
                          Text(
                            "S/. ${double.parse(model.historyById.riderPrice)+double.parse(model.historyById.itemsPrice)}",
                            style: textStyleSubTitle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  isLoading?Center(child: CircularProgressIndicator(),):GestureDetector(
                    onTap: () async {
                      print("urlpdf ${model.historyById.pdf}  ${model.historyById.pdf.contains("null")}");
                      if(!model.historyById.pdf.contains("null")){
                        launchURL(BASE_URL_AMAZON_IMG+model.historyById.pdf);
                        setState(() {
                          isLoading=false;
                        });
                      }else{
                        model.descargarBoletaventa(widget.id).listen((event) {
                          switch (event.state) {
                            case ResourceState.COMPLETE:
                              setState(() {
                                isLoading=false;
                              });
                              launchURL(BASE_URL_AMAZON_IMG+event.data.toString());
                              break;
                            case ResourceState.ERROR:
                              setState(() {
                                isLoading=false;
                              });
                              Toast.show(event.exception, context);
                              break;
                            case ResourceState.LOADING:
                              setState(() {
                                isLoading=true;
                              });
                              break;
                          }
                        });
                      }
                    },
                    child: Center(
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width*0.8,
                        alignment: Alignment.center,
                        child: Text("DESCARGAR BOLETA",style: TextStyle(fontWeight: FontWeight.bold,
                            fontSize: 18,color: Colors.white),),
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(25)
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )), viewModelBuilder: ()=> ProductsViewModel(),
      onModelReady: (model)=>model.getHistoryById(widget.id),);
  }
  /*

   */
  Widget _cardview(BuildContext ctx,Items item){
    return Card(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(ctx).size.width*0.05,
              child: Text(
                "${item.cant}",
                style: textStyleTitle,
              ),
            ),
            Container(
              width: MediaQuery.of(ctx).size.width*0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    style: textStyleTitle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                  Text(
                    item.subname,
                    style: textStyleSubTitle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(ctx).size.width*0.15,
              child: Text(
                "S/. ${item.price}",
                style: textStyleSubTitle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
