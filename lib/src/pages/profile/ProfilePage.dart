
import 'package:daloouser/data/model/UsuarioModel.dart';
import 'package:daloouser/data/network/NavigationService.dart';
import 'package:daloouser/src/widget/card/CustomListTitle.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../../../Locator.dart';
import '../../../main.dart';

class ProfilePage extends StatefulWidget{
  @override
  _ProfilePageState createState() => _ProfilePageState();

}
class _ProfilePageState extends State<ProfilePage>{

  bool turnOnNotification=false;
  bool turnOnLocationTracking=false;
  UsuarioModel user;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(boxList[3].isNotEmpty){
      print("Usuario no vacio");
      setState(() {
        user= boxList[3].getAt(0);
        print("${boxList[3].getAt(0)}");
      });
    }
  }
  @override
  Widget build(BuildContext context) {


    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text("MI PERFIL",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      height: 120,
                      width: 120,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50),
                        boxShadow: [
                          BoxShadow(
                              blurRadius: 3,
                              offset: Offset(0,4),
                              color: Colors.black38
                          ),
                        ],
                        image: DecorationImage(
                          image: user!=null?NetworkImage(user.uriImgPerfil):AssetImage("assets/profile.png"),
                          fit: BoxFit.cover
                        )
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width*0.5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Flexible(child: Container(child: Text((user!=null)?"${user.name} ${user.lastName}":"Invitado", style: TextStyle(fontSize: 16),))),
                          SizedBox(height: 10,),
                          Flexible(child: Container(child: Text((user!=null)?user.address:"Invitado", style: TextStyle(color: Colors.blueGrey),))),
                          SizedBox(height: 20,),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 30,),
                Text("Account", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all( 16),
                    child: Column(
                      children: [
                        CustomListTitle(icon: Icons.location_on,title: "Ubicación"),
                        Divider(height: 10, color: Colors.blueGrey,),
                        CustomListTitle(icon: Icons.visibility,title: "Cambiar Contraseña"),
                        Divider(height: 10, color: Colors.blueGrey,),
                        CustomListTitle(icon: Icons.shopping_cart,title: "Historial de compras"),
                        Divider(height: 10, color: Colors.blueGrey,),
                        CustomListTitle(icon: Icons.payment,title: "Tipos de pago"),
                        Divider(height: 10, color: Colors.blueGrey,),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Text("Notificaciones", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Card(
                  elevation: 3,
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Habilitar notificaciones",style: TextStyle(fontSize: 16),),
                            Switch(value: turnOnNotification, onChanged: (bool value){
                              setState(() {
                                turnOnNotification=value;
                              });
                            },activeColor: Colors.blue,)
                          ],
                        ),
                        Divider(height: 10,color: Colors.blueGrey,),Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Ubicacion en segundo plano",style: TextStyle(fontSize: 16),),
                            Switch(value: turnOnLocationTracking, onChanged: (bool value){
                              setState(() {
                                turnOnLocationTracking=value;
                              });
                            },activeColor: Colors.blue,)
                          ],
                        ),
                        Divider(height: 10,color: Colors.blueGrey,)

                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Text("Otros", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                SizedBox(height: 20,),
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child:Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Lenguage", style: TextStyle(fontSize: 16),),
                          Divider(height: 30,color: Colors.blueGrey,),
                          GestureDetector(
                              onTap: (){
                                boxList[3].deleteAt(0);
                                shared.clear();
                                locator<NavigationService>().pop();
                              },
                              child: Text("Cerrar Sesion", style: TextStyle(fontSize: 16),)),
                          Divider(height: 10,color: Colors.blueGrey,),

                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}