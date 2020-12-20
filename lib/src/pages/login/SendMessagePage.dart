import 'package:daloouser/data/network/NavigationService.dart';
import 'package:daloouser/src/widget/imput/InputField.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:daloouser/viewModel/ProductsViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:toast/toast.dart';

import '../../../Locator.dart';

class SendMessagePage extends StatefulWidget {
  @override
  _SendMessagePageState createState() => _SendMessagePageState();
}

class _SendMessagePageState extends State<SendMessagePage> {
  final textPhoneController = TextEditingController();

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
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/peru.png",
                            width:
                            MediaQuery.of(context).size.width * 0.1,
                            height: 50,
                          ),
                          Container(
                              width: MediaQuery.of(context).size.width *
                                  0.1,
                              child: Text(
                                "+51 ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                                textAlign: TextAlign.justify,
                              )),
                          Container(
                              width:
                              MediaQuery.of(context).size.width * 0.7,
                              child: InputField(
                                textInputType: TextInputType.phone,
                                controller: textPhoneController,
                                placeholder: "Numero celular",
                                lines: 1,
                              )),
                        ],
                      ),
                      GestureDetector(
                        onTap: (){
                          if(textPhoneController.text.isNotEmpty && textPhoneController.text.length==9){
                            model.sendMessagePhone(textPhoneController.text).listen((eventoo) {
                              switch(eventoo.state){
                                case  ResourceState.COMPLETE :
                                  locator<NavigationService>().navigateTo(VerifyMessagePageViewRote,arguments:textPhoneController.text);
                                  break;
                                case  ResourceState.ERROR :
                                  Toast.show(eventoo.exception, context);
                                  break;
                                case ResourceState.LOADING:
                                  break;
                              }
                            });
                          }else{
                            Toast.show("Ingrese un numero celular correcto", context);
                          }


                        },
                        child: Container(
                            margin: EdgeInsets.symmetric(vertical: 5),
                            width: 65,
                            height: 30,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.white,
                              ),
                            )),
                      )
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
