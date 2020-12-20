import 'package:daloouser/data/network/NavigationService.dart';
import 'package:daloouser/src/widget/imput/InputField.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:daloouser/viewModel/ProductsViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:toast/toast.dart';

import '../../../Locator.dart';
import '../TiendasPage.dart';

class VerifyMessagePage extends StatefulWidget{
  String phone;
  VerifyMessagePage(this.phone);
  @override
  _VerifyMessagePageState createState() => _VerifyMessagePageState();
}

class _VerifyMessagePageState extends State<VerifyMessagePage> {
  final textCodeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProductsViewModel>.reactive(
      builder: (aaaaa, model, child) => SafeArea(
          child: model.busy
              ? Center(
            child: CircularProgressIndicator(),
          )
              : Scaffold(
            body: Container(
                margin: EdgeInsets.all(5),
                width: double.infinity,
                height: double.infinity,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          alignment: Alignment.centerLeft,
                          width: double.infinity,
                          child: Text(
                            "Verificacion Móvil",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 24),
                          )),
                      Text(
                        "Por favor, Ingrese su número de teléfono móvil para verificar su solicitud.",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                      SizedBox(height: 10,),
                      Container(
                          alignment: Alignment.centerLeft,
                          width: double.infinity,
                          child: Text(
                            "+51 ${widget.phone}",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 19),
                          )),
                      Container(
                          width:
                          MediaQuery.of(context).size.width * 0.7,
                          child: InputField(
                            controller: textCodeController,
                            textInputType: TextInputType.phone,
                            placeholder: "Código",
                            lines: 1,
                          )),
                      SizedBox(height: 10,),
                      Container(
                          width: MediaQuery.of(context).size.width*0.4,
                          padding: EdgeInsets.symmetric(vertical: 10),
                          margin: EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: GestureDetector(
                            onTap: (){
                              if(textCodeController.text.isNotEmpty ){
                                model.validateCodePhone(widget.phone,textCodeController.text).listen((eventoo) {
                                  switch(eventoo.state){
                                    case  ResourceState.COMPLETE :
                                      locator<NavigationService>().navigateToClearStack(MainScreenViewRoute,arguments: TiendasPage());
                                      break;
                                    case  ResourceState.ERROR :
                                      Toast.show(eventoo.exception, context);
                                      break;
                                    case ResourceState.LOADING:
                                      break;
                                  }
                                });
                              }else{
                                Toast.show("Ingrese un codigo correcto", context);
                              }
                            },
                            child: Center(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                        "VERIFICAR",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12)),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: Colors.white,
                                    ),
                                  ],
                                )
                            ),
                          ))
                    ])),
            appBar: AppBar(
              backgroundColor: primaryColor,
              title: Text(
                "INGRESAR NUMERO CELULAR",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
          )),
      viewModelBuilder: () => ProductsViewModel(),
    );
  }
}