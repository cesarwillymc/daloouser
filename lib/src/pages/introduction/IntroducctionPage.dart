import 'package:auto_size_text/auto_size_text.dart';
import 'package:daloouser/data/network/NavigationService.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:daloouser/viewModel/ProductsViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:stacked/stacked.dart';

import '../../../Locator.dart';
import '../../../main.dart';
import '../TiendasPage.dart';

class IntroducctionPage extends StatefulWidget{
  @override
  _IntroducctionPageState createState() => _IntroducctionPageState();
}

class _IntroducctionPageState extends State<IntroducctionPage> {
  var sizePage=300;
  PageViewModel pagina1=  PageViewModel(
    title: "Tiendas",
    body: "Tenemos convenios para entregarte productos a bajos precios y promociones.",
    image: Center(child: Image.asset("assets/intro_one.png",width: 300,height: 300,)),

  );

  PageViewModel pagina2=  PageViewModel(
    title: "Punto de entrega",
    body: "¡Selecciona tu ubicación, contamos con un mapa y una opción para actualizar tu ubicación! ",
    image:  Center(child: Image.asset("assets/intro_two.png",width: 300,height: 300,)),

  );

  PageViewModel pagina3=  PageViewModel(
    title: "Variedad de productos",
    body: "Contamos con varios productos como comidas, bebidas y más.",
    image:  Center(child: Image.asset("assets/intro_three.png",width: 300,height: 300,)),

  );

  PageViewModel pagina4=  PageViewModel(
    title: "Mis Productos",
    body: "Visualiza tus productos seleccionados y comenta que más quieres que tenga tu pedido.",
    image:  Center(child: Image.asset("assets/intro_four.png",width: 300,height: 300,)),

  );

  PageViewModel pagina5=  PageViewModel(
    title: "Estado de mi Pedido",
    body: "Puedes visualizar el estado de tu pedido, también información de tu rider y la tienda.",
    image:  Center(child: Image.asset("assets/intro_five.png",width: 300,height: 300,)),


  );

  List<PageViewModel> listPagesViewModel=new List<PageViewModel>();

  @override
  Widget build(BuildContext context) {
    listPagesViewModel.add(pagina1);
    listPagesViewModel.add(pagina2);
    listPagesViewModel.add(pagina3);
    listPagesViewModel.add(pagina4);
    listPagesViewModel.add(pagina5);
    return ViewModelBuilder<ProductsViewModel>.reactive(
        onModelReady: (model)=>model.getPoliline(),
        builder: (context,child,model)=>
        IntroductionScreen(
          pages: listPagesViewModel,
          onDone: () {
            shared.setBool(sharedPrefIntro, true);
            locator<NavigationService>().navigateToClearStack(MainScreenViewRoute,arguments: TiendasPage());
            // When done button is press
          },
          onSkip: () {
            shared.setBool(sharedPrefIntro, true);
            // You can also override onSkip callback}
            locator<NavigationService>().navigateToClearStack(MainScreenViewRoute,arguments: TiendasPage());
          },
          showSkipButton: true,
          skip:  Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              width: 65,
              height: 30,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child:  Center(child: Text("Saltar",style: TextStyle(color: Colors.white,fontSize: 10),))
          ),
          next:  Container(
              margin: EdgeInsets.symmetric(vertical: 5),
              width: 60,
              height: 30,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(Icons.navigate_next,color: Colors.white,)
          ),
          done:  Text("Done", style: TextStyle(fontWeight: FontWeight.w600,color: Colors.black)),
          dotsDecorator: DotsDecorator(
              size:  Size.square(5.0),
              activeSize:  Size(10.0, 5.0),
              activeColor: primaryColor,
              color: primaryColor,
              spacing:  EdgeInsets.symmetric(horizontal: 3.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)
              )
          ),
        ), viewModelBuilder: ()=>ProductsViewModel());
  }
}