import 'package:daloouser/data/model/CategoriasModel.dart';
import 'package:daloouser/data/model/ListaProducItem.dart';
import 'package:daloouser/data/model/ServiceItem.dart';
import 'package:daloouser/data/network/NavigationService.dart';
import 'package:daloouser/src/widget/card/CardProductoItemService.dart';
import 'package:daloouser/src/widget/card/SearchCardItem.dart';
import 'package:daloouser/src/widget/spinner/Spinner.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:daloouser/viewModel/ProductsViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pagination/pagination.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';

import '../../../Locator.dart';

class ListaProductosPage extends StatefulWidget {
  String categoriaId;
  String idService;

  ListaProductosPage(this.categoriaId, this.idService);

  @override
  _ListaProductosPageState createState() => _ListaProductosPageState();
}

class _ListaProductosPageState extends State<ListaProductosPage> {
  CategoriasModel typeCategoria;
  final NavigationService _navigationService = locator<NavigationService>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductsViewModel>.reactive(
      viewModelBuilder: () => ProductsViewModel(),
      builder: (context, modelproduct, child) => Scaffold(
        body: _pagination(modelproduct),
      ),
    );
  }

//appBar: Visibility(
//                     child: AppBar(
//                       backgroundColor: Colors.white,
//                       iconTheme: null,
//                       elevation: 0,
//                       title: Visibility(
//                         visible: false,
//                         child: ViewModelBuilder<ProductsViewModel>.reactive(
//                             viewModelBuilder: () => ProductsViewModel(),
//                             onModelReady: (model) =>
//                                 model.getSubCategoriaSpinner(widget.categoriaId),
//                             builder: (context, model, child) => model.busy
//                                 ? Center(
//                               child: CircularProgressIndicator(),
//                             )
//                                 :Container(
//                               margin: EdgeInsets.only(left: 5),
//                               child: DropdownButton<CategoriasModel>(
//                                 value: typeCategoria!=null?typeCategoria:model.subcategoria[0],
//                                 icon: Icon(Icons.keyboard_arrow_down),
//                                 iconSize: 24,
//                                 elevation: 16,
//                                 style: TextStyle(color: primaryColor),
//                                 underline: Container(
//                                   height: 2,
//                                   color: Colors.deepPurpleAccent,
//                                 ),
//                                 onChanged: (CategoriasModel data ){
//                                   setState(() {
//                                     typeCategoria=data;
//                                     modelproduct.totalPaginasProducts = 0;
//                                     modelproduct.spinnerData=typeCategoria.id;
//                                     modelproduct.getProductsByCategory(0);
//                                   });
//
//                                 },
//                                 items: model.subcategoria
//                                     .map<DropdownMenuItem<CategoriasModel>>((CategoriasModel value) {
//                                   return DropdownMenuItem<CategoriasModel>(
//                                     value: value,
//                                     child: Text(value.name),
//                                   );
//                                 }).toList(),
//                               ),
//                             )
//                         ),
//                       ),
//                     ),
//                   ),
  Widget _pagination(ProductsViewModel modelproduct) {
    return PaginationList<ListaProductItem>(
            onLoading: _shimerProduct(modelproduct),
            itemBuilder: (_, service) {

              return GestureDetector(
                onTap: () {
                  _navigationService.navigateTo(PreviewProductViewRoute,arguments:service.sId);
                },
                child: CardProductoItemService(service),
              );
            },
            onError: (dynamic error) => Center(
                  child: Text("surgio un error"),
                ),
            onEmpty: Center(
              child: Text("Vacio"),
            ),
            pageFetch: modelproduct.getProductsByCategory)

//,String id "Restaurantes"
        ;
  }

  Widget _shimerProduct(ProductsViewModel modelproduct) {
    modelproduct.spinnerData = "";
    modelproduct.categoriaId = widget.idService;
    return Shimmer.fromColors(
        baseColor: Colors.white,
        highlightColor: Colors.black,
        child: Column(
          children: [
            SearchCardItem(
              model: ServiceItem(
                  "", "", "", "", "", "", true, true, "", "", "", "", 20),
            ),
            SearchCardItem(
              model: ServiceItem(
                  "", "", "", "", "", "", true, true, "", "", "", "", 20),
            ),
          ],
        ));
  }
}
