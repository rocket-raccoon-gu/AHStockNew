import 'dart:developer';
import 'dart:io';

import 'package:ahstock/Sales/presentation_layer/features/feature_login/bloc/login_cubit.dart';
import 'package:ahstock/Sales/widgets/custom_app_componenets/textfields/custom_text_form_field.dart';
import 'package:ahstock/global_methods/global_colors.dart';
import 'package:ahstock/services/service_locator.dart';
import 'package:ahstock/theme/styles.dart';
import 'package:ahstock/user_controller/user_controller.dart';
import 'package:ahstock/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

class LoginPage extends StatefulWidget {
  final ServiceLocator serviceLocator;
  const LoginPage({Key? key, required this.serviceLocator}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late GlobalKey<FormState> idFormKey = GlobalKey<FormState>();
  late GlobalKey<FormState> passFormKey = GlobalKey<FormState>();
  late GlobalKey<FormState> otpFormKey = GlobalKey<FormState>();
  Key idKey = UniqueKey();
  Key passKey = UniqueKey();
  TextEditingController idcontroller = TextEditingController();
  TextEditingController otpcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  final focus1 = FocusNode();
  final focus2 = FocusNode();
  final focus3 = FocusNode();
  // final Stream<NetworkStatus> _stream =
  //     NetworkStatusService.networkStatusController.stream;
  // var scrollcontroller = ScrollController();
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  bool biometricAuthAvailable = false;

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _stream.listen((NetworkStatus status) {
  //     if (status == NetworkStatus.Online) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           showSuccessDialogue(message: "Internet connection restored"));
  //     } else if (status == NetworkStatus.Offline) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //           showErrorDialogue1(errorMessage: "Internet connection lost"));
  //     }
  //   });
  //   checkInternetConnection(context);
  //   _initPackageInfo();
  //   // storecurrentlocation();
  //   // biometricAuthInit();
  // }

  // @override
  // dispose() {
  //   super.dispose();
  // }

  // checkInternetConnection(BuildContext context) async {
  //   try {
  //     final result = await InternetAddress.lookup('google.com');
  //     if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) return;
  //   } on SocketException catch (_) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //         showErrorDialogue1(errorMessage: "No internet connection"));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double mheight = MediaQuery.of(context).size.height * 1.22;

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(0.0),
            child: AppBar(
              elevation: 0,
              backgroundColor: HexColor('#F9FBFF'),
            )),
        resizeToAvoidBottomInset: true,
        backgroundColor: HexColor('#F9FBFF'),
        body: BlocConsumer<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginInitial) {
              if (state.errorcode != "200") {
                showSnackBar(
                    context: context,
                    snackBar: showSuccessDialogue(message: state.errorMessage));
              }
              //else {
              //   showSnackBar(
              //       context: context,
              //       snackBar: showSuccessDialogue(message: "Login Success"));
              // }
            }
          },
          builder: (context, state) {
            if (state is LoginInitial) {
              return GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ConstrainedBox(
                        constraints: const BoxConstraints(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            //                         Padding(
                            //                           padding: const EdgeInsets.only(top: 40.0),
                            //                           child: InkWell(
                            //                             onTap: () async {
                            //                               context.gNavigationService
                            //                                   .openSignupPage(context, {});
                            //                             },
                            //                             child: Text(
                            //                               "Create New Account",
                            //                               style: customTextStyle(
                            //                                   fontStyle: FontStyle.BodyL_Bold,
                            //                                   color: FontColor.DodgerBlue),
                            //                             ),
                            //                           ),
                            //                         ),
                            Padding(
                              padding: EdgeInsets.only(top: 95),
                              child: SizedBox(
                                  height: 110,
                                  width: 250,
                                  child: Image.asset("assets/logoprimary.png")),
                            ),
                            Form(
                                key: idFormKey,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 20, left: 16.0, right: 16.0),
                                      child: CustomTextFormField(
                                        context: context,
                                        controller: idcontroller,
                                        fieldName: "UserName",
                                        hintText: " Enter UserName",
                                        validator: Validator.defaultValidator,
                                        autoFocus: true,
                                        focusNode: focus1,
                                        // inputFormatter: [
                                        //   LengthLimitingTextInputFormatter(30)
                                        // ],
                                        onFieldSubmit: (value) async {
                                          if (idFormKey.currentState != null) {
                                            if (!idFormKey.currentState!
                                                .validate()) return;
                                          }
                                        },
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10, left: 16.0, right: 16.0),
                                      child: CustomTextFormField(
                                        autofillHints: [AutofillHints.password],
                                        context: context,
                                        keyboardType:
                                            TextInputType.visiblePassword,
                                        controller: passwordcontroller,
                                        fieldName: "Password",
                                        hintText: " Enter Password",
                                        autoFocus: true,
                                        validator: Validator.password,
                                        focusNode: focus2,
                                        inputFormatter: [
                                          LengthLimitingTextInputFormatter(30)
                                        ],
                                        obscureTextStatus: true,
                                        obscureIcon: true,
                                        onFieldSubmit: (value) async {
                                          if (idFormKey.currentState != null) {
                                            if (!idFormKey.currentState!
                                                .validate()) return;
                                            if (passwordcontroller
                                                .text.isNotEmpty) {
                                              BlocProvider.of<LoginCubit>(context)
                                                  .sendloginRequest(
                                                      context: context,
                                                      userid: idcontroller.text
                                                          .trim(),
                                                      password:
                                                          passwordcontroller
                                                              .text
                                                              .trim(),
                                                      packageInfo:
                                                          _packageInfo);
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                    // Padding(
                                    //   padding: const EdgeInsets.only(
                                    //       top: 10, right: 16.0, left: 16.0),
                                    //   child: Row(
                                    //     mainAxisAlignment:
                                    //         MainAxisAlignment.end,
                                    //     children: [
                                    //       InkWell(
                                    //         onTap: () {
                                    //           // Navigator.push(
                                    //           //     context,
                                    //           //     PageRouteBuilder(
                                    //           //         transitionDuration:
                                    //           //             const Duration(seconds: 1),
                                    //           //         pageBuilder: (BuildContext context,
                                    //           //             Animation<double> animation,
                                    //           //             Animation<double>
                                    //           //                 secondAnimation) {
                                    //           //           return SlideTransition(
                                    //           //               position: Tween<Offset>(
                                    //           //                 begin:
                                    //           //                     const Offset(100, 0.0),
                                    //           //                 end: Offset.zero,
                                    //           //               ).animate(animation),
                                    //           //               child: CustomWebviewPage(
                                    //           //                   title: "Forgot Password",
                                    //           //                   urlAddress: CommonUrls
                                    //           //                       .forgotPasswordUrl));
                                    //           //         }));
                                    //         },
                                    //         child: Text(
                                    //           "Forgot Password",
                                    //           style: customTextStyle(
                                    //               fontStyle:
                                    //                   FontStyle.BodyM_SemiBold,
                                    //               color: FontColor.Primary),
                                    //         ),
                                    //       ),
                                    //     ],
                                    //   ),
                                    // ),

                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: mheight * .040,
                                          left: 16.0,
                                          right: 16.0),
                                      child: InkWell(
                                        onTap: () {
                                          print("hihi");
                                          if (passwordcontroller
                                                  .text.isNotEmpty &&
                                              idcontroller.text.isNotEmpty) {
                                            if (idFormKey.currentState!
                                                    .validate() &&
                                                passwordcontroller
                                                    .text.isNotEmpty) {
                                              UserController.userController
                                                      .appVersion =
                                                  _packageInfo.version;
                                              BlocProvider.of<LoginCubit>(
                                                      context)
                                                  .sendloginRequest(
                                                      context: context,
                                                      userid: idcontroller.text,
                                                      password:
                                                          passwordcontroller
                                                              .text,
                                                      packageInfo:
                                                          _packageInfo);
                                            }
                                          } else {
                                            showSnackBar(
                                                context: context,
                                                snackBar: showErrorDialogue1(
                                                    errorMessage:
                                                        "username and password required...!"));
                                          }
                                        },
                                        child: Container(
                                          height: 50,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                              color: Color.fromRGBO(
                                                  183, 214, 53, 1),
                                              borderRadius:
                                                  BorderRadius.circular(5.0)),
                                          child: Center(
                                            child: Text("Login"),
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            } else if (state is LoginLoading) {
              return Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      height: 100,
                      width: 250,
                      child: Image.asset("assets/logo.png")),
                  const SizedBox(
                    height: 12.0,
                  ),
                  const SizedBox(
                      width: 100,
                      child: ProgressIndicator(
                        duration: Duration(seconds: 25),
                      ))
                ],
              ));
            } else {
              return Container();
            }
          },
        ));
  }

