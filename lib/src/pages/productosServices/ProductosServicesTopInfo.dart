import 'package:daloouser/data/model/ServiceModel.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductosServicesTopInfo extends StatelessWidget{
  ServiceModel infoService;
  ProductosServicesTopInfo(this.infoService);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        image: DecorationImage(
            fit: BoxFit.cover,
          image: NetworkImage(
            BASE_URL_AMAZON_IMG+infoService.imagen,
          ),
        )
      ),
      child:Container(
        child: Stack(
          children: [
            Container(
              height: 200,
              decoration:  BoxDecoration(
                gradient:  LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black54,
                    ],
                    stops: [0.0, 1.0],
                    tileMode: TileMode.clamp,
                    begin: const FractionalOffset(0, 0),
                    end: const FractionalOffset(0, 1),)

              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(infoService.name,style:  TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.bold),),
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.white,),
                      Text(infoService.address,style:  TextStyle(color: Colors.white,fontSize: 13))
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.star,color: Colors.yellow,),
                      Text(infoService.ratingNumber,style:  TextStyle(color: Colors.white,fontSize: 13)),
                      Text("(257 reviews)",style:  TextStyle(color: Colors.white,fontSize: 13))
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}