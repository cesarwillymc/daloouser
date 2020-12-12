import 'dart:ffi';

import 'package:daloouser/data/model/CategoryModel.dart';
import 'package:daloouser/data/model/ListaProductosCategoria.dart';
import 'package:daloouser/data/model/Prices.dart';
import 'package:daloouser/data/model/ProductoData.dart';
import 'package:daloouser/data/model/PromocionesModel.dart';
import 'package:daloouser/data/model/ServiceItem.dart';
import 'package:daloouser/data/network/DialogService.dart';
import 'package:daloouser/data/network/MainRepository.dart';
import 'package:daloouser/data/network/NavigationService.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../Locator.dart';
import 'BaseModel.dart';

class ProductsViewModel extends BaseModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final MainRepository _mainRepository = locator<MainRepository>();
  final DialogService _dialogService = locator<DialogService>();

  List<ServiceItem> _searchProducts;

  List<ServiceItem> get searchProducts => _searchProducts;

  void listenToProductsSearch(String palabra) {
    setBusy(true);
    print("entroooo searchhhh $palabra");
    if (palabra.isEmpty) {
      var valor = Hive.box<ServiceItem>(recentSearchBOXHIVE);
      if (valor.isEmpty) {
        _searchProducts = [];
      } else {
        print("entroooo searchhhh ${valor.length}");
        _searchProducts = valor.values.toList();
      }
      notifyListeners();
      setBusy(false);
    } else {
      _mainRepository.searchProducts(palabra).then((postsData) {
        print("entroooo searchhhh buscar in api $postsData");
        List<ServiceItem> updatedPosts = postsData;
        if (updatedPosts != null) {
          _searchProducts = updatedPosts;
          notifyListeners();
          setBusy(false);
        }
      });
    }
  }

  List<PromocionesModel> _promociones;

  List<PromocionesModel> get promociones => _promociones;

  void listenPromociones() {
    setBusy(true);
    _mainRepository.getPromociones().then((promo) {
      List<PromocionesModel> updatedOferts = promo;
      print("Promociones $updatedOferts");
      if (promo != null) {
        _promociones = updatedOferts;
        notifyListeners();
        setBusy(false);
      } else {
        _promociones = [];
      }
    });
  }

  List<CategoryModel> _categorias;

  List<CategoryModel> get categorias => _categorias;

  void listenCategorias() {
    setBusy(true);
    _mainRepository.getCategoriasProducts().then((cat) {
      List<CategoryModel> updatedCategory = cat;
      print("Categorias $updatedCategory");
      if (cat != null) {
        _categorias = updatedCategory;
        _categorias.insert(0, CategoryModel("Todo", ""));
        notifyListeners();
        setBusy(false);
      } else {
        _categorias = [CategoryModel("Todo", "")];
      }
    });
  }

  List<ListaProductosCategoria> _servicewithservice;

  List<ListaProductosCategoria> get servicewithservice => _servicewithservice;

  void getListProductswithService() {
    setBusy(true);
    _mainRepository.getListProductswithService().then((cat) {
      List<ListaProductosCategoria> updatedCategory = cat;
      print("getListProductswithService subido $updatedCategory");
      if (cat != null) {
        _servicewithservice = updatedCategory;
        notifyListeners();
        setBusy(false);
      } else {
        _servicewithservice = [];
      }
    });
  }

  ProductoData _productData;

  ProductoData get productData => _productData;

  void getProductByID(String id) {
    setBusy(true);
    _mainRepository.getProductByID(id).then((cat) {
      ProductoData updatedCategory = cat;
      if (cat != null) {
        var price=Prices(id,cat.priceGeneral,cat.namePriceGeneral,cat.description,"");
        updatedCategory.prices.add(price);
        _productData = updatedCategory;
        notifyListeners();
        setBusy(false);
      } else {
        _productData = null;
      }
    });
  }
}
