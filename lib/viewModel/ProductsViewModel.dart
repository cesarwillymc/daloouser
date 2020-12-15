import 'dart:ffi';

import 'package:daloouser/data/model/CategoriasModel.dart';
import 'package:daloouser/data/model/CategoryModel.dart';
import 'package:daloouser/data/model/ComentariosModel.dart';
import 'package:daloouser/data/model/ComentariosStartModel.dart';
import 'package:daloouser/data/model/ListServices.dart';
import 'package:daloouser/data/model/ListaProducItem.dart';
import 'package:daloouser/data/model/ListaProductosCategoria.dart';
import 'package:daloouser/data/model/Prices.dart';
import 'package:daloouser/data/model/ProductoData.dart';
import 'package:daloouser/data/model/PromocionesModel.dart';
import 'package:daloouser/data/model/ServiceItem.dart';
import 'package:daloouser/data/model/ServiceModel.dart';
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
        _categorias.insert(0, CategoryModel("Todo", "",1));
        notifyListeners();
        setBusy(false);
      } else {
        _categorias = [CategoryModel("Todo", "",1)];
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
  ServiceModel _infoService;

  ServiceModel get infoService => _infoService;

  void getServiceInfoById(String id) {
    setBusy(true);
    _mainRepository.getServiceInfoById(id).then((cat) {
      ServiceModel updatedCategory = cat;
      print("getListProductswithService subido $updatedCategory");
      if (cat != null) {
        _infoService = cat;
        notifyListeners();
        setBusy(false);
      } else {
        _infoService = null;
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
  int totalPaginas=0;
  int totalNetwoksItem;
  String categoriaId;
  Future<List<ServiceModel>> getServicesByCategory(int offset) async{
   //setBusy(true);
    var valueBoolean =false;
    ListServices lista;
    if(totalNetwoksItem==null){
      valueBoolean=true;
    }else{
      print("getServicesByCategory off $totalNetwoksItem  $totalPaginas");
      if(totalNetwoksItem/10>0){
        if((totalNetwoksItem - (totalPaginas + 10)) > 1){
          totalPaginas+=10;
          valueBoolean=true;
        }
      }
    }


    if(valueBoolean){
      _mainRepository.getServicesByCategory(categoriaId,totalPaginas).listen((cat) {
        lista=cat;
        totalNetwoksItem=lista.total;
        if (cat != null) {
          if(lista.total/10>0){
            if((lista.total - (totalPaginas + 10)) > 1){
              totalPaginas+=10;
            }
          }
          print("getServicesByCategory datos ${cat.total}");
          //notifyListeners();
          // setBusy(false);
        }
      });
      await Future.delayed(
        Duration(milliseconds: 1000),
      );
      if(lista.data!=null){
        return  lista.data;
      }else{
        return [];
      }
    }else{
      return [];
    }
  }
  List<CategoriasModel> _subcategoria;

  List<CategoriasModel>  get subcategoria => _subcategoria;

  void getSubCategoriaSpinner(String id) {
    setBusy(true);
    _mainRepository.getSubCategoriaSpinner(id).then((cat) {
      List<CategoriasModel> updatedCategory = cat;
      if (cat != null) {
        var price=CategoriasModel("Buscar todos","");
        updatedCategory.insert(0,price);
        _subcategoria = updatedCategory;
        notifyListeners();
        setBusy(false);
      } else {
        _subcategoria = [];
      }
    });
  }
  List<ComentariosModel> _comentariosList;

  List<ComentariosModel>  get comentariosList => _comentariosList;

  void getComentariosServices(String id) {
    setBusy(true);
    _mainRepository.getComentariosServices(id).then((cat) {
      List<ComentariosModel> updatedCategory = cat;
      if (cat != null) {
        _comentariosList = updatedCategory;
        notifyListeners();
        setBusy(false);
      } else {
        _comentariosList = [];
        notifyListeners();
        setBusy(false);
      }
    });
  }
  List<ComentariosStartModel> _comentariosStartList;

  List<ComentariosStartModel>  get comentariosStartList => _comentariosStartList;
  void getComentariosStartServices(String id) {
    setBusy(true);
    _mainRepository.getComentariosStartServices(id).then((cat) {
      if (cat != null) {
        _comentariosStartList= cat;
        setBusy(false);
        notifyListeners();
      } else {
        _comentariosStartList= [];
        setBusy(false);
        notifyListeners();
      }
    });
  }

  int totalPaginasProducts=0;
  int totalNetwoksItemProducts;

  List<ListaProductItem> _productosCategoria;

  List<ListaProductItem>  get productosCategoria => _productosCategoria;

  Future<List<ListaProductItem>>  getProductsByCategoryData(int a)async{
    return productosCategoria;
  }
  String spinnerData;
  Future<List<ListaProductItem>> getProductsByCategory(int index) async{
    setBusy(true);
    var valueBoolean =false;
    List<ListaProductItem> lista;
    if(totalNetwoksItemProducts==null){
      valueBoolean=true;
    }else{
      print("getProductsByCategory off $totalNetwoksItemProducts  $totalPaginasProducts");
      if(totalNetwoksItemProducts/10>0){
        if((totalNetwoksItemProducts - (totalPaginasProducts + 10)) > 1){
          totalPaginasProducts+=10;
          valueBoolean=true;
        }
      }
    }


    if(valueBoolean){
      _mainRepository.getProductsByCategoria(spinnerData,totalPaginasProducts,categoriaId).then((cat) {
        lista=cat;
        totalNetwoksItemProducts=lista[0].total;
        if (cat != null) {
          if(lista[0].total/10>0){
            if((lista[0].total - (totalPaginasProducts + 10)) > 1){
              totalPaginasProducts+=10;
            }
          }
          print("getServicesByCategory datos ${cat[0].total}");

        }
      });
      await Future.delayed(
        Duration(milliseconds: 500),
      );
      if(lista==null){
        await Future.delayed(
          Duration(milliseconds: 1200),
        );
      }
      if(lista!=null){
        print("getServicesByCategory Entro lista no null");
        _productosCategoria=  lista;
        notifyListeners();
        setBusy(false);
        return  _productosCategoria;
      }
    }else{
      print("getServicesByCategory valueBolean false");
      _productosCategoria= [];
      notifyListeners();
      setBusy(false);
      return  [];
    }
  }
}
