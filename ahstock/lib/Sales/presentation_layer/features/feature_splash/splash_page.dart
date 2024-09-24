import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:ahstock/app_page_injectable.dart';
import 'package:ahstock/Sales/presentation_layer/features/feature_splash/bloc/splash_page_cubit.dart';
import 'package:ahstock/Sales/presentation_layer/features/feature_splash/bloc/splash_page_state.dart';
import 'package:ahstock/constants/prefefence_utils.dart';
import 'package:ahstock/theme/styles.dart';
import 'package:ahstock/user_controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:stock_api/responses/profile_response.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageNewState();
}

class _SplashPageNewState extends State<SplashPage>
    with WidgetsBindingObserver {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  @override
  void initState() {
    super.initState();

    _initPackageInfo();
    getUserCode(context);
    // _handleLocationPermission();
    // UserController.userController.alloworderRequest = true;
    // UserController.userController.selectedindex = 0;
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  bool serviceEnabled = false;

  getUserCode(BuildContext context) async {
    print("Start time ${DateTime.now()}");

    if (await PreferenceUtils.preferenceHasKey('mainbaseurl')) {
      await Future.delayed(const Duration(seconds: 1));

      String? base = await PreferenceUtils.getDataFromShared('mainbaseurl');

      switch (base) {
        case 'https://admin-qatar.testuatah.com/':
          //         // Qatar region page
          if (await PreferenceUtils.preferenceHasKey("userCode")) {
            //           // ignore: use_build_context_synchronously
            var profileres =
                await context.gTradingApiGateway.getProfile(context);

            if (profileres.toString().contains("HandshakeException")) {
            } else {
              Map<String, dynamic> userMap1 = jsonDecode(profileres!);
              if (userMap1.containsKey('success') && userMap1['success'] == 0) {
                //    session expired
                // ignore: use_build_context_synchronously
                context.gNavigationService.openLoginPage(context);
              } else {
                UserController.userController.userId =
                    (await PreferenceUtils.getDataFromShared("userCode"))!;
                UserController.userController.usertoken =
                    (await PreferenceUtils.getDataFromShared("usertoken"))!;

                UserController.userController.userName =
                    (await PreferenceUtils.getDataFromShared("userCode"))!;

                String? prs =
                    await PreferenceUtils.getDataFromShared("profiledetails");
                // String? regionurl =
                //     await PreferenceUtils.getDataFromShared('mainbaseurl');
                // UserController.userController.mainbaseUrl = regionurl!;

                ProfileResponce profileResponce =
                    ProfileResponce.fromJson(userMap1);
                UserController.userController.profileResponce = profileResponce;

                print("user =${profileResponce.user[0].name}");

                UserController.userController.userstat =
                    profileResponce.user[0].availabilityStatus == "0"
                        ? false
                        : true;

                DateTime givenTime = DateTime.now();

                // Define the start and end times for your range
                DateTime startTime = DateTime(
                    givenTime.year,
                    givenTime.month,
                    givenTime.day,
                    int.parse(DateFormat.H().format(givenTime).toString()),
                    int.parse(DateFormat.m()
                        .format(givenTime)
                        .toString())); // 2:00 PM
                DateTime endTime = DateTime(givenTime.year, givenTime.month,
                    givenTime.day, 23, 59); // 11:59 PM

                print("${DateFormat.H().format(givenTime)} time aag");

                Map<String, dynamic> data = {"selected": 0};

                UserController.userController.mainbaseUrl =
                    'https://admin-qatar.testuatah.com/';

                if (UserController
                        .userController.profileResponce.user[0].role ==
                    "5") {
                  // ignore: use_build_context_synchronously
                  context.gNavigationService
                      .openSalesMansDashboardPage(context, data);
                  // } else if (UserController
                  //         .userController.profileResponce.user[0].role ==
                  //     "7") {
                  //   // ignore: use_build_context_synchronously
                  //   context.gNavigationService
                  //       .openSalesMansDashboardPage(context, data);
                  // } else if (UserController
                  //         .userController.profileResponce.user[0].role ==
                  //     "6") {
                  //   // ignore: use_build_context_synchronously
                  //   context.gNavigationService
                  //       .openSectionInchargeHomePage(context, data);
                } else {
                  context.gNavigationService
                      .openSalesMansDashboardPage(context, data);

                  // ignore: use_build_context_synchronously
                  // context.gNavigationService.openWorkspacePage(context, data);
                }
              }
            }
          } else {
            // ignore: use_build_context_synchronously
            context.gNavigationService.openLoginPage(context);
          }
          break;

        case 'https://uae.ahmarket.com/':

          //uae region page
          if (await PreferenceUtils.preferenceHasKey("userCode")) {
            String? userid11 =
                await PreferenceUtils.getDataFromShared("userCode");

            if (userid11 == "ahuae_sales") {
              //uae scanner page
              Map<String, dynamic> data = {"selected": 0};

              UserController.userController.userName = userid11!;

              // ignore: use_build_context_synchronously
              context.gNavigationService
                  .openSalesMansDashboardPage(context, data);
            } else {
              // ignore: use_build_context_synchronously
              context.gNavigationService.openLoginPage(context);
            }
          } else {
            // ignore: use_build_context_synchronously
            context.gNavigationService.openLoginPage(context);
          }

          break;

        case 'https://oman.ahmarket.com/':

          //uae region page
          if (await PreferenceUtils.preferenceHasKey("userCode")) {
            String? userid11 =
                await PreferenceUtils.getDataFromShared("userCode");

            if (userid11 == "ahoman_sales") {
              //uae scanner page
              Map<String, dynamic> data = {"selected": 0};

              UserController.userController.userName = userid11!;

              // ignore: use_build_context_synchronously
              context.gNavigationService
                  .openSalesMansDashboardPage(context, data);
            } else {
              // ignore: use_build_context_synchronously
              context.gNavigationService.openLoginPage(context);
            }
          } else {
            // ignore: use_build_context_synchronously
            context.gNavigationService.openLoginPage(context);
          }
          break;
        case 'https://bahrain.ahmarket.com/':

          //bahrain region

          if (await PreferenceUtils.preferenceHasKey("userCode")) {
            String? userid11 =
                await PreferenceUtils.getDataFromShared("userCode");

            if (userid11 == "ahbahrain_sales") {
              //uae scanner page
              Map<String, dynamic> data = {"selected": 0};

              UserController.userController.userName = userid11!;

              // ignore: use_build_context_synchronously
              context.gNavigationService
                  .openSalesMansDashboardPage(context, data);
            } else {
              // ignore: use_build_context_synchronously
              context.gNavigationService.openLoginPage(context);
            }
          } else {
            // ignore: use_build_context_synchronously
            context.gNavigationService.openLoginPage(context);
          }
          break;
        default:
      }

      //     // if (await PreferenceUtils.preferenceHasKey("userCode")) {
      //     //   await Future.delayed(Duration(seconds: 1));

      //     //   String? userid11 = await PreferenceUtils.getDataFromShared("userCode");

      //     //   if (userid11 == "ahuae_sales") {
      //     //     //uae scanner page
      //     //     Map<String, dynamic> data = {"selected": 0};
      //     //     // ignore: use_build_context_synchronously
      //     //     context.gNavigationService.openSalesMansDashboardPage(context, data);
      //     //   } else {
      //     //     // ignore: use_build_context_synchronously
      //     //     var profileres = await context.gTradingApiGateway.getProfile(context);

      //     //     if (profileres.toString().contains("HandshakeException")) {
      //     //       print("ok");
      //     //     } else {
      //     //       Map<String, dynamic> userMap1 = jsonDecode(profileres!);
      //     //       if (userMap1.containsKey('success') && userMap1['success'] == 0) {
      //     //         //session expired
      //     //         context.gNavigationService.openLoginPage(context);
      //     //       } else {
      //     //         UserController.userController.userId =
      //     //             (await PreferenceUtils.getDataFromShared("userCode"))!;
      //     //         UserController.userController.usertoken =
      //     //             (await PreferenceUtils.getDataFromShared("usertoken"))!;

      //     //         String? prs =
      //     //             await PreferenceUtils.getDataFromShared("profiledetails");
      //     //         // String? regionurl =
      //     //         //     await PreferenceUtils.getDataFromShared('mainbaseurl');
      //     //         // UserController.userController.mainbaseUrl = regionurl!;

      //     //         // String? region = await PreferenceUtils.getDataFromShared('region');
      //     //         // print(region);
      //     //         // UserController.userController.region = region!;
      //     //         // ignore: use_build_context_synchronously
      //     //         // var profileres = await context.gTradingApiGateway.getProfile();
      //     //         // Map<String, dynamic> userMap1 = jsonDecode(profileres!);

      //     //         ProfileResponce profileResponce =
      //     //             ProfileResponce.fromJson(userMap1);
      //     //         UserController.userController.profileResponce = profileResponce;

      //     //         print("user =" + profileResponce.user[0].name.toString());

      //     //         DateTime givenTime = DateTime.now();

      //     //         // if (checkdayshift(givenTime, profileResponce.user.offDay)) {
      //     //         //   print("today my offday");
      //     //         //   final resp = await context.gTradingApiGateway.changeuserStat(
      //     //         //     userId: int.parse(UserController().profileResponce.user.id),
      //     //         //     status: 0,
      //     //         //   );
      //     //         //   Map<String, dynamic> dtb = jsonDecode(resp);
      //     //         //   print(dtb["ok"]);
      //     //         //   UserController.userController.dutyval = 0;
      //     //         // } else {
      //     //         //   print("not my offday");
      //     //         //   // ignore: use_build_context_synchronously
      //     //         //   final resp = await context.gTradingApiGateway.changeuserStat(
      //     //         //     userId: int.parse(UserController().profileResponce.user.id),
      //     //         //     status: 1,
      //     //         //   );
      //     //         //   Map<String, dynamic> dtb = jsonDecode(resp);
      //     //         //   print(dtb["ok"]);
      //     //         //   UserController.userController.dutyval = 1;
      //     //         // }

      //     //         // Define the start and end times for your range
      //     //         DateTime startTime = DateTime(
      //     //             givenTime.year,
      //     //             givenTime.month,
      //     //             givenTime.day,
      //     //             int.parse(DateFormat.H().format(givenTime).toString()),
      //     //             int.parse(
      //     //                 DateFormat.m().format(givenTime).toString())); // 2:00 PM
      //     //         DateTime endTime = DateTime(givenTime.year, givenTime.month,
      //     //             givenTime.day, 23, 59); // 11:59 PM

      //     //         print(DateFormat.H().format(givenTime).toString() + " time aag");

      //     //         // await Future.delayed(Duration(seconds: 5));
      //     //         // // context.gNavigationService.openOrderPage(context);
      //     //         Map<String, dynamic> data = {"selected": 0};

      //     //         UserController.userController.mainbaseUrl =
      //     //             'https://admin-qatar.testuatah.com/';

      //     //         // context.gNavigationService.openMapViewPage(context, data);
      //     //         // }

      //     //         // String response =
      //     //         //     await context.gTradingApiGateway.generalPickerService(endpoint: "");

      //     //         // Map<String, dynamic> item = json.decode(response);
      //     //         // print(response.toString());
      //     //         // PickerResponse pickerResponse =
      //     //         //     PickerResponse.fromJson(json.decode(response));

      //     //         // UsersResponce usersResponce = UsersResponce.fromJson(item);

      //     //         // UserController.userController.driverlist = usersResponce.message.driver;

      //     //         // UserController.userController.pickerlist = usersResponce.message.picker;

      //     //         // await Future.delayed(const Duration(seconds: 2));

      //     //         // result = await NominatimGeocoding.to.reverseGeoCoding(
      //     //         //   const Coordinate(
      //     //         //       latitude: 52.27429313260939, longitude: 10.523078303155874),
      //     //         // );
      //     //         // print(result);

      //     //         if (UserController.userController.profileResponce.user[0].role ==
      //     //             "5") {
      //     //           // ignore: use_build_context_synchronously
      //     //           context.gNavigationService.openNewScannerPage(context, data);
      //     //         } else if (UserController
      //     //                 .userController.profileResponce.user[0].role ==
      //     //             "7") {
      //     //           // ignore: use_build_context_synchronously
      //     //           context.gNavigationService
      //     //               .openSalesMansDashboardPage(context, data);
      //     //         } else {
      //     //           // ignore: use_build_context_synchronously
      //     //           context.gNavigationService.openWorkspacePage(context, data);
      //     //         }
      //     //       }
      //     //       String? a = await PreferenceUtils.getDataFromShared("catlist");
      //     //       Map<String, dynamic> userMap = jsonDecode(a!);
      //     //       CategoriesResponce categoriesResponce =
      //     //           CategoriesResponce.fromJson(userMap);
      //     //       UserController.userController.categorylist =
      //     //           categoriesResponce.message;

      //     //       // String? cresp =
      //     //       //     await PreferenceUtils.getDataFromShared("colordataoption");
      //     //       // // Map<String, dynamic> crespMap = jsonDecode(cresp!);

      //     //       // List<ItemColorResponse> itemcolorresplist =
      //     //       //     itemColorResponseFromJson(cresp!);

      //     //       // String? sizeresp =
      //     //       //     await PreferenceUtils.getDataFromShared("sizedataoption");
      //     //       // Map<String, dynamic> crespMap = jsonDecode(cresp!);

      //     //       // final itemresp =
      //     //       //     await context.gTradingApiGateway.tradingApi.getItemSizeResponse();

      //     //       // // Map<String, dynamic> responcemap = jsonDecode(itemresp);

      //     //       // List<ItemSizeResponse> itemresplist = itemSizeResponseFromJson(sizeresp!);

      //     //       // final itemcolorresp =
      //     //       //     await context.gTradingApiGateway.tradingApi.getItemColorResponse();

      //     //       // List<ItemColorResponse> itemcolorresplist =
      //     //       //     itemColorResponseFromJson(itemcolorresp);

      //     //       // print(itemresplist[1].value);
      //     //       // print(itemcolorresplist[1].value);
      //     //       // UserController.userController.itemresplist = itemresplist;
      //     //       // UserController.userController.itemcolorresplist = itemcolorresplist;
      //     //     }
      //     //   }
      //     // } else {
      //     //   await Future.delayed(Duration(seconds: 2));
      //     //   log(".....................okokok");
      //     //   // ignore: use_build_context_synchronously
      //     //   context.gNavigationService.openLoginPage(context);
      //     //   // if (await PreferenceUtils.preferenceHasKey("mainbaseurl")) {
      //     //   //   String? regionurl =
      //     //   //       await PreferenceUtils.getDataFromShared('mainbaseurl');

      //     //   //   String? region =
      //     //   //       await await PreferenceUtils.getDataFromShared('region');
      //     //   //   print(region);
      //     //   //   UserController.userController.region = region!;
      //     //   //   print("end time ${DateTime.now()}");

      //     //   //   if (regionurl.isEmpty) {
      //     //   //     context.gNavigationService.openselectCountryPage(context);
      //     //   //   } else {
      //     //   //     context.gNavigationService.openLoginPage(context);
      //     //   //   }
      //     //   // } else {
      //     //   //   context.gNavigationService.openselectCountryPage(context);
      //     //   // }
      //     // }
      //   } else {
      //     // need to select region
    } else {
      // need to select region

      // ignore: use_build_context_synchronously
      context.gNavigationService.openSelectRegionsPage(context, {});
    }
  }

  // Future<bool> _handleLocationPermission() async {
  //   var status = await Permission.location.status;

  //   if (status.isDenied) {
  //     //Request Permission if granted

  //     // await Permission.location.request();

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
  //       log('Latitude1: $latitude');
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

  //       // ignore: use_build_context_synchronously
  //       showGeneralDialog(
  //         context: context,
  //         barrierDismissible: false,
  //         barrierLabel: "",
  //         pageBuilder: (context, animation, secondaryAnimation) {
  //           return Container();
  //         },
  //         transitionBuilder: (context, animation, secondaryAnimation, child) {
  //           var curve = Curves.easeInOut.transform(animation.value);

  //           return Transform.scale(
  //             scale: curve,
  //             child: AlertDialog(
  //               shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.circular(8.0)),
  //               content: Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   Padding(
  //                     padding: const EdgeInsets.only(top: 20.0, bottom: 25.0),
  //                     child: Text(
  //                       "Location Permission Denied Please Enable The Location Permission..!",
  //                       style: customTextStyle(
  //                           fontStyle: FontStyle.BodyL_Bold,
  //                           color: FontColor.FontPrimary),
  //                     ),
  //                   ),
  //                   Padding(
  //                     padding: const EdgeInsets.only(top: 8.0),
  //                     child: Row(
  //                       mainAxisAlignment: MainAxisAlignment.end,
  //                       children: [
  //                         InkWell(
  //                           onTap: () async {
  //                             // await Permission.location.request();
  //                             Navigator.pop(context);
  //                             await Restart.restartApp();
  //                             openAppSettings();
  //                           },
  //                           child: Container(
  //                             child: Center(
  //                               child: Text("Go To Settings"),
  //                             ),
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                   )
  //                 ],
  //               ),
  //             ),
  //           );
  //         },
  //       );
  //     }
  //   } else if (status.isGranted) {}

  //   // LocationPermission permission;

  //   // serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   // if (!serviceEnabled) {
  //   //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //   //       content: Text(
  //   //           'Location services are disabled. Please enable the services')));
  //   //   return false;
  //   // }

  //   // permission = await Geolocator.checkPermission();
  //   // if (permission == LocationPermission.denied) {
  //   //   permission = await Geolocator.requestPermission();
  //   //   if (permission == LocationPermission.denied) {
  //   //     ScaffoldMessenger.of(context).showSnackBar(
  //   //         const SnackBar(content: Text('Location permissions are denied')));
  //   //     return false;
  //   //   }
  //   // }
  //   // if (permission == LocationPermission.deniedForever) {
  //   //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //   //       content: Text(
  //   //           'Location permissions are permanently denied, we cannot request permissions.')));
  //   //   return false;
  //   // }

  //   // if (permission == LocationPermission.whileInUse ||
  //   //     permission == LocationPermission.always) {
  //   //   Position position = await Geolocator.getCurrentPosition(
  //   //       desiredAccuracy: LocationAccuracy.high);

  //   //   // Access the latitude and longitude values from the position object
  //   //   double latitude = position.latitude;
  //   //   double longitude = position.longitude;

  //   //   // Use the latitude and longitude values as needed
  //   //   print('Latitude1: $latitude');
  //   //   print('Longitude2: $longitude');
  //   //   UserController.userController.locationlatitude = latitude.toString();
  //   //   UserController.userController.locationlongitude = longitude.toString();

  //   //   PreferenceUtils.storeDataToShared('Latitude1', latitude.toString());
  //   //   PreferenceUtils.storeDataToShared('Longitude2', longitude.toString());
  //   // }

  //   return true;
  // }

  // getcurrentlocation() async {
  //   if (serviceEnabled) {
  //     Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high);

  //     // Access the latitude and longitude values from the position object
  //     double latitude = position.latitude;
  //     double longitude = position.longitude;

  //     // Use the latitude and longitude values as needed
  //     print('Latitude1: $latitude');
  //     print('Longitude2: $longitude');
  //     UserController.userController.locationlatitude = latitude.toString();
  //     UserController.userController.locationlongitude = longitude.toString();
  //   }
  // }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   // TODO: implement didChangeAppLifecycleState

  //   if (state == AppLifecycleState.resumed &&
  //       !UserController.userController.isgranted) {
  //     if (Platform.isAndroid && UserController.userController.firsttime) {
  //       print('App Resumed From Background----------------------------------');
  //       log('App Resumed From Background----------------------------------');
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double mheight = MediaQuery.of(context).size.height * 1.222;

    return Scaffold(
      body: BlocBuilder<SplashInitialPageCubit, SplashInitialPageState>(
          builder: (context, state) {
        return Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/splash2.png'), fit: BoxFit.fill),
              ),
              child: Center(
                child: Image.asset(
                  'assets/picker1.png',
                  height: 250,
                ),
              ),
            ),
            Positioned(
                bottom: mheight * .066,
                left: 0.0,
                right: 0.0,
                child: Center(
                  child: Text("Version - ${_packageInfo.version}",
                      style: customTextStyle(
                          fontStyle: FontStyle.BodyL_Bold,
                          color: FontColor.FontPrimary)),
                ))
          ],
        );
      }),
    );
  }
}

bool checkdayshift(DateTime datenow, String offday) {
  if (offday == "sunday" && datenow.weekday == DateTime.sunday) {
    return true;
  } else if (offday == "monday" && datenow.weekday == DateTime.monday) {
    return true;
  } else if (offday == "tuesday" && datenow.weekday == DateTime.tuesday) {
    return true;
  } else if (offday == "wednesday" && datenow.weekday == DateTime.wednesday) {
    return true;
  } else if (offday == "thursday" && datenow.weekday == DateTime.thursday) {
    return true;
  } else if (offday == "friday" && datenow.weekday == DateTime.friday) {
    return true;
  } else if (offday == "saturday" && datenow.weekday == DateTime.saturday) {
    return true;
  } else {
    return false;
  }
}

// String convertTo24HourFormat(String time12Hour) {
//   String tim = time12Hour.trim();
//   print(tim);

//   DateTime time =
//       DateFormat("hh:mma").parse(tim.replaceAll(RegExp(r"\s+"), ''));
//   return DateFormat("HH:mm").format(time).toString();
// }
