import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daloouser/data/model/UsuarioModel.dart';
import 'package:daloouser/data/network/NavigationService.dart';
import 'package:daloouser/src/widget/card/CardRiderActive.dart';
import 'package:daloouser/src/widget/card/CardRiderServiceFirebase.dart';
import 'package:daloouser/src/widget/card/CardServicesFirebase.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:daloouser/viewModel/ProductsViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:stacked/stacked.dart';
import 'package:toast/toast.dart';

import '../../Locator.dart';
import '../../main.dart';

class MiPedidoPage extends StatefulWidget {
  @override
  _MiPedidoPageState createState() => _MiPedidoPageState();
}

class _MiPedidoPageState extends State<MiPedidoPage> {
  bool acceso = false;
  QuerySnapshot servicesList;
  DocumentSnapshot infoOrder;
  //Snapshots

  StreamSubscription<QuerySnapshot> ordenesServiceSuscribe;
  StreamSubscription<DocumentSnapshot> ordenesSuscribe;
  StreamSubscription<DocumentSnapshot> querySuscribe;


  @override
  void initState() {
    UsuarioModel usuario;

    if (boxList[3].isNotEmpty) {
      usuario = boxList[3].getAt(0);
      querySuscribe = FirebaseFirestore.instance
          .collection("SettingsAccount")
          .doc("User")
          .collection("Config")
          .doc(usuario.idUser).snapshots().listen((event) {
        if (event.exists) {
          var stateOrder = event.get("stateorder") as bool;
          var idOrder = event.get("idorder") as String;
          if (stateOrder ?? false) {
            DocumentReference ordenes =
            FirebaseFirestore.instance.collection("ordenes3").doc(idOrder);
            CollectionReference ordenesServices = FirebaseFirestore.instance
                .collection("ordenes3")
                .doc(idOrder)
                .collection("services");
            _onLoadData(ordenesServices, ordenes);
            setState(() {
              acceso = true;
            });
            shared.setString(sharedPrefCARRITO_ID, idOrder);
          } else {
            acceso = false;
            shared.remove(sharedPrefCARRITO_ID);
          }
        }
      });
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    var textStyleTitle = TextStyle(
        fontSize: 16, fontWeight: FontWeight.bold, color: primaryColor);
    var textStyleSubTitle = TextStyle(
        fontSize: 16, fontWeight: FontWeight.normal, color: Colors.black);
    return acceso
        ?infoOrder==null?Center(child: CircularProgressIndicator(),) : Scaffold(
            backgroundColor: Colors.white,
            body: ListView(
              scrollDirection: Axis.vertical,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/loadingdaloo.png",
                      width: 40,
                      height: 40,
                    ),
                    Text(
                      infoOrder.get("estadoText").toString() ?? "no cargo",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                  child: Text(
                    "Tiempo Estimado de Entrega",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Center(
                    child: Text(
                  infoOrder.get("timeEstimade") ?? "no cargo",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
                )),
                Text(
                  "Total a pagar:",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
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
                          "S/. ${infoOrder.get("precioTotal")}",
                          style: textStyleSubTitle,
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  children:
                      servicesList.docs.map(_carritoBoundPrivate).toList(),
                ),
              ],
            ),
            bottomNavigationBar: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  infoOrder.get("rider_accept") ?? false
                      ? "Tu Daloo Rider"
                      : "Sin Daloo Rider",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                Visibility(
                    visible: infoOrder.get("rider_accept") ?? false,
                    child: CardRiderServiceFirebase(infoOrder)),
                Visibility(
                    visible: infoOrder.get("rider_accept") ?? false,
                    child: Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        margin: EdgeInsets.symmetric(vertical: 4),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FloatingActionButton(
                              onPressed: () {
                                locator<NavigationService>().navigateTo(
                                    ubicacionTimeRealViewRoute,
                                    arguments: infoOrder.get("idRider"));
                              },
                              child: Icon(
                                Icons.location_on,
                                color: Colors.white,
                              ),
                              backgroundColor: primaryColor,
                            ),
                            GestureDetector(
                              onTap: () {
                                locator<NavigationService>().navigateTo(
                                    ubicacionTimeRealViewRoute,
                                    arguments: infoOrder.get("idRider"));
                              },
                              child: Card(
                                color: primaryColor,
                                child: Container(
                                    padding: EdgeInsets.all(15),
                                    child: Center(
                                      child: Text(
                                        "Ubicacion",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    )),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                ViewModelBuilder<ProductsViewModel>.reactive(
                    builder: (context, model, child) => Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () async {
                                await showDialog(context: context,builder:(llllll)=>_preguntarAcceso(
                                    "¿Recibiste tu pedido?",
                                    "Si recibiste el pedido dale a si para terminarlo.",llllll) ).then((value){
                                  if (value) {
                                    model.terminarPedido().listen((event) {
                                      switch (event.state) {
                                        case ResourceState.COMPLETE:
                                          Toast.show(
                                              "Pedido terminado correctamente",
                                              context,
                                              duration: 5);
                                          _comentariosRating(model);
                                          break;
                                        case ResourceState.ERROR:
                                          Toast.show(event.exception, context);
                                          break;
                                        case ResourceState.LOADING:
                                          break;
                                      }
                                    });
                                  } else {
                                    return false;
                                  }
                                });



                              },
                              child: Card(
                                color: primaryColor,
                                child: Container(
                                    padding: EdgeInsets.all(15),
                                    child: Center(
                                      child: Text(
                                        "Recibi el pedido",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ),
                                    )),
                              ),
                            ),
                            Visibility(
                              visible: mostrarTerminarPedido,
                              child: GestureDetector(
                                onTap: () async {
                                  await showDialog(context: context,builder:(llllll)=>_preguntarAcceso(
                                      "¿Desea Cancelar?",
                                      "Si cancela se perdera su pedido ¿Desea continuar?",llllll) ).then((value){
                                    if (value) {
                                      model.cancelarPedido().listen((event) {
                                        switch (event.state) {
                                          case ResourceState.COMPLETE:
                                            Toast.show(
                                                "Pedido cancelado correctamente",
                                                context,
                                                duration: 5);

                                            break;
                                          case ResourceState.ERROR:
                                            Toast.show(event.exception, context);
                                            break;
                                          case ResourceState.LOADING:
                                            break;
                                        }
                                      });
                                    }});


                                },
                                child: Card(
                                  color: Colors.red,
                                  child: Container(
                                      padding: EdgeInsets.all(15),
                                      child: Center(
                                          child: Text(
                                        "Cancelar",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 16),
                                      ))),
                                ),
                              ),
                            )
                          ],
                        ),
                    viewModelBuilder: () => ProductsViewModel())
              ],
            ),
          )
        : SafeArea(
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
                  "No tienes ningun pedido en marcha",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: primaryColor),
                ),
              ],
            ),
          ));
  }
  @override
  void dispose() {
    try{
      querySuscribe.cancel();
      ordenesServiceSuscribe.cancel();
      ordenesSuscribe.cancel();
    }catch(e){}
    super.dispose();
  }
  void _comentariosRating(ProductsViewModel model)  {
    bool llenoRider=false;
    bool llenoService=false;
    AlertDialog(
      title: Center(
        child: Text('Califica al  servicio'),
      ),
      content: Column(
        children: [
          Text(
            "Califica a tus tiendas",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          RatingBar.builder(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) async {

              model.calificarRiderAndService(rating, false).listen((event) {
                switch (event.state) {
                  case ResourceState.COMPLETE:
                    llenoService=true;
                    if(llenoRider){
                      Navigator.of(context).pop;
                    }

                    break;
                  case ResourceState.ERROR:
                    Toast.show(event.exception, context);
                    break;
                  case ResourceState.LOADING:
                    break;
                }

              });

            },
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            "Califica a tu Rider",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          RatingBar.builder(
            initialRating: 3,
            minRating: 1,
            direction: Axis.horizontal,
            allowHalfRating: true,
            itemCount: 5,
            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
            onRatingUpdate: (rating) {
              model.calificarRiderAndService(rating, true).listen((event) {
                switch (event.state) {
                  case ResourceState.COMPLETE:
                    llenoRider=true;
                    if(llenoService){
                      Navigator.of(context).pop;
                    }
                    break;
                  case ResourceState.ERROR:
                    Toast.show(event.exception, context);
                    break;
                  case ResourceState.LOADING:
                    break;
                }

              });

            },
          ),
        ],
      ),
      actions: <Widget>[
        FlatButton(
          child: Text('OMITIR',style: TextStyle(color: primaryColor,fontWeight: FontWeight.bold),),
          onPressed: Navigator.of(context).pop,
        ),

      ],
    );
  }

  Widget _carritoBoundPrivate(QueryDocumentSnapshot doc) {
    return CardServicesFirebase(doc);
  }

  void _onLoadData(

      CollectionReference ordenesServices, DocumentReference ordenes) {
    ordenesSuscribe=ordenes.snapshots().listen((event) {
      if (event.exists) {


        bool estado = true;
        if (!(event.get("servicio_accept") as bool)) {
          setState(() {
            mostrarTerminarPedido = true;
          });
        }
        if (event.get("order_cancel") as bool) {
          setState(() {
            estado = false;
          });

        }

        setState(() {
        //  mostrarTerminarPedido = mostrar;
          acceso = estado;
          infoOrder = event;
        });
      }
    });
    ordenesServiceSuscribe=ordenesServices.snapshots().listen((event) {
      if (event.docs.isNotEmpty) {
        setState(() {
          servicesList = event;
        });
      }
    });
    bool inicio=false;
    if(infoOrder!=null){

      if(!inicio){
        shared.setInt(
            sharedPREF_TIME_PEDIDO, DateTime.fromMillisecondsSinceEpoch((infoOrder.get("hora") as Timestamp).millisecondsSinceEpoch).millisecond);
        inicio=!inicio;
        _setCronometro();
      }

    }
  }

  Widget _preguntarAcceso(String titulo, String subtitle,BuildContext llllll)  {
    return AlertDialog(
        title: new Text(titulo),
        content: new Text(subtitle),
        actions: <Widget>[
          new FlatButton(
            onPressed: () {
              Navigator.pop(llllll, false);
            },
            child: new Text("No"),
          ),
          new FlatButton(
            onPressed: ()  {
              Navigator.pop(llllll, true);
            },
            child: new Text("Si"),
          )
        ]);

  }

  Timer cronometro;
  bool mostrarTerminarPedido = false;

  void _setCronometro() {
    const oneSec = const Duration(seconds: 5);
    cronometro = new Timer.periodic(oneSec, (Timer t) {
      int time = shared.getInt(sharedPREF_TIME_PEDIDO);
      int diferencia = DateTime.now().millisecond - time;
      var seconds = diferencia / 1000;
      var minutes = seconds / 60;
      var hours = minutes / 60;
      var days = hours / 24;
      print("$seconds $minutes $hours $days");
      setState(() {
        if (days != 0) {
          mostrarTerminarPedido = true;
        } else {
          mostrarTerminarPedido = hours >= 1;
        }
      });
    });
  }
}
