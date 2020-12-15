import 'package:daloouser/data/model/ComentariosModel.dart';
import 'package:daloouser/data/model/ComentariosStartModel.dart';
import 'package:daloouser/src/widget/card/CardComentario.dart';
import 'package:daloouser/src/widget/ratingList.dart';
import 'package:daloouser/viewModel/ProductsViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class ComentariosPage extends StatefulWidget {
  String idService;

  ComentariosPage(this.idService);

  @override
  _ComentariosPageState createState() => _ComentariosPageState();
}

class _ComentariosPageState extends State<ComentariosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        children: [
          Container(
              margin: EdgeInsets.only(left: 30, bottom: 10, top: 10),
              width: double.infinity,
              child: Text(
                "Calificación",
                textAlign: TextAlign.start,
              )),
          ViewModelBuilder<ProductsViewModel>.reactive(
              viewModelBuilder: () => ProductsViewModel(),
              onModelReady:(model)=>model.getComentariosStartServices(widget.idService) ,
              builder: (context, model, child) => model.busy?Center(child: CircularProgressIndicator(),):
              Container(
                margin: EdgeInsets.symmetric(horizontal: 80),
                width: 150,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: _comentariosStartBuild(model.comentariosStartList),
                ),
              )),
          ViewModelBuilder<ProductsViewModel>.reactive(
            viewModelBuilder: () => ProductsViewModel(),
            onModelReady: (model) =>
                model.getComentariosServices(widget.idService),
            builder: (context, model, child) => model.busy
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Column(
                      children:
                          model.comentariosList.map(_comentariosBuild).toList(),
                    )),
          )
        ],
      ),
    );
  }

  Widget _comentariosBuild(ComentariosModel dato) {
    return CardComentario(dato);
  }
  List<Widget> _comentariosStartBuild(List<ComentariosStartModel> dato) {
    List<Widget> lista= [ratingList(5,0),ratingList(4,0),ratingList(3,0),ratingList(2,0),ratingList(1,0)];
    dato.forEach((element) {
      lista[(5-element.iId)]= ratingList(element.iId,element.count);
    });
    return lista;
  }
}
