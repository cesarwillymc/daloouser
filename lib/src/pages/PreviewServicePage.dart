import 'package:flutter/material.dart';

class PreviewServicePage extends StatefulWidget{
  final String categoria;
  final String idService;

  PreviewServicePage(this.categoria, this.idService) ;
  @override
  _PreviewServicePageState createState() => _PreviewServicePageState();
}

class _PreviewServicePageState extends State<PreviewServicePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text("PreviewServicePage"),
      ),
    );
  }
}