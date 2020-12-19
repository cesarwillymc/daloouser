import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:daloouser/data/model/MapeoDepartamento.dart';
import 'package:daloouser/data/model/UsuarioModel.dart';
import 'package:daloouser/data/network/NavigationService.dart';
import 'package:daloouser/src/widget/imput/InputField.dart';
import 'package:daloouser/utils/Constant.dart';
import 'package:daloouser/viewModel/ProductsViewModel.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_map_polyutil/google_map_polyutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:toast/toast.dart';

import '../../../Locator.dart';
import '../../../main.dart';

class UbicationPage extends StatefulWidget {
  @override
  _UbicationPageState createState() => _UbicationPageState();
}

class _UbicationPageState extends State<UbicationPage> {
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _kGooglePlex;
  UsuarioModel usuario;
  Set<Marker> _markers = HashSet<Marker>();
  final textDireccion = TextEditingController();
  final textReferencia = TextEditingController();

  MapeoDepartamento mapeo;
  BitmapDescriptor marcador;
  List<LatLng> polilyne = List<LatLng>();
  bool _disableButton = false;
  final Set<Polyline> _polyline = {};

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  void _getUserLocation() async {
    usuario = boxList[3].getAt(0);
    print("Mapa ${usuario.latitude != null}");
    var position = await _getLocation();
    print("Mapa ${usuario.latitude != null}");
    if (boxList[5].isNotEmpty) {
      mapeo = boxList[5].getAt(0);
      print("Mapa \"mapa\":${mapeo.mapa} ");
    }
    _kGooglePlex = CameraPosition(
      target: usuario.latitude != null ? LatLng(
          usuario.latitude, usuario.longitude) : LatLng(
          position.latitude, position.longitude),
      zoom: 16,
    );
    if (mapeo != null) {
      await Stream.fromIterable(jsonDecode(mapeo.mapa)).forEach((element) {
        polilyne.add(LatLng(double.parse(element["latitude"].toString()),
            double.parse(element["longitude"].toString())));
      });
    }
    var value = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(100, 100)), "assets/marker_daloo.png");

    setState(() {
      marcador = value;
      if (usuario.latitude != null) {
        setMarker(LatLng(usuario.latitude, usuario.longitude));
      }
      _lastMapPosition = usuario.latitude != null
          ? LatLng(usuario.latitude, usuario.longitude)
          : LatLng(position.latitude, position.longitude);
      _polyline.add(Polyline(
        polylineId: PolylineId(mapeo.departamento),
        visible: true,
        points: polilyne,
        width: 5,
        color: primaryColor,
      ));
    });
  }

//      await jsonDecode(mapeo.mapa).forEach((v) {
//         polilyne.add(LatLng(double.parse(v["latitude"].toString()),
//             double.parse(v["longitude"].toString())));
//       });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: primaryColor,
        title: Text(
          "ACTUALIZAR UBICACIÓN",
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: ViewModelBuilder<ProductsViewModel>.reactive(
        builder: (context, model, child) =>
        model.busy
            ? Center(
          child: Text("Cargando"),
        )
            : model.permissionGranted
            ? _kGooglePlex != null ? _googleMapsWidget() : Center(
          child: Row(
            children: [
              CircularProgressIndicator(),
              Text("Cargando")
            ],
          ),
        )
            : Center(
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
      bottomNavigationBar: ViewModelBuilder<ProductsViewModel>.reactive(
          builder: (context, model, child) =>
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "1. Mi ubicación actual",
                      style:
                      TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      child: Text("Jr Selva Alegre 534"),
                    ),
                    Text("2. Ubicación del marcador",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    ListTile(
                        trailing: GestureDetector(
                          onTap: () async {
                            final coordinates = new Coordinates(
                                _lastMapPosition.latitude,
                                _lastMapPosition.longitude);
                            var addresses = await Geocoder.local
                                .findAddressesFromCoordinates(coordinates);
                            setState(() {
                              print("direccion ${addresses.first.addressLine}");
                              textDireccion.text = addresses.first.addressLine;
                            });
                          },
                          child: Icon(
                            Icons.search,
                            color: primaryColor,
                          ),
                        ),
                        title: InputField(
                            controller: textDireccion,
                            placeholder: "Escribe tu calle o dale a buscar")),
                    Text("3. Referencia",
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold)),
                    InputField(
                        controller: textReferencia,
                        placeholder: "Referencia de tu calle"),
                    GestureDetector(
                      onTap: _disableButton
                          ? null
                          : () {
                        if (comprobarLogin()) {}
                        if (textDireccion.text.isEmpty) {
                          Toast.show(
                              "Escribe tu calle o dale a buscar", context);
                        }else{
                          model.updateDirecctionUrl(textDireccion.text,textReferencia.text??"",_lastMapPosition.latitude,_lastMapPosition.longitude).listen((eventoo) {
                            switch(eventoo.state){
                              case  ResourceState.COMPLETE :
                                if(eventoo.data as bool){
                                  Toast.show("Se registro correctamente", context);
                                }
                                break;
                              case  ResourceState.ERROR :
                                Toast.show(eventoo.exception, context);
                                break;
                              case ResourceState.LOADING:
                                break;
                            }
                          });
                        }

                      },
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.only(bottom: 5),
                          height: 50,
                          width: MediaQuery
                              .of(context)
                              .size
                              .width * 0.8,
                          alignment: Alignment.center,
                          child: Text(
                            _disableButton ? "FUERA DE RANDO" : "ACTUALIZAR",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white),
                          ),
                          decoration: BoxDecoration(
                              color: _disableButton
                                  ? Colors.blueGrey
                                  : primaryColor,
                              borderRadius: BorderRadius.circular(25)),
                        ),
                      ),
                    )
                  ],
                ),
              ), viewModelBuilder: () => ProductsViewModel()),
    );
  }

/*

 */
  void setMarker(LatLng point) {
    final String markerId = "2";
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId(markerId),
          position: point,
          icon: marcador != null ? marcador : BitmapDescriptor.defaultMarker));
    });
  }

  _onMapIndle() async {
    bool result = await GoogleMapPolyUtil.containsLocation(
        point: _lastMapPosition, polygon: polilyne);
    setState(() {
      _disableButton = !result;
    });
  }

  Widget _googleMapsWidget() {
    return Stack(
      children: [
        Container(
          child: GoogleMap(
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: _kGooglePlex,
            polylines: _polyline,
            onCameraMove: _onCameraMove,
            onCameraIdle: _onMapIndle,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: _markers,
          ),
        ),
        Center(
          child: Image.asset("assets/marker_daloo.png"),
        ),
      ],
    );
  }

  static LatLng _lastMapPosition;

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

  _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
  }
}
