import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:daloouser/Locator.dart';
import 'package:daloouser/data/model/Prices.dart';
import 'package:daloouser/data/model/ServiceItem.dart';
import 'package:daloouser/data/model/ServiceModel.dart';
import 'package:daloouser/data/network/NavigationService.dart';
import 'package:daloouser/src/pages/TiendasPage.dart';
import 'package:daloouser/src/pages/productosServices/ComentariosPage.dart';
import 'package:daloouser/src/pages/productosServices/InformationServicePage.dart';
import 'package:daloouser/src/pages/productosServices/ListaProductosPage.dart';
import 'package:daloouser/src/pages/productosServices/ProductosServicesTopInfo.dart';
import 'package:daloouser/src/widget/buttons/TipePriceCardInactive.dart';
import 'package:daloouser/src/widget/card/CardCarritoItem.dart';
import 'package:daloouser/src/widget/card/CardCategorias.dart';
import 'package:daloouser/src/widget/card/CardIconItem.dart';
import 'package:daloouser/src/widget/card/SearchCardItem.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:daloouser/utils/FunctionsUitls.dart';
import 'package:daloouser/utils/Resource.dart';
import 'package:daloouser/viewModel/ProductsViewModel.dart';
import 'package:facebook_sdk/facebook_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pagination/pagination.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';
import 'package:toast/toast.dart';

class HistorialPage extends StatefulWidget {

  @override
  _HistorialPageState createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  List<Widget> pages;
  @override
  Widget build(BuildContext context) {

    var texto =
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
    return Scaffold(
      body: Center(child: Text("historila"),),
    );
  }

}

