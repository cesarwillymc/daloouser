import 'package:daloouser/data/model/CarritoModel.dart';
import 'package:daloouser/data/model/CarritoPriceModel.dart';
import 'package:daloouser/data/model/DataServiceCarritoModel.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';

import '../../../main.dart';
import 'CardIconItem.dart';

class CardCarritoItem extends StatelessWidget {
  int index;
  CarritoModel model;
  CardCarritoItem(this.index,this.model);
  var carritoBox=Hive.box<CarritoModel>(carritoBOXHIVE);
  var dataService=Hive.box<DataServiceCarritoModel>(dataServiceBOXHIVE);
  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      secondaryActions: [
        IconSlideAction(
          caption: 'Todo',
          color: Colors.red,
          icon: Icons.delete_forever_sharp,
          onTap: () {
            carritoBox.deleteFromDisk();
            dataService.deleteFromDisk();
            boxList[0].deleteAll(boxList[0].keys);
          },
        ),
        IconSlideAction(
          caption: 'Este',
          color: Colors.red,
          icon: Icons.delete,
          onTap: () {
            carritoBox.deleteAt(index);
            var datos=carritoBox.values.where((element) => element.idServicio==model.idServicio);
            if(datos.isEmpty){
              dataService.toMap().forEach((key, value) {
                if(value.id==model.idServicio){
                  dataService.delete(key);
                  boxList[0].deleteAll(boxList[0].keys);
                }
              });
            }
          }
        ),
      ],
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 1, vertical: 2),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.blueGrey, blurRadius: 3, offset: Offset(0, 2))
            ]),
        child: Padding(
          padding: EdgeInsets.all(2),
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 80,
                  height: 80,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(BASE_URL_AMAZON_IMG+model.imgUrl),
                          fit: BoxFit.cover)),
                ),
                Flexible(
                  child: Container(

                    padding: EdgeInsets.only(left: 10),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(

                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width*0.48,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    model.name,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  Text(
                                   model.subName,
                                    style: TextStyle(
                                        color: primaryColor, fontSize: 10),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  size: 40,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  carritoBox.deleteAt(index);
                                  var datos=carritoBox.values.where((element) => element.idServicio==model.idServicio);
                                  if(datos.isEmpty){
                                    dataService.toMap().forEach((key, value) {
                                      if(value.id==model.idServicio){
                                        dataService.delete(key);
                                        boxList[0].deleteAll(boxList[0].keys);
                                      }
                                    });
                                  }
                                })
                          ],
                        ),
                        Text(
                          model.nameService,
                          style: TextStyle(color: Colors.grey, fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "s/.",
                                  style: TextStyle(
                                      color: primaryColor, fontSize: 10),
                                ),
                                Text(model.precioUnitari.toString(),
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CardIconItem(
                                    onTap: () {
                                      if(model.cantidad!=1){
                                        var modelo= model;
                                        modelo.cantidad-=1;
                                        modelo.precioTotal-=modelo.precioUnitari;
                                        carritoBox.putAt(index, modelo);
                                      }
                                    },
                                    icon: Icons.remove,
                                    isBlue: false),
                                Text(
                                  model.cantidad.toString(),
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                CardIconItem(
                                    onTap: () {
                                      var modelo= model;
                                      modelo.cantidad+=1;
                                      modelo.precioTotal+=modelo.precioUnitari;
                                      carritoBox.putAt(index, modelo);
                                    }, icon: Icons.add, isBlue: true),
                              ],
                            ),
                          ],
                        )
                      ],
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
