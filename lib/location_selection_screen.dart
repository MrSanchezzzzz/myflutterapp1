
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:maps_toolkit/maps_toolkit.dart' as MapToolkit;
import 'Widgets/button.dart';
class LocationSelectionScreen extends StatefulWidget{
  @override
  State<LocationSelectionScreen> createState() => _LocationSelectionScreenState();
  bool enabled=false;
  bool buttonEnabled=false;
  LatLng location=LatLng(0, 0);
  Function(LatLng location)? onLocationSelectedCallback;
  LocationSelectionScreen({Key? key, this.onLocationSelectedCallback}) : super(key: key);
}
//TODO: save marker so it will be shown at next start
class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
  bool _permissionGranted=false;
  Set<Marker> markers=new Set();
  List<LatLng> polygon=[
    LatLng(43.74990865154158, -79.64242354250521),
    LatLng(43.55565506364909, -79.52844038557035),
    LatLng(43.67546110219687, -79.04504193688277),
    LatLng(43.8554652578004, -79.16932477667318)
  ];
  List<MapToolkit.LatLng> MapToolkitPolygon=[
    MapToolkit.LatLng(43.74990865154158, -79.64242354250521),
    MapToolkit.LatLng(43.55565506364909, -79.52844038557035),
    MapToolkit.LatLng(43.67546110219687, -79.04504193688277),
    MapToolkit.LatLng(43.8554652578004, -79.16932477667318)
  ];
  Set<Polygon> polygons=Set();
  late BitmapDescriptor markerIcon;
  @override
  void initState(){
    super.initState();
    Polygon p=Polygon(polygonId: PolygonId(""),points: polygon,fillColor: Color(0x594D662D),strokeColor: Color(0xff4D662D));
    polygons.add(p);
    BitmapDescriptor.fromAssetImage(
        ImageConfiguration(size: Size(72, 72)), 'assets/images/marker.png')
        .then((onValue) {
      markerIcon = onValue;
    });
  }
  @override
  Widget build(BuildContext context) {
    checkLocationPermissionStatus();
    Timer(Duration(seconds: 1),(){});
    if (_permissionGranted) {
      return Scaffold(
        body: Container(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height-1,maxWidth: MediaQuery.of(context).size.width-1),
            child:
              Stack(
                children: [
                  GoogleMap(
                    initialCameraPosition: CameraPosition(target: LatLng(43.72596756437911, -79.38094447416759),zoom:12.5),
                    onTap:(pos){
                      MapToolkit.LatLng l=MapToolkit.LatLng(pos.latitude,pos.longitude);
                      if(MapToolkit.PolygonUtil.containsLocation(l, MapToolkitPolygon, false)) {
                        MarkerId mId = MarkerId("");
                        Marker m = Marker(
                          markerId: mId,
                          position: pos,
                          icon: markerIcon,
                        );
                        widget.buttonEnabled=true;
                        markers.add(m);
                        widget.location=pos;
                        setState(() {

                        });
                      }
                      else
                        widget.buttonEnabled=false;
                      },
                    markers: markers,
                    polygons: polygons,
                    zoomControlsEnabled: false,

                    ),
                  Container(
                    alignment: Alignment.bottomCenter,
                    padding: EdgeInsets.symmetric(horizontal: 20,vertical: 32),
                    child: Button(text: "Обрати",onTap: (widget.buttonEnabled)?
                        (){
                      widget.onLocationSelectedCallback!(widget.location);
                      Navigator.pop(context);
                    }:(){},
                      enabled: widget.buttonEnabled,),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 28),
                    alignment: Alignment.topRight,
                    child: CloseButton()
                    )
                ],
              ),
              )
      );
    }
    return Scaffold(

    );
  }
  void checkLocationPermissionStatus() async{
    _permissionGranted=await Permission.locationWhenInUse.isGranted;
    if(widget.enabled==false) {
      widget.enabled=true;

      setState(() {});

    }
  }
}