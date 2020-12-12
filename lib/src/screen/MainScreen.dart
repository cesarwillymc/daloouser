import 'package:daloouser/data/network/NavigationService.dart';
import 'package:daloouser/src/pages/HistorialPage.dart';
import 'package:daloouser/src/pages/MiPedidoPage.dart';
import 'package:daloouser/src/pages/TeLoTraigoPage.dart';
import 'package:daloouser/src/pages/TiendasPage.dart';
import 'package:daloouser/src/widget/appbars/AppBarMain.dart';
import 'package:daloouser/src/widget/search/Search.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:daloouser/utils/FunctionsUitls.dart';
import 'package:flutter/material.dart';

import '../../Locator.dart';

class MainScreen extends StatefulWidget {
  Widget current;
  bool isLocationVisible;

  MainScreen(this.current, {this.isLocationVisible = true});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int currentTabIndex = 0;

  Widget currentPage;
  List<Widget> pages;
  List<String> titles;
  String titulo;
  TiendasPage tiendasPage;
  MiPedidoPage miPedidoPage;
  TeLoTraigoPage teLoTraigoPage;
  HistorialPage historialPage;

  final NavigationService _navigationService = locator<NavigationService>();

  @override
  void initState() {
    super.initState();
    tiendasPage = TiendasPage();
    historialPage = HistorialPage();
    miPedidoPage = MiPedidoPage();
    teLoTraigoPage = TeLoTraigoPage();

    pages = [tiendasPage, historialPage, miPedidoPage, teLoTraigoPage];
    titles = [
      "Food App Delivery",
      "All Food Items",
      "Mis pedidos",
      "Mi Perfil"
    ];
    titulo = titles[0];
    currentPage = tiendasPage;
    if (widget.current != null) {
      currentPage = widget.current;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool _searching = false;
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (int index) {
          setState(() {
            currentTabIndex = index;
            currentPage = pages[index];
            titulo = titles[index];
            //   _navigationService.navigateTo(currentPage);
          });
        },
        currentIndex: currentTabIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: primaryColor,
        unselectedItemColor: Colors.grey,
        selectedFontSize: 12,
        unselectedFontSize: 10,
        items: [
          BottomNavigationBarItem(
              icon: Image.asset(
                "assets/shop.png",
                width: currentTabIndex == 0 ? 25 : 20,
                height: currentTabIndex == 0 ? 25 : 20,
                color: currentTabIndex == 0 ? primaryColor : Colors.grey,
              ),
              title: Text("Tiendas")),
          BottomNavigationBarItem(
              icon: Image.asset("assets/history.png",
                  width: currentTabIndex == 1 ? 25 : 20,
                  height: currentTabIndex == 1 ? 25 : 20,
                  color: currentTabIndex == 1 ? primaryColor : Colors.grey),
              title: Text("Historial")),
          BottomNavigationBarItem(
              icon: Image.asset("assets/pedidoon.png",
                  width: currentTabIndex == 2 ? 25 : 20,
                  height: currentTabIndex == 2 ? 25 : 20,
                  color: currentTabIndex == 2 ? primaryColor : Colors.grey),
              title: Text("Mi Pedido")),
          BottomNavigationBarItem(
              icon: Image.asset("assets/chat.png",
                  width: currentTabIndex == 3 ? 25 : 20,
                  height: currentTabIndex == 3 ? 25 : 20,
                  color: currentTabIndex == 3 ? primaryColor : Colors.grey),
              title: Text("TeloTraigo")),
        ],
      ),
      appBar: AppBarMain(
        searchpressed: (){
          setState(() {
            showSearch(context: context, delegate: Search());
          });
        },
        isVisibleLocation: widget.isLocationVisible,
        titulo: titulo,
      ),
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: currentPage,
    );
  }

  Widget _buildShoppingCart() {
    return Stack(
      children: [
        Icon(
          Icons.shopping_cart,
          color: primaryColor,
          size: 30.0,
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            height: 15,
            width: 15,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(7.5), color: Colors.red),
            child: Center(
              child: Text(
                "1",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
            ),
          ),
        )
      ],
    );
  }
}
//Text(titulo,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
