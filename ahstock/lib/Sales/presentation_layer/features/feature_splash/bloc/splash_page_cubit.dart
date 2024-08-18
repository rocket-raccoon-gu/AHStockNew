import 'dart:developer';


import 'package:ahstock/Sales/presentation_layer/features/feature_splash/bloc/splash_page_state.dart';
import 'package:ahstock/services/service_locator.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

class SplashInitialPageCubit extends Cubit<SplashInitialPageState> {
  final ServiceLocator serviceLocator;
  BuildContext context;
  SplashInitialPageCubit(this.context, {required this.serviceLocator})
      : super(SplashPageInitial()) {
    updatedata();
  }

  updatedata() {
    log("...............................................................hola...........................................");
    // _handleLocationPermission();
    emit(SplashPageInitial());
  }

  // _handleLocationPermission() async {
  //   var status = await Permission.location.status;

  //   if (status.isDenied) {
  //     //Request Permission if granted
  //     await Permission.location.request();

  //     // You can handle the result of the permission request here
  //     var newstatus = await Permission.location.status;

  //     if (newstatus.isGranted) {
  //       //Permission granted,you can now access location

  //       log("Location Permission Granted");

  //       Position position = await Geolocator.getCurrentPosition(
  //           desiredAccuracy: LocationAccuracy.high);

  //       // Access the latitude and longitude values from the position object
  //       double latitude = position.latitude;
  //       double longitude = position.longitude;

  //       // Use the latitude and longitude values as needed
  //       print('Latitude1: $latitude');
  //       print('Longitude2: $longitude');
  //       UserController.userController.locationlatitude = latitude.toString();
  //       UserController.userController.locationlongitude = longitude.toString();

  //       PreferenceUtils.storeDataToShared('Latitude1', latitude.toString());
  //       PreferenceUtils.storeDataToShared('Longitude2', longitude.toString());
  //     } else {
  //       //Permission denied

  //       await Permission.location.request();

  //       // You can handle the result of the permission request here
  //       var newstatus = await Permission.location.status;

  //       log("Location Permission Denied");
  //     }
  //   }

  //   return true;
  // }


}
