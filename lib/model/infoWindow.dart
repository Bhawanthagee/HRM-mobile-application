import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:login_ui/model/resorts.dart';

class InfoWindowModel extends ChangeNotifier{
  bool _showInfoWindow = false;
  bool _tempHidden = false;
  Resorts _resorts;
  double _leftMarging;
  double _topMargin;

  void rebuilInfoWindow(){
    notifyListeners();
  }
  void updateResort(Resorts resorts)
  {
    _resorts = resorts;
  }

  void updateVisibility(bool visibility){
    _showInfoWindow  = visibility;
  }
  void updateInfoWindow(BuildContext context,
      GoogleMapController controller,
      LatLng location,
      double infoWindowWidth,
      double markerOffset,
      )async{
    ScreenCoordinate screenCoordinate = await controller.getScreenCoordinate(location);
    double devicePixelRatio  = Platform.isAndroid?MediaQuery.of(context).devicePixelRatio:1.0;
    double left = (screenCoordinate.x.toDouble() /devicePixelRatio) - (infoWindowWidth/2);
    double top = (screenCoordinate.x.toDouble() /devicePixelRatio) - (markerOffset/2);

    if(left <0 || top <0){
      _tempHidden = true;
    }else{
      _tempHidden = false;
      _leftMarging = left;
      _topMargin = top;
    }
  }
  bool get showInfoWindow =>(_showInfoWindow ==true && _tempHidden==false)?true :false;
  double get leftMargin =>_leftMarging;
  double get topMargin => _topMargin;
  Resorts get resorts => _resorts;

}