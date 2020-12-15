import 'package:daloouser/data/model/ComentariosModel.dart';
import 'package:daloouser/src/widget/ratingList.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardComentario extends StatelessWidget {
  ComentariosModel model;

  CardComentario(this.model);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 10),
      child:
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10,horizontal: 5),
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Image.network(
                    model.userId.uriImgPerfil,
                    width: 40,
                    height: 40,
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width*0.6,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${model.userId.name} ${model.userId.lastName}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                    ),
                                    ratingList(
                                      model.start,
                                      2,
                                      isLine: true,
                                    )
                                  ],
                                ),
                              ),
                              Flexible(
                                child: Container(
                                  width: MediaQuery.of(context).size.width*0.3,
                                  child: Text(
                                    "${model.createAt}",
                                    style: TextStyle(color: Colors.grey,fontSize: 12),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Text(
                          "${model.coment}",
                          style: TextStyle(color: Colors.black),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                      ],
                    ),
                  )
                ],
              ),

          ),


    );
  }
}
