import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:daloouser/data/model/CarritoModel.dart';
import 'package:daloouser/data/model/CarritoPriceModel.dart';
import 'package:daloouser/data/model/DataServiceCarritoModel.dart';
import 'package:daloouser/data/model/MapeoDepartamento.dart';
import 'package:daloouser/data/model/SendCarrito.dart';
import 'package:daloouser/data/model/UsuarioModel.dart';
import 'package:daloouser/data/network/NavigationService.dart';
import 'package:daloouser/src/widget/buttons/TipePriceCardInactive.dart';
import 'package:daloouser/src/widget/card/CardCarritoItem.dart';
import 'package:daloouser/src/widget/imput/InputField.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:daloouser/viewModel/ProductsViewModel.dart';
import 'package:flutter/material.dart';
import 'package:google_map_polyutil/google_map_polyutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:toast/toast.dart';

import '../../Locator.dart';
import '../../main.dart';
import 'TiendasPage.dart';

class CarritoPage extends StatefulWidget{
  @override
  _CarritoPageState createState() => _CarritoPageState();
}

class _CarritoPageState extends State<CarritoPage> {
  final NavigationService _navigationService = locator<NavigationService>();
  final textComentario = TextEditingController();


  //Datos Generales
  MapeoDepartamento mapeo;
  List<LatLng> polilyne = List<LatLng>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductsViewModel>.reactive(builder: (context,model,child)=>
        WatchBoxBuilder(
          box: boxList[2],
          builder: (_,box){
            var carrito= boxList[0];
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

                  print("RutasGoogle tamaño box data ${boxdata.length} ${carrito.isEmpty} ${boxList[4].isNotEmpty} ${usuario.isNotEmpty} ");
                  if(carrito.isEmpty){
                    if(boxList[4].isNotEmpty && usuario.isNotEmpty){
                      if((usuario.getAt(0) as UsuarioModel).longitude!=null){
                        DataServiceCarritoModel inicio=boxdata.getAt(0);
                        LatLng usuarioLatLong=LatLng((usuario.getAt(0) as UsuarioModel).latitude, (usuario.getAt(0) as UsuarioModel).longitude);
                        var acceso= getDirectionUrl(LatLng(inicio.latitude, inicio.longitude), usuarioLatLong);
                        var urlDefinitiva= puntosList(acceso);
                        model.obtenerNuevoPrecio(urlDefinitiva);
                      }else{
                        model.insertarPrecio(0.0);
                      }
                    }
                    model.insertarPrecio(0.0);
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
                      _buildtextCardContainer("Delivery",boxdata.isEmpty?"Sin productos":usuario.isEmpty?"Sin usuario":model.busy?"Cargando..":"S/. ${model.timeandDistance.toStringAsFixed(2)}"),
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
                                    Flexible(child: Container(child: AutoSizeText(boxList[3].isEmpty?"Sin Usuario":(boxList[3].getAt(0) as UsuarioModel).latitude==null?"Actualiza tu direccion":(boxList[3].getAt(0) as UsuarioModel).address,overflow: TextOverflow.ellipsis,)))
                                  ],
                                )
                              ],
                            ),
                          ),
                          GestureDetector(child: TipePriceCardInactive("ACTUALIZAR",false),onTap: (){
                            if(comprobarLogin()){
                              _navigationService.navigateTo(ubicacionViewRoute);
                            }
                          },)
                        ],
                      ),
                      GestureDetector(
                        onTap: () async {
                          if(comprobarLogin()){
                            bool datosComprobados= await comprobarTodosLosDatos();
                            if(datosComprobados){
                              UsuarioModel user= boxList[3].getAt(0);
                              showDialog(
                                context: context,
                                builder: (context) => new AlertDialog(
                                  title: new Text("Confirmar ubicación"),
                                  content: new Text("¿Tu ubicación  es: ${user.address}?"),
                                  actions: <Widget>[
                                    new FlatButton(
                                      onPressed: () =>    _navigationService.navigateTo(ubicacionViewRoute),
                                      child: new Text("No, deseo cambiarlo"),
                                    ),
                                    new FlatButton(
                                      onPressed: () async {
                                        CarritoPriceModel precio=carrito.getAt(0);
                                        List<CarritoModel> valores= boxList[4].values.toList();
                                        model.sendProductsCarrito(SendCarrito(textComentario.text,"visa",valores,precio.url)).listen((eventoo) {
                                          switch(eventoo.state){
                                            case  ResourceState.COMPLETE :
                                              if(eventoo.data as bool){
                                                Future.delayed(Duration(seconds: 5), () {
                                                  // 5s over, navigate to a new page
                                                  locator<NavigationService>().navigateToClearStack(MainScreenViewRoute,arguments: TiendasPage());
                                                });

                                              }else{
                                                //siguiente pestaña
                                              }
                                              break;
                                            case  ResourceState.ERROR :
                                              Toast.show(eventoo.exception, context);
                                              break;
                                            case ResourceState.LOADING:
                                              break;
                                          }
                                        });
                                      },
                                      child: new Text("Si continuar"),
                                    ),
                                  ],
                                ),
                              );
                            }
                          }
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
  Future<bool> comprobarTodosLosDatos() async {
    if (boxList[5].isNotEmpty) {
      mapeo = boxList[5].getAt(0);
    }
    UsuarioModel user= boxList[3].getAt(0);
    if (mapeo != null) {
      await Stream.fromIterable(jsonDecode(mapeo.mapa)).forEach((element) {
        polilyne.add(LatLng(double.parse(element["latitude"].toString()),
            double.parse(element["longitude"].toString())));
      });
    }
    if(boxList[2].isNotEmpty){
      if(user.latitude!=null){
        if(shared.getString(sharedPrefCARRITO_ID)??""!=""){

          if(mapeo!=null){
            bool result = await GoogleMapPolyUtil.containsLocation(
                point: LatLng(user.latitude, user.longitude), polygon: polilyne);
            if(result){
              return true;
            }else{
              Toast.show("No estas dentro de un rango para solicitar un pedido", context);
              return false;
            }
          }else{
            Toast.show("Al parecer no escogiste una zona ... para realizar el pedido", context);
            return false;
          }
        }else{
          Toast.show("Ya tienes un pedido en marcha", context);
          return false;
        }
      }else{
        Toast.show("Debes ingresar una ubicacion", context);
        return false;
      }
    }else{
      Toast.show("No tienes productos en el carrito", context);
      return false;
    }

  }
}

