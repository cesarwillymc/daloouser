import 'dart:ui';

import 'package:daloouser/data/model/Prices.dart';
import 'package:daloouser/data/model/ServiceItem.dart';
import 'package:daloouser/data/model/ServiceModel.dart';
import 'package:daloouser/src/pages/productosServices/ComentariosPage.dart';
import 'package:daloouser/src/pages/productosServices/InformationServicePage.dart';
import 'package:daloouser/src/pages/productosServices/ListaProductosPage.dart';
import 'package:daloouser/src/pages/productosServices/ProductosServicesTopInfo.dart';
import 'package:daloouser/src/widget/buttons/TipePriceCardInactive.dart';
import 'package:daloouser/src/widget/card/CardCategorias.dart';
import 'package:daloouser/src/widget/card/CardIconItem.dart';
import 'package:daloouser/src/widget/card/SearchCardItem.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:daloouser/utils/FunctionsUitls.dart';
import 'package:daloouser/viewModel/ProductsViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pagination/pagination.dart';
import 'package:shimmer/shimmer.dart';
import 'package:stacked/stacked.dart';

class HistorialPage extends StatefulWidget {
  String id= "5f934593cc89981c8fde097c";
  String categoria="5f90a562cc89981c8fde095b";
  @override
  _HistorialPageState createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  List<Widget> pages;
  @override
  Widget build(BuildContext context) {
    pages= [ListaProductosPage(widget.categoria,widget.id),ComentariosPage(widget.id),InformationServicePage()];
    Widget pageActual=pages[0];

    var _controller=ScrollController();
    var texto =
        "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.";
    return Scaffold(
      body: DefaultTabController(
        length: 3,
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                  shadowColor: primaryColor,
                  expandedHeight: 200.0,
                  backgroundColor: primaryColor,
                  floating: false,
                  pinned: false,
                  flexibleSpace: ViewModelBuilder<ProductsViewModel>.reactive(
                    viewModelBuilder: () => ProductsViewModel(),
                    onModelReady: (model) => model.getServiceInfoById(widget.id),
                    builder: (context, model, child) => model.busy
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : _servicesHome(model.infoService),
                  )),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    labelColor: Colors.black87,
                    indicatorColor: primaryColor,
                    unselectedLabelColor: Colors.grey,
                    tabs: [
                      Tab(text: "Productos"),
                      Tab(text: "Comentarios"),
                      Tab(text: "Informacion"),
                    ],
                    onTap: (index) {
                      setState(() {
                        print("historial page $index");
                        pageActual = pages[index];
                      });
                    },
                  ),
                ),
                pinned: false,
              ),
            ];
          },
          body: TabBarView(children: pages),
        ),
      ),
    );
  }
  Widget _servicesHome(ServiceModel infoService){
    pages[2]= InformationServicePage(model: infoService,);
    return FlexibleSpaceBar(
        centerTitle: true,
        background: ProductosServicesTopInfo(infoService));
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
