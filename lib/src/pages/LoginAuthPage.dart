
import 'package:auto_size_text/auto_size_text.dart';
import 'package:daloouser/data/network/NavigationService.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:daloouser/viewModel/ProductsViewModel.dart';
import 'package:facebook_sdk/facebook_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stacked/stacked.dart';
import 'package:toast/toast.dart';

import '../../Locator.dart';
import 'TiendasPage.dart';

class LoginAuthPage extends StatefulWidget{
  @override
  _LoginAuthPageState createState() => _LoginAuthPageState();
}

class _LoginAuthPageState extends State<LoginAuthPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ViewModelBuilder<ProductsViewModel>.reactive(builder: (context,model,child)=>Container(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            children: [
              Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height*0.27,
                  child: Image.asset("assets/logo_dalo_blue.webp")),
              Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(horizontal: 60,vertical: 5),
                  alignment: Alignment.centerLeft,
                  child: AutoSizeText("Bienvenido",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),)),
              model.busy?Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                width: 50,
                child: CircularProgressIndicator(),
              ):GestureDetector(
                onTap: () async {
                  var login=await fbLogin();
                  if(login.isNotEmpty){
                    model.loginWithFacebookorGmail(login).listen((eventoo) {
                      switch(eventoo.state){
                        case  ResourceState.COMPLETE :
                          if(eventoo.data as bool){
                            locator<NavigationService>().navigateToClearStack(MainScreenViewRoute,arguments: TiendasPage());
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
                  }

                },
                child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    width: MediaQuery.of(context).size.width*0.6,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Image.asset("assets/facebook.png",color: Colors.white,),
                      title: Text("Facebook",style: TextStyle(color: Colors.white),),
                    )
                ),
              ),
              model.busy?Container(
                margin: EdgeInsets.symmetric(vertical: 5),
                width: 50,
                child: CircularProgressIndicator(),
              ):GestureDetector(
                onTap: () async {
                  var login=await _handleSignIn();
                  if(login.isNotEmpty){
                    model.loginWithFacebookorGmail(login, isFacebook: false).listen((eventoo) {
                      switch(eventoo.state){
                        case  ResourceState.COMPLETE :
                          if(eventoo.data as bool){
                            locator<NavigationService>().navigateToClearStack(MainScreenViewRoute,arguments: TiendasPage());
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
                  }
                },
                child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    width: MediaQuery.of(context).size.width*0.6,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ListTile(
                      leading: Image.asset("assets/gmail.png"),
                      title: Text("Facebook",style: TextStyle(color: Colors.white),),
                    )
                ),
              ),

              Container(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height*0.25,
                  child: Image.asset("assets/llama.webp")),
              Text("D A L O O D E L I V E R Y"),
            ],
          ),
        ), viewModelBuilder: ()=>ProductsViewModel()),
      ),
    );
  }

  GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: "197162189730-m5bvkvj2g535nq5i72rj19oe5c2jevdb.apps.googleusercontent.com",
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );

  Future<String> _handleSignIn() async {
    try {
      var datos =await _googleSignIn.signIn();
      var dara= await datos.authentication;
      return dara.idToken;
    } catch (error) {
      Toast.show(error, context);
      return "";
    }
  }

  Future<String> fbLogin() async {
    // await FacebookSdk.logOut();
    FacebookLoginResult result = await FacebookSdk.logInWithReadPermissions(['email',"public_profile"]);

    switch (result.status) {
      case FacebookLoginStatus.loggedIn:
        return result.accessToken.token;
      case FacebookLoginStatus.cancelledByUser:
        Toast.show("Login Cancel", context);
        break;
      case FacebookLoginStatus.error:
        Toast.show(result.errorMessage, context);
        break;
    }
    return "";


  }
}