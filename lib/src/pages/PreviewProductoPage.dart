import 'dart:ui';

import 'package:daloouser/data/model/CarritoModel.dart';
import 'package:daloouser/data/model/CarritoPriceModel.dart';
import 'package:daloouser/data/model/DataServiceCarritoModel.dart';
import 'package:daloouser/data/model/Prices.dart';
import 'package:daloouser/data/model/ProductoData.dart';
import 'package:daloouser/data/network/NavigationService.dart';
import 'package:daloouser/src/pages/CarritoPage.dart';
import 'package:daloouser/src/widget/appbars/AppBarMain.dart';
import 'package:daloouser/src/widget/buttons/TipePriceCardInactive.dart';
import 'package:daloouser/src/widget/card/CardIconItem.dart';
import 'package:daloouser/src/widget/search/Search.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:daloouser/utils/FunctionsUitls.dart';
import 'package:daloouser/viewModel/ProductsViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:stacked/stacked.dart';

import '../../Locator.dart';
import '../../main.dart';

class PreviewProductoPage extends StatefulWidget {
  final String idProduct;

  PreviewProductoPage(this.idProduct);

  @override
  _PreviewProductoPageState createState() => _PreviewProductoPageState();
}

class _PreviewProductoPageState extends State<PreviewProductoPage> {
  var indexItem = 0;
  var carritoBox=boxList[2];
  var dataService=boxList[4];
  Prices actualPrecio;
  final NavigationService _navigationService = locator<NavigationService>();
  @override
  Widget build(BuildContext context) {

    //var texto =
    //  "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBarMain(
            searchpressed: (){
              setState(() {
                showSearch(context: context, delegate: Search());
              });
            },
            isVisibleLocation: true,
            titulo: "Producto",

          ),
          body: ViewModelBuilder<ProductsViewModel>.reactive(
            viewModelBuilder: () => ProductsViewModel(),
            onModelReady: (model) => model.getProductByID(widget.idProduct),
            builder: (context, model, child) => model.busy
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * 0.82,
                          child: SingleChildScrollView(
                            child: Column(
                              children: [
                                Container(
                                  height: 200,
                                  width: double.maxFinite,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(BASE_URL_AMAZON_IMG +
                                          model.productData.img),
                                      fit: BoxFit.fitWidth,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    //,// make sure we apply clip it properly
                                    child: BackdropFilter(
                                      filter:
                                          ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                                      child: Container(
                                        alignment: Alignment.center,
                                        color: Colors.blueGrey.withOpacity(0.1),
                                        child: Image.network(BASE_URL_AMAZON_IMG +
                                            model.productData.img),
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.all(10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                        child: Container(
                                          child: Text(
                                            model.productData.itemname,
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 22,
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,),
                                          ),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "s/.",
                                            style: TextStyle(
                                                color: primaryColor,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                              model.productData.prices[indexItem]
                                                  .price
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 22,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin:
                                          EdgeInsets.only(right: 15, left: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: primaryColor,
                                                size: 20,
                                              ),
                                              Text("${random(3, 5)}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 15,
                                                    color: Colors.black,
                                                  )),
                                            ],
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.timer,
                                                color: Colors.redAccent,
                                                size: 20,
                                              ),
                                              Text(model.productData.timePrepare,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 15,
                                                      color: Colors.black))
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        CardIconItem(
                                            onTap: () {
                                              setState(() {
                                                if (_increment != 1) {
                                                  _increment -= 1;
                                                }
                                              });
                                            },
                                            icon: Icons.remove,
                                            isBlue: false),
                                        Text(
                                          "$_increment",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        CardIconItem(
                                            onTap: () {
                                              setState(() {
                                                _increment += 1;
                                              });
                                            },
                                            icon: Icons.add,
                                            isBlue: true),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 5),
                                  child: Text(
                                    model.productData.prices[indexItem].desc
                                                .length <
                                            5
                                        ? model.productData.description
                                        : model
                                            .productData.prices[indexItem].desc,
                                    style: TextStyle(color: Colors.black),
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(vertical: 10),
                                  child: GridView.builder(
                                      shrinkWrap: true,
                                      itemCount: model.productData.prices.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              childAspectRatio: 8 / 2),
                                      itemBuilder: (_, index) => GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                indexItem = index;
                                                actualPrecio= model.productData
                                                    .prices[index];
                                              });
                                            },
                                            child: TipePriceCardInactive(
                                                model.productData
                                                    .prices[index].name,
                                                indexItem == index
                                                    ? true
                                                    : false),
                                          )),
                                )
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if(actualPrecio==null){
                              print("previewProduct actual Precio Vacio");
                              actualPrecio=model.productData
                                  .prices[0];
                            }
                            _settingModalBottonSheep(context);
                            if(dataService.isNotEmpty){
                              List<DataServiceCarritoModel> respuesta=dataService.values.where((element) => (element).id==model.productData.serviceId).toList();
                              print("previewProduct respuesta $respuesta ");
                              if( respuesta.isEmpty){
                                var modelo =DataServiceCarritoModel(model.productData.serviceId,model.productData.longitude,model.productData.latitude,model.productData.servicename);
                                dataService.add(modelo);
                                boxList[0].deleteAt(0);
                                _saveProductCar(model.productData);
                              }else{
                                print("previewProduct no esta vacio ");
                                _saveProductCar(model.productData);
                              }
                            }else{
                              print("previewProduct data servie no esta vacio ");
                              var modelo =DataServiceCarritoModel(model.productData.serviceId,model.productData.longitude,model.productData.latitude,model.productData.servicename);
                              dataService.add(modelo);
                              try{
                                boxList[0].deleteAt(0);
                              }catch(e){}
                              _saveProductCar(model.productData);
                            }


                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width * 0.8,
                            height: 50,
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(20)),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20,
                                ),
                                Icon(
                                  Icons.shopping_cart,
                                  color: Colors.white,
                                  size: 35,
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                Text(
                                  "AÑADIR AL CARRITO",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
          )),
    );

  }
  void _saveProductCar(ProductoData model) {
    print("previewProduct data servie no esta vacio entro save product ");
    CarritoModel elemento;
    int llave;
    carritoBox.toMap().forEach((key, value) {
      if(widget.idProduct==value.id_Product&&  actualPrecio.id==value.id_Precio){
        elemento=value;
        llave=key;
      }
    });
    //List<CarritoModel> producto=carritoBox.values.where((element) => widget.idProduct==element.id_Product&&  actualPrecio.id==element.id_Precio);
    if(elemento==null){
      elemento=CarritoModel(model.serviceId,widget.idProduct,actualPrecio.id,model.servicename,_increment,model.itemname,actualPrecio.name,model.img,actualPrecio.price*_increment,actualPrecio.price);
      carritoBox.add(elemento);
    }else{
      elemento.cantidad +=_increment;
      elemento.precioTotal=elemento.precioUnitari * elemento.cantidad;
        carritoBox.put(llave, elemento);
    }

  }
  int _increment = 1;

  void _settingModalBottonSheep(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        backgroundColor: Colors.black,
        context: context,
        builder: (BuildContext bc) {
          return GestureDetector(
            onTap: () {
              //  Navigator.of(context).pushReplacement(MaterialPageRoute(
              //                            builder: (BuildContext context) => OrderPage()));
               _navigationService.navigateTo(MainScreenViewRoute,arguments:CarritoPage());
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: Center(
                child: Text(
                  "V E R CA R R I T O",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
        });

  }

}


