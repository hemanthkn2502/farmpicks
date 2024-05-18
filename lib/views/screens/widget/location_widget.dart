
import 'package:farmpicks/cont/api_key.dart';
import 'package:farmpicks/lib.dart';
import 'package:flutter/material.dart';
import 'package:flutter_address_from_latlng/flutter_address_from_latlng.dart';

class LocationWidget extends StatefulWidget {

  const LocationWidget({super.key});



  @override
  State<LocationWidget> createState() => _LocationWidgetState();
}

class _LocationWidgetState extends State<LocationWidget> {
  Future<String> getData() async {
    return await FlutterAddressFromLatLng()
        .getFormattedAddress(
      latitude: lat,
      longitude: long,
      googleApiKey: mapKey,
    );
  }
  @override
  Widget build(BuildContext context) {
   late String formattedAddress='';












    return Padding(
      padding: const EdgeInsets.only(top:25.0,
      left:20,
      right: 20
      ),
      child: Row(
        children:[
          Image.asset('assets/icons/store-1.png',
          width:30,),
          Image.asset('assets/icons/pickicon.png',
          width: 30,
          ),
          SizedBox(width:12),
          Flexible(
              child: SizedBox(
                width:300,

                child: TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Current Location',
                    labelText: 'Current Location',
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
                /*FutureBuilder(
                  builder: (context,snapshot)
                  {
                    if (snapshot.connectionState == ConnectionState.done) {
                      // If we got an error
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            '${snapshot.error} occurred',
                            style: TextStyle(fontSize: 8),
                          ),
                        );

                        // if we got our data
                      } else if (snapshot.hasData) {
                        // Extracting data from snapshot object
                        String data = snapshot.data as String;
                        String address=data.substring(0,60);
                        return Center(
                          child: Text(
                            '$address.....',
                            style: TextStyle(fontSize: 13),
                          ),
                        );
                      }
                    }

                    // Displaying LoadingSpinner to indicate waiting state
                    return Center(
                      child: CircularProgressIndicator(),
                    );

                      
                  }, future: getData(),

                ),*/
              )
          ),
        ]
      ),
    );
  }
}



/*TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    hintText: 'Current Location',
                    labelText: 'Current Location',
                    border: InputBorder.none,
                    isDense: true,
                  ),
                ),
                */
