import 'package:auto_size_text/auto_size_text.dart';
import 'package:daloouser/data/model/CarritoModel.dart';
import 'package:daloouser/data/model/CarritoPriceModel.dart';
import 'package:daloouser/data/model/DataServiceCarritoModel.dart';
import 'package:daloouser/data/model/UsuarioModel.dart';
import 'package:daloouser/data/network/NavigationService.dart';
import 'package:daloouser/src/widget/buttons/TipePriceCardInactive.dart';
import 'package:daloouser/src/widget/card/CardCarritoItem.dart';
import 'package:daloouser/src/widget/imput/InputField.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:daloouser/viewModel/ProductsViewModel.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked/stacked.dart';

import '../../Locator.dart';
import '../../main.dart';

class CarritoPage extends StatefulWidget{
  @override
  _CarritoPageState createState() => _CarritoPageState();
}

class _CarritoPageState extends State<CarritoPage> {
  final NavigationService _navigationService = locator<NavigationService>();
  final textComentario = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductsViewModel>.reactive(builder: (context,model,child)=>
        WatchBoxBuilder(
          box: boxList[2],
          builder: (_,box){
            var subtotal=0.0;

            box.values.toList().forEach((element) {
              subtotal+=(element as CarritoModel).precioTotal;
            });

            return Scaffold(
              backgroundColor: Colors.white,

              body:ListView.builder(
                itemCount: box.length,

                itemBuilder: (BuildContext context, int index){
                  return CardCarritoItem(
                    index,
                     box.getAt(index),
                  );
                },
                padding: EdgeInsets.only(top:10,left: 20,right: 20),
                scrollDirection: Axis.vertical,

              ),
              bottomNavigationBar: ValueListenableBuilder(
                valueListenable: boxList[4].listenable(),
                builder: (context4,boxdata,widget){

                  var usuario= boxList[3];
                  var carrito= boxList[0];
                  print("RutasGoogle tamaño box data ${boxdata.length} ${carrito.isEmpty} ${boxList[4].isNotEmpty} ${usuario.isNotEmpty} ");
                  if(carrito.isEmpty){
                    if(boxList[4].isNotEmpty && usuario.isEmpty){
                      DataServiceCarritoModel inicio=boxdata.getAt(0);
                      LatLng usuario=LatLng(-15.822938, -70.014297);
                      var acceso= getDirectionUrl(LatLng(inicio.latitude, inicio.longitude), usuario);
                      var urlDefinitiva= puntosList(acceso);
                      model.obtenerNuevoPrecio(urlDefinitiva);
                    }
                  }else{
                    model.insertarPrecio(carrito.getAt(0).Precio);
                  }
                 // if(boxdata.)
                  return Column(
                    mainAxisSize:  MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(child: Container(margin: EdgeInsets.only(bottom: 5), child: Text("¿Algo mas que quiera agregar a su pedido?",overflow: TextOverflow.ellipsis,))),
                      InputField(controller: textComentario, placeholder: "Comentario",lines: 3,),

                      _buildtextCardContainer("Sub Total","S/. ${subtotal.toStringAsFixed(2)}"),
                      Divider(height: 20,color: Colors.blueGrey,),
                      SizedBox(height: 5,),
                      _buildtextCardContainer("Delivery",boxdata.isEmpty?"Sin productos":usuario.isNotEmpty?"Sin usuario":model.busy?"Cargando..":"S/. ${model.timeandDistance.toStringAsFixed(2)}"),
                      SizedBox(height: 5,),
                      Divider(height: 20,color: Colors.blueGrey,),
                      _buildtextCardContainer("TOTAL",model.timeandDistance==null?"S/. $subtotal":"S/. ${(subtotal+model.timeandDistance).toStringAsFixed(2)}",isBol: true),
                      SizedBox(height: 5,),
                      Divider(height: 20,color: Colors.blueGrey,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width*0.55,
                            margin: EdgeInsets.only(left: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,

                              children: [
                                Text("Entrega en:"),
                                Row(
                                  children: [
                                    Icon(Icons.location_on,color: primaryColor,),
                                    Flexible(child: Container(child: AutoSizeText("Jiron Selva Alegre con luis rivarola miranda",overflow: TextOverflow.ellipsis,)))
                                  ],
                                )
                              ],
                            ),
                          ),
                          TipePriceCardInactive("ACTUALIZAR",false)
                        ],
                      ),
                      GestureDetector(
                        onTap: () {
                          /* if(user){
                          Toast.show("Logeado", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                        }else{
                          Toast.show("sin logeo", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
                          _navigationService.navigateTo(LoginViewRoute);
                        }*/
                        },
                        child: Center(
                          child: Container(
                            height: 50,
                            width: MediaQuery.of(context).size.width*0.8,
                            alignment: Alignment.center,
                            child: Text("REALIZAR PEDIDO",style: TextStyle(fontWeight: FontWeight.bold,
                                fontSize: 18,color: Colors.white),),
                            decoration: BoxDecoration(
                                color: primaryColor,
                                borderRadius: BorderRadius.circular(25)
                            ),
                          ),
                        ),
                      )

                    ],
                  );
                },
              ),

            );
          },
        )
        , viewModelBuilder: ()=> ProductsViewModel());
  }
  Widget _buildtextCardContainer(String name, String price,{bool isBol=false}){
    var textStyleTitle= TextStyle(fontSize: 16,fontWeight: isBol?FontWeight.bold: FontWeight.normal,color: primaryColor);
    var textStyleSubTitle=TextStyle(fontSize: 16,fontWeight: isBol?FontWeight.bold: FontWeight.normal,color: Colors.black);
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name,style: textStyleTitle,),
          Text("$price",style: textStyleSubTitle,),
        ],
      ),
    );
  }
}