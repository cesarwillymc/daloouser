import 'package:carousel_slider/carousel_slider.dart';
import 'package:daloouser/data/model/CategoryModel.dart';
import 'package:daloouser/data/model/ListaProductosCategoria.dart';
import 'package:daloouser/data/network/NavigationService.dart';
import 'package:daloouser/src/widget/card/CardCategorias.dart';
import 'package:daloouser/src/widget/card/CardOfertas.dart';
import 'package:daloouser/src/widget/card/CardProductosMain.dart';
import 'package:daloouser/src/widget/card/SearchCardItem.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:daloouser/viewModel/ProductsViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../Locator.dart';
import 'CarritoPage.dart';

class TiendasPage extends StatefulWidget {
  @override
  _TiendasPageState createState() => _TiendasPageState();
}

class _TiendasPageState extends State<TiendasPage> {
  final NavigationService _navigationService = locator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    var listaWidges = [CardOfertas(), CardOfertas()];

    return new WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          floatingActionButton: FloatingActionButton.extended(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.white,
            ),
            label: Text(
              "Carrito",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: primaryColor,
            onPressed: () {
              _navigationService.navigateTo(MainScreenViewRoute,
                  arguments: CarritoPage());
            },
          ),
          backgroundColor: Colors.white,
          body: ListView(
            scrollDirection: Axis.vertical,
            children: [
              Flexible(
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Text(
                    "Lo que quieras \nDaloo",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
              Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: SizedBox(
                      height: 50,
                      child: ViewModelBuilder<ProductsViewModel>.reactive(
                          viewModelBuilder: () => ProductsViewModel(),
                          onModelReady: (model) => model.listenCategorias(),
                          builder: (context, model, child) => model.busy
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: model.categorias.length,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        if (index != 0) {
                                          CategoryModel modelo =
                                              model.categorias[index];
                                          locator<NavigationService>()
                                              .navigateTo(
                                                  PreviewCategoriaPageViewRoute,
                                                  arguments: [
                                                modelo.id,
                                                modelo.img,
                                                modelo.total.toString()
                                              ]);
                                        }
                                      },
                                      child: CardCategorias(
                                          selected: index == 0 ? true : false,
                                          model: model.categorias[index]),
                                    );
                                  })))),
              ViewModelBuilder<ProductsViewModel>.reactive(
                  viewModelBuilder: () => ProductsViewModel(),
                  onModelReady: (model) => model.listenPromociones(),
                  builder: (context, model, child) => model.busy
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Visibility(
                          visible: model.promociones.length != 0 ? true : false,
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.all(10),
                                child: Text("Ofertas",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ),
                              CarouselSlider.builder(
                                itemCount: listaWidges.length,
                                options: CarouselOptions(
                                    aspectRatio: 1.65, autoPlay: true),
                                itemBuilder: (BuildContext contx, int index) {
                                  return GestureDetector(
                                    child: listaWidges[index],
                                  );
                                },
                              ),
                            ],
                          ))),
              ViewModelBuilder<ProductsViewModel>.reactive(
                  viewModelBuilder: () => ProductsViewModel(),
                  onModelReady: (model) => model.getListProductswithService(),
                  builder: (context, model, child) => model.busy
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : Container(
                          child: Column(
                            children: model.servicewithservice
                                .map(_buildFoodsList)
                                .toList(),
                          ),
                        ))
            ],
          )),
    );
  }

  Widget _buildFoodsList(ListaProductosCategoria data) {
    return GestureDetector(
      onTap: () {},
      child: CardProductosMain(
        model: data,
      ),
    );
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
          context: context,
          builder: (context) => new AlertDialog(
            title: new Text('¿Estas seguro?'),
            content: new Text('¿quieres salir de la aplicacion?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: new Text('Si'),
              ),
            ],
          ),
        )) ??
        false;
  }
}
