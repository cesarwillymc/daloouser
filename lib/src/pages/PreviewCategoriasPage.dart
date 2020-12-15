import 'package:daloouser/data/model/ServiceItem.dart';
import 'package:daloouser/data/model/ServiceModel.dart';
import 'package:daloouser/data/network/NavigationService.dart';
import 'package:daloouser/src/widget/card/CardCategorias.dart';
import 'package:daloouser/src/widget/card/SearchCardItem.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:daloouser/viewModel/ProductsViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pagination/pagination.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';

import '../../Locator.dart';

class PreviewCategoriasPage extends StatefulWidget{
  String title;
  String img;
  String total;
  PreviewCategoriasPage(this.title,this.img,this.total);
  @override
  _PreviewCategoriasPageState createState() => _PreviewCategoriasPageState();
}

class _PreviewCategoriasPageState extends State<PreviewCategoriasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(widget.title, style: TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),),
        actions: [
          Container(
            alignment: Alignment.center,
            child: Text("${widget.total} ${widget.title}  ",
              style: TextStyle(fontSize: 18, color: Colors.black),),
          )
        ],
      ),

      body: _pagination(),

    );
  }
  Widget _pagination() {

    return ViewModelBuilder<ProductsViewModel>.reactive(
        viewModelBuilder: () => ProductsViewModel(),
        builder: (context, model, child) =>
            PaginationList<ServiceModel>(
              itemBuilder: (_, service) {

                return GestureDetector(
                  onTap: () {
                    locator<NavigationService>().navigateTo(PreviewServiceViewRoute,arguments: [service.categoriaId,service.id]);
                  },
                  child: SearchCardItem(
                      model: ServiceItem(
                          service.category,
                          service.id,
                          service.id,
                          service.imagen,
                          service.name,
                          service.address,
                          service.isOpen,
                          false,
                          service.ratingNumber,
                          service.categoriaId,
                          service.categoriaId,
                          service.name,
                          0)),
                );
              },
              onError: (dynamic error) =>
                  Center(
                    child: Text('${error.toString()}'),
                  ),
              onEmpty: Center(
                child: Text('Empty List'),
              ),
              onLoading: _shimerProduct(model),
              pageFetch: model.getServicesByCategory,
//,String id "Restaurantes"
            )
    );
  }

  Widget _shimerProduct(ProductsViewModel model){
    model.categoriaId=widget.title;
    return Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.black,
        child: Column(
          children: [
            SearchCardItem(model: ServiceItem("","","","","","",true,true,"","","","",20),),
            SearchCardItem(model: ServiceItem("","","","","","",true,true,"","","","",20),),
            SearchCardItem(model: ServiceItem("","","","","","",true,true,"","","","",20),),
            SearchCardItem(model: ServiceItem("","","","","","",true,true,"","","","",20),)
          ],
        )
    );
  }
}