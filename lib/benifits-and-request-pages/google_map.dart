
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:login_ui/benifits-and-request-pages/resortDetails.dart';

class ResortsMap extends StatefulWidget {
  @override
  _ResortsMapState createState() => _ResortsMapState();
}

class _ResortsMapState extends State<ResortsMap> {

  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(7.5472142,80.1596661);

  LatLng _lastMapPosition = _center;
  MapType _currentMapType = MapType.normal;

  _onMapCreated(GoogleMapController controller){
   setState(() {
     // _marker.add(Marker(
     //   markerId: MarkerId('1'),
     //   position: LatLng(6.820801, 80.040664),
     //   infoWindow: InfoWindow(
     //     title: 'NSBM',
     //     snippet: 'Place Where it all began'
     //   )
     // ));

   });
  }
  _onCameraMove(CameraPosition position){
    _lastMapPosition = position.target;
  }

  @override
  Widget build(BuildContext context) {
    final Set<Marker> _marker ={
      Marker(
          markerId: MarkerId('1'),
          position: LatLng(6.413948, 81.332926),
          infoWindow: InfoWindow(
              title: 'Kataragama',
              snippet: 'View'
          )
      ),
      Marker(
          markerId: MarkerId('2'),
          position: LatLng(6.947087, 80.788687),
          infoWindow: InfoWindow(
              title: 'Nuwara Eliya',
              snippet: 'View'
          )
      ),
      Marker(
          markerId: MarkerId('3'),
          position: LatLng(9.668625, 80.018604),
          infoWindow: InfoWindow(
              title: 'Jaffna',
              snippet: 'Near jaffna'
          )
      ),
      Marker(
          markerId: MarkerId('4'),
          position: LatLng(8.588069, 81.224791),
          infoWindow: InfoWindow(
              onTap: (){
                print('helo');
                Navigator.push(context, MaterialPageRoute(builder: (context) => ResortDetails()));
              },

              title: 'Trinco',
              snippet: 'resort '
          )
      ),
      Marker(
          markerId: MarkerId('4'),
          position: LatLng(6.035187, 80.211546),
          infoWindow: InfoWindow(
              title: 'Galle',
              snippet: 'View '
          )
      ),

    };
    return  Scaffold(
        appBar: AppBar(
          title:Text('Resorts'),
          backgroundColor: Colors.blue,
        ),
        body:
            GoogleMap(
              onMapCreated: _onMapCreated,
                markers: _marker,
                initialCameraPosition: CameraPosition(
                  target: _center,
                  zoom: 8.0
                ),
              //mapType: _currentMapType,
              //markers: _marker,
              //onCameraMove: _onCameraMove,
            )


      );

  }
}
