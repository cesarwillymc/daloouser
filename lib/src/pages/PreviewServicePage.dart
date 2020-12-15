import 'package:daloouser/data/model/ServiceModel.dart';
import 'package:daloouser/src/pages/productosServices/ComentariosPage.dart';
import 'package:daloouser/src/pages/productosServices/InformationServicePage.dart';
import 'package:daloouser/src/pages/productosServices/ListaProductosPage.dart';
import 'package:daloouser/src/pages/productosServices/ProductosServicesTopInfo.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:daloouser/viewModel/ProductsViewModel.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class PreviewServicePage extends StatefulWidget{
  String id= "5f934593cc89981c8fde097c";
  String categoria="5f90a562cc89981c8fde095b";

  PreviewServicePage(this.categoria, this.id) ;
  @override
  _PreviewServicePageState createState() => _PreviewServicePageState();
}

class _PreviewServicePageState extends State<PreviewServicePage> {

  List<Widget> pages;
  @override
  Widget build(BuildContext context) {
    pages= [ListaProductosPage(widget.categoria,widget.id),ComentariosPage(widget.id),InformationServicePage()];
    return SafeArea(
      child: Scaffold(
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