import 'dart:async';

import 'package:farmpicks/lib.dart';
import 'package:farmpicks/views/screens/main_screen.dart';
//import 'package:farmpicks/views/screens/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
  
  late GoogleMapController mapController;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  
  late Position currentPosition;
  getUserCurrentLocation()async{
   await Geolocator.checkPermission();

   await Geolocator.requestPermission();

   Position position=await Geolocator.getCurrentPosition(
       desiredAccuracy: LocationAccuracy.bestForNavigation,
       forceAndroidLocationManager: true
   );


   currentPosition=position;
   
   LatLng pos= LatLng(position.latitude, position.longitude);
   
   CameraPosition cameraPosition = CameraPosition(
     target: pos,
     zoom: 16
   );
   mapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            myLocationButtonEnabled: true,
            myLocationEnabled: true,
            padding: EdgeInsets.only(bottom: 200),
            mapType: MapType.hybrid,
            initialCameraPosition:_kGooglePlex ,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);

              mapController = controller;

              getUserCurrentLocation();



            },
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 150 ,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width-70,
                    child: ElevatedButton.icon(
                        onPressed: (){

                          Get.offAll(MainScreen());
                       //   print(currentPosition);

                           // lat=currentPosition.latitude;
                          //  long=currentPosition.longitude;



                        },
                        icon: Icon(CupertinoIcons.shopping_cart),
                        label: Text('SHOP NOW',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),)
                    ),
                  )

                ],
              )
            ),
          ),
        ],
      ),
    );
  }
}