  // Future<void> _initPackageInfo() async {
  //   final info = await PackageInfo.fromPlatform();

  //   setState(() {
  //     _packageInfo = info;
  //   });
  //   // String data = await PlatformRepository.changeColor("RED");
  //   // showSnackBar(
  //   //     context: context,
  //   //     snackBar: showErrorDialogue(
  //   //         errorMessage: "compleated native methord and value is $data"));
  // }
}

// storecurrentlocation() async {
//   Position position = await Geolocator.getCurrentPosition(
//       desiredAccuracy: LocationAccuracy.high);

//   MapLatLng center;

//   UserController.userController.locationlatitude = position.latitude.toString();
//   UserController.userController.locationlongitude =
//       position.longitude.toString();

//   print("current location");

//   print("latitude" + UserController().locationlatitude);
//   print("longitude" + UserController().locationlongitude);

//   await PreferenceUtils.storeDataToShared(
//       "latitude", position.latitude.toString());

//   await PreferenceUtils.storeDataToShared(
//       "longitude", position.longitude.toString());

//   var geocoder = GeocodingPlatform.instance;

//   // try {
//   //   List<Placemark> placemark11 = await geocoder.placemarkFromCoordinates(
//   //       position.latitude, position.longitude);

//   //   print("my Street" + placemark11.first.street.toString());
//   //   List<Location> locations = await geocoder.locationFromAddress("Aldaayen");
//   //   List<Placemark> placemarks = await geocoder.placemarkFromCoordinates(
//   //       locations.first.latitude, locations.first.longitude);

//   //   print("Address to latlang  latitude:" +
//   //       locations.first.latitude.toString() +
//   //       "  Longitude:" +
//   //       locations.first.longitude.toString());

//   //   print("street" + placemarks.first.name.toString());

//   //   print("country" + placemarks.first.country.toString());

//   //   print("locality" + placemarks.first.locality.toString());

//   double distence = calculateDistance(locations.first.latitude,
//       locations.first.longitude, position.latitude, position.longitude);

//   //   print("distence : " + distence.toString() + "KM");
//   // } catch (e) {
//   //   log(e.toString(), stackTrace: StackTrace.current);
//   //   return "";
//   // }
// }

class ProgressIndicator extends StatefulWidget {
  final Duration duration;
  const ProgressIndicator(
      {Key? key, this.duration = const Duration(seconds: 5)})
      : super(key: key);

  @override
  State<ProgressIndicator> createState() => _ProgressIndicatorState();
}

class _ProgressIndicatorState extends State<ProgressIndicator>
    with TickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..addListener(() {
        setState(() {});
      });
    controller.repeat(period: widget.duration);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
        value: controller.value, color: customColors().primary);
  }
}
