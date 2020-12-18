import 'dart:async';
import 'dart:collection';

import 'package:daloouser/data/model/ServiceModel.dart';
import 'package:daloouser/viewModel/ProductsViewModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:stacked/stacked.dart';

class InformationServicePage extends StatefulWidget {
  ServiceModel model;

  InformationServicePage({this.model});

  @override
  _InformationServicePageState createState() => _InformationServicePageState();
}

class _InformationServicePageState extends State<InformationServicePage> {
  Completer<GoogleMapController> _controller = Completer();
  CameraPosition _kGooglePlex;
  Set<Marker> _markers = HashSet<Marker>();

  @override
  void initState() {
    super.initState();
    // _checkLocationPermission();
  }

  @override
  Widget build(BuildContext context) {
    if(widget.model!=null){
      setMarker(LatLng(widget.model.latitude, widget.model.longitude));
      _kGooglePlex = CameraPosition(
        target: LatLng(widget.model.latitude, widget.model.longitude),
        zoom: 16,
      );
    }

    print("Permission ll");
    return Scaffold(
      body: widget.model != null
          ? ListView(
              children: [
                Text(
                  "Informacíon",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                Text(
                  widget.model.description,
                  style: TextStyle(color: Colors.black),
                ),
                Text(
                  "Direccíon",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
                ViewModelBuilder<ProductsViewModel>.reactive(
                    builder: (context, model, child) => model.busy
                        ? Center(
                            child: Text("Cargando"),
                          )
                        : model.permissionGranted?_googleMapsWidget():Text("Permiso no aceptado"),
                    viewModelBuilder: () => ProductsViewModel(),
                onModelReady: (model)=>model.PermissionMaps(),)
              ],
            )
          : Center(
              child: Text("Surgio un error al cargar los datos"),
            ),
    );
  }

  Widget _googleMapsWidget() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 400,
      child: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        markers: _markers,
      ),
    );
  }



  void setMarker(LatLng point) {
    final String markerId = "2";
    setState(() {
      _markers.add(Marker(markerId: MarkerId(markerId), position: point));
    });
  }


}
