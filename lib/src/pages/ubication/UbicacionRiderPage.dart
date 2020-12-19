import 'dart:async';
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:daloouser/data/model/UsuarioModel.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:daloouser/viewModel/ProductsViewModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';

import '../../../main.dart';

class UbicationRiderPage extends StatefulWidget{

  String idRider;
  UbicationRiderPage(this.idRider);

  @override
  _UbicationRiderPageState createState() => _UbicationRiderPageState();



}

class _UbicationRiderPageState extends State<UbicationRiderPage> {
  LatLng _lastMapPosition;
  Set<Marker> _markers = HashSet<Marker>();
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _kGooglePlex;

  UsuarioModel usuario;
  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }
  void _getUserLocation() async {
    usuario = boxList[3].getAt(0);
    setState(() {
      _kGooglePlex = CameraPosition(
        target: LatLng(
            usuario.latitude, usuario.longitude),
        zoom: 16,
      );
    });

    var valueuser = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(100, 100)), "assets/marker_daloo.png");
    var valuerider = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(100, 100)), "assets/rider.png");

    setState(() {
      marcador = valueuser;
      marcadorrider = valuerider;
      if (usuario.latitude != null) {
        setMarker(LatLng(usuario.latitude, usuario.longitude),false);
      }
      _lastMapPosition =LatLng(usuario.latitude, usuario.longitude);

    });
  }
  DocumentSnapshot services;
  @override
  Widget build(BuildContext context) {
    FirebaseFirestore.instance.collection("Rider").doc(widget.idRider) .snapshots().listen((event) {
        setState(() {
          services = event;
          setMarker(LatLng(double.parse(event.get("latitude").toString()), double.parse(event.get("longitude").toString())),true);
        });

    });
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("UBICACIÓN DE TU RIDER",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 18),),
      ),
      body: ViewModelBuilder<ProductsViewModel>.reactive(
        builder: (context, model, child) =>
        model.busy
            ? Center(
          child: Text("Cargando"),
        )
            : model.permissionGranted
            ? _googleMapsWidget() :  Center(
          child: Row(
            children: [
              CircularProgressIndicator(),
              Text("Permiso no aceptado")
            ],
          ),
        ),
        viewModelBuilder: () => ProductsViewModel(),
        onModelReady: (model) => model.PermissionMaps(),
      ),
    ));
  }

  void setMarker(LatLng point, bool isRider) {
     String markerId ;
     String title;
    setState(() {
      if(isRider){
          markerId= "2";
          title="Rider";
        try{
          _markers.remove(_markers.elementAt(1));
        }catch(e){}
      }else{
        title="Mi location";
        markerId= "1";
      }
      _markers.add(Marker(
          markerId: MarkerId(markerId),
          position: point,
          infoWindow: InfoWindow(title: title),
          icon:isRider?marcadorrider: marcador != null ? marcador : marcadorrider));
    });
  }
  BitmapDescriptor marcador;
  BitmapDescriptor marcadorrider;
  Widget _googleMapsWidget() {
    return Stack(
      children: [
        Container(
          child: GoogleMap(
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: _markers,
          ),
        ),
      ],
    );
  }

  Future<Position> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permantly denied, we cannot request permissions.');
    }

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse &&
          permission != LocationPermission.always) {
        return Future.error(
            'Location permissions are denied (actual value: $permission).');
      }
    }
    return Geolocator.getCurrentPosition();
  }
}