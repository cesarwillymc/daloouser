import 'package:daloouser/src/widget/card/CardRiderActive.dart';
import 'package:daloouser/src/widget/card/CardServicesFirebase.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:flutter/material.dart';

class MiPedidoPage extends StatefulWidget{
  @override
  _MiPedidoPageState createState() => _MiPedidoPageState();
}

class _MiPedidoPageState extends State<MiPedidoPage> {
  @override
  Widget build(BuildContext context) {
    var textStyleTitle= TextStyle(fontSize: 16,fontWeight: FontWeight.bold,color: primaryColor);
    var textStyleSubTitle=TextStyle(fontSize: 16,fontWeight: FontWeight.normal,color: Colors.black);
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        scrollDirection: Axis.vertical,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
            Image.asset("assets/loadingdaloo.png",width: 40,height: 40,),
            Text("Tu daloo  Rider esta en camino",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)
          ],),
          SizedBox(height: 10,),
          Center(
            child: Text("Tiempo Estimado de Entrega",style: TextStyle(fontSize: 18),),
          ),
          SizedBox(height: 10,),
          Center(child: Text("30 a 40 minutos",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 26),)),
          Text("Total a pagar:",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
          Card(

            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total",style: textStyleTitle,),
                  Text("S/. 20.0",style: textStyleSubTitle,),
                ],
              ),
            ),
          )
        ],
      ),
      bottomNavigationBar: Column(
        mainAxisSize:  MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Sin Daloo Rider",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
          Visibility(child: CardServicesFirebase()),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Card(
                color: primaryColor,
                child: Container(
                  padding: EdgeInsets.all(15),
                    child: Center(child: Text("Recibi el pedido",style: TextStyle(color: Colors.white,fontSize: 16),),)),
              ),
              Card(
                color: Colors.red,
                child: Container(
                    padding: EdgeInsets.all(15),
                    child: Center(child: Text("Cancelar",style: TextStyle(color: Colors.white,fontSize: 16),))),
              )
            ],
          )
        ],
      ),
    );
  }
}