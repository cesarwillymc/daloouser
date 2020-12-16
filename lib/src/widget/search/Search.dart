import 'package:daloouser/Locator.dart';
import 'package:daloouser/data/model/ServiceItem.dart';
import 'package:daloouser/data/network/NavigationService.dart';
import 'package:daloouser/main.dart';
import 'package:daloouser/src/widget/card/SearchCardItem.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:daloouser/viewModel/ProductsViewModel.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';

class Search extends SearchDelegate {
  final NavigationService _navigationService = locator<NavigationService>();
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  ServiceItem selectResult;

  @override
  Widget buildResults(BuildContext context) {
    return ViewModelBuilder<ProductsViewModel>.reactive(
        viewModelBuilder: () => ProductsViewModel(),
        onModelReady: (model) => model.listenToProductsSearch(query),
        builder: (context, model, child) => model.busy?Center(child: CircularProgressIndicator(),):
        ListView.builder(
            itemCount: model.searchProducts.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  var modelo=model.searchProducts[index];
                  _comprobarDatos(modelo);
                },
                child: SearchCardItem(model:model.searchProducts[index]),
              );
            })
    );

  }



  @override
  Widget buildSuggestions(BuildContext context) {

    return ViewModelBuilder<ProductsViewModel>.reactive(
        viewModelBuilder: () => ProductsViewModel(),
        onModelReady: (model) => model.listenToProductsSearch(query),
        builder: (context, model, child) => model.busy?Center(child: CircularProgressIndicator(),):
        ListView.builder(
            itemCount: model.searchProducts.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  var modelo=model.searchProducts[index];
                  _comprobarDatos(modelo);
                },
                child: SearchCardItem(model:model.searchProducts[index]),
              );
            })
    );
  }
  void _comprobarDatos(ServiceItem model)async{
    var box=boxList[1];
    print("aaaexiste key ${model.id}");
    bool encontrado=false;
    box.values.forEach((element) {
      if(element.id==model.id){
        print("existe key ${box.keys}");
        encontrado=true;
      }
    });
    if(!encontrado){
      print("no existe key ${encontrado}");
      if(box.length>10){
        box.deleteAt(0);
      }
      model.idNumber=box.length;
      box.add(model);

      if(model.isProduct){
        _navigationService.navigateTo(PreviewProductViewRoute,arguments:model.id);
      }else{
        _navigationService.navigateTo(PreviewServiceViewRoute,arguments:[model.categoryId,model.id]);
      }
    }else{
      print("existe key ${box.keys}");
      if(model.isProduct){
        _navigationService.navigateTo(PreviewProductViewRoute,arguments:model.id);
      }else{
        _navigationService.navigateTo(PreviewServiceViewRoute,arguments:[model.categoryId,model.id]);
      }
    }



  }
}
