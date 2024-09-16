import 'dart:convert';

import 'package:ahstock/constants/prefefence_utils.dart';
import 'package:ahstock/services/service_locator.dart';
import 'package:ahstock/theme/styles.dart';
import 'package:ahstock/user_controller/user_controller.dart';
import 'package:ahstock/utils/user_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:stock_api/responses/profile_response.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final ServiceLocator serviceLocator;
  final BuildContext context;
  String misc3 = "";

  LoginCubit(this.context, {required this.serviceLocator})
      : super(LoginLoading()) {
    getUserCode();
  }
  getUserCode() {
    if (!isClosed) emit(LoginInitial());
  }

  updateUserdata({
    required String username,
    required String userId,
  }) async {
    String? userData = await PreferenceUtils.getDataFromShared("userCode");
    // UserSettings.userSettings.fromJsonString(userData!);
    UserSettings.userSettings.userPersonalSettings.username = username;
    UserSettings.userSettings.userPersonalSettings.tradecode = userId;
    PreferenceUtils.storeDataToShared("userCode", userId);
  }

  updateusercontroller({
    required String userId,
    required String username,
  }) {
    UserController().userName = username;
    UserController().userId = userId;
    updateUserdata(username: username, userId: userId);
  }

  Future<bool> sendloginRequest(
      {required context,
      required String userid,
      required String password,
      required PackageInfo packageInfo}) async {
    if (!isClosed) {
      if (state is LoginInitial) {
        emit((state as LoginInitial).copyWith(loading: true));
      }
    }
    try {
      // uae sales............................................

      // if (userid == "ahuae_sales" ||
      //     userid == "ahoman_sales" ||
      //     userid == "ahbahrain_sales") {
      //   // oman sales...........................................

      //   print("hi");

      //   final responce = await serviceLocator.tradingApi
      //       .loginOtherREgion(userId: userid, password: password);

      //   if (responce.statusCode == 200) {
      //     updateusercontroller(userId: userid, username: userid);
      //     // Map jsonUser = jsonDecode(responce.body);

      //     if (UserController.userController.mainbaseUrl ==
      //         "https://uae.ahmarket.com/") {
      //       UserController.userController.userName = "ahuae_sales";
      //     } else if (UserController.userController.mainbaseUrl ==
      //         "https://oman.ahmarket.com/") {
      //       UserController.userController.userName = "ahoman_sales";
      //     } else if (UserController.userController.mainbaseUrl ==
      //         "https://bahrain.ahmarket.com/") {
      //       UserController.userController.userName = "ahbahrain_sales";
      //     }

      //     Map<String, dynamic> data = {"selected": 0};

      //     emit(LoginInitial(
      //         errorMessage: "Login Success",
      //         errorcode: responce.statusCode.toString()));
      //     // serviceLocator.navigationService.openOrderPage(context);

      //     serviceLocator.navigationService
      //         .openSalesMansDashboardPage(context, data);
      //     // } else {
      //     //   emit(LoginInitial(
      //     //       errorMessage: "Login Failed Try Again !",
      //     //       errorcode: responce.statusCode.toString()));
      //     //   return false;
      //     // }
      //   } else {
      //     emit(LoginInitial(
      //         errorMessage: "Login Failed Try Again !",
      //         errorcode: responce.statusCode.toString()));
      //     return false;
      //   }
      //   return false;
      // } else {
      //   //qatar sales.........................................

      //   final responce = await serviceLocator.tradingApi.loginRequest(
      //       userId: userid, password: password, version: packageInfo.version);

      //   if (responce.statusCode == 200) {
      //     updateusercontroller(userId: userid, username: userid);
      //     Map jsonUser = jsonDecode(responce.body);

      //     if (jsonUser['success'] == 1) {
      //       UserController.userController.usertoken = jsonUser['token'];
      //       print(jsonUser['token']);
      //       await PreferenceUtils.storeDataToShared(
      //           "usertoken", jsonUser['token']);
      //       var profileres =
      //           await serviceLocator.tradingApi.getProfile(context);

      //       Map<String, dynamic> profileitems = json.decode(profileres);
      //       ProfileResponce profileResponce =
      //           ProfileResponce.fromJson(profileitems);

      //       await PreferenceUtils.storeDataToShared(
      //           "profiledetails", jsonEncode(profileResponce));
      //       UserController.userController.profileResponce = profileResponce;
      //       await gettoken(serviceLocator, packageInfo);

      //       UserController.userController.mainbaseUrl =
      //           'https://admin-qatar.testuatah.com/';

      //       UserController.userController.dutyval =
      //           int.parse(profileResponce.user[0].availabilityStatus);

      //       await PreferenceUtils.storeDataToShared("dutyval", "1");

      //       emit(LoginInitial(
      //           errorMessage: "Login Success",
      //           errorcode: responce.statusCode.toString()));
      //       // serviceLocator.navigationService.openOrderPage(context);

      //       Map<String, dynamic> data = {"selected": 0};
      //       if (profileResponce.user[0].role == "5") {
      //         serviceLocator.navigationService
      //             .openNewScannerPage(context, data);
      //       } else if (profileResponce.user[0].role == "7") {
      //         serviceLocator.navigationService
      //             .openSalesMansDashboardPage(context, data);
      //       } else {
      //         serviceLocator.navigationService.openWorkspacePage(context, data);
      //       }
      //     } else {
      //       showGeneralDialog(
      //         context: context,
      //         barrierDismissible: true,
      //         barrierLabel: "",
      //         pageBuilder: (context, animation, secondaryanimation) {
      //           return Container();
      //         },
      //         transitionBuilder:
      //             (context, animation, secondaryAnimation, child) {
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
      //                   Lottie.asset('assets/update_error.json', height: 100.0),
      //                   Row(
      //                     children: [
      //                       Expanded(
      //                         child: Text(
      //                           "Your Account Was Disabled Please Contact With Admin..!",
      //                           textAlign: TextAlign.center,
      //                           style: customTextStyle(
      //                               fontStyle: FontStyle.BodyL_Bold,
      //                               color: FontColor.Danger),
      //                         ),
      //                       ),
      //                     ],
      //                   ),
      //                   Padding(
      //                     padding: const EdgeInsets.only(top: 8.0),
      //                     child: InkWell(
      //                       onTap: () {
      //                         Navigator.pop(context);
      //                       },
      //                       child: Container(
      //                         padding:
      //                             const EdgeInsets.symmetric(vertical: 13.0),
      //                         decoration: BoxDecoration(
      //                             color: customColors().carnationRed,
      //                             borderRadius: BorderRadius.circular(5.0)),
      //                         child: Center(
      //                           child: Text(
      //                             "OK",
      //                             style: customTextStyle(
      //                                 fontStyle: FontStyle.BodyM_Bold,
      //                                 color: FontColor.White),
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                   )
      //                 ],
      //               ),
      //             ),
      //           );
      //         },
      //       );
      //     }

      getBaseLogin(userid, password, packageInfo);

      // if (userid == "ahqa_sales" && password == "sales@2024") {
      //   Map<String, dynamic> mapdata = {"selected": 0};

      //   emit(LoginInitial(errorMessage: "Login Success", errorcode: ""));
      //   // serviceLocator.navigationService.openOrderPage(context);

      //   serviceLocator.navigationService
      //       .openSalesMansDashboardPage(context, mapdata);
      // }

      return true;
      //   } else {

      // }
    } catch (e) {
      if (state is LoginInitial) {
        emit((state as LoginInitial)
            .copyWith(error: "Login Failed Try Again...!"));
      } else {
        emit(LoginInitial(errorMessage: "Login Failed Try Again...!"));
      }
      return false;
    }
  }

  getBaseLogin(String userid, String password, PackageInfo packageInfo) async {
    Map<String, dynamic> mapdata = {"selected": 0};

    switch (UserController.userController.mainbaseUrl) {
      case 'https://uae.ahmarket.com/':
        final responce = await serviceLocator.tradingApi
            .loginOtherREgion(userId: userid, password: password);

        if (responce.statusCode == 200) {
          updateusercontroller(userId: userid, username: userid);
          // Map jsonUser = jsonDecode(responce.body);

          if (userid == "ahuae_sales") {
            emit(LoginInitial(
                errorMessage: "Login Success",
                errorcode: responce.statusCode.toString()));
            // serviceLocator.navigationService.openOrderPage(context);

            serviceLocator.navigationService
                .openSalesMansDashboardPage(context, mapdata);
          } else {}

          emit(LoginInitial(
              errorMessage: "Login Success",
              errorcode: responce.statusCode.toString()));
        } else {
          emit(LoginInitial(
              errorMessage: "Login Failed Try Again !",
              errorcode: responce.statusCode.toString()));
          return false;
        }

        break;
      case 'https://oman.ahmarket.com/':
        final responce = await serviceLocator.tradingApi
            .loginOtherREgion(userId: userid, password: password);

        if (responce.statusCode == 200) {
          updateusercontroller(userId: userid, username: userid);
          // Map jsonUser = jsonDecode(responce.body);

          if (userid == "ahoman_sales") {
            emit(LoginInitial(
                errorMessage: "Login Success",
                errorcode: responce.statusCode.toString()));
            // serviceLocator.navigationService.openOrderPage(context);

            serviceLocator.navigationService
                .openSalesMansDashboardPage(context, mapdata);
          } else {}

          emit(LoginInitial(
              errorMessage: "Login Success",
              errorcode: responce.statusCode.toString()));
        } else {
          emit(LoginInitial(
              errorMessage: "Login Failed Try Again !",
              errorcode: responce.statusCode.toString()));
          return false;
        }

        break;
      case 'https://bahrain.ahmarket.com/':
        final responce = await serviceLocator.tradingApi
            .loginOtherREgion(userId: userid, password: password);

        if (responce.statusCode == 200) {
          updateusercontroller(userId: userid, username: userid);
          // Map jsonUser = jsonDecode(responce.body);

          if (userid == "ahbahrain_sales") {
            emit(LoginInitial(
                errorMessage: "Login Success",
                errorcode: responce.statusCode.toString()));
            // serviceLocator.navigationService.openOrderPage(context);

            serviceLocator.navigationService
                .openSalesMansDashboardPage(context, mapdata);
          } else {}

          emit(LoginInitial(
              errorMessage: "Login Success",
              errorcode: responce.statusCode.toString()));
        } else {
          emit(LoginInitial(
              errorMessage: "Login Failed Try Again !",
              errorcode: responce.statusCode.toString()));
          return false;
        }

        break;

      default:
        final responce = await serviceLocator.tradingApi.loginRequest(
            userId: userid, password: password, version: packageInfo.version);

        if (responce.statusCode == 200) {
          updateusercontroller(userId: userid, username: userid);
          Map jsonUser = jsonDecode(responce.body);

          if (jsonUser['success'] == 1) {
            UserController.userController.usertoken = jsonUser['token'];
            print(jsonUser['token']);
            await PreferenceUtils.storeDataToShared(
                "usertoken", jsonUser['token']);
            var profileres =
                await serviceLocator.tradingApi.getProfile(context);

            Map<String, dynamic> profileitems = json.decode(profileres);
            ProfileResponce profileResponce =
                ProfileResponce.fromJson(profileitems);

            await PreferenceUtils.storeDataToShared(
                "profiledetails", jsonEncode(profileResponce));
            UserController.userController.profileResponce = profileResponce;
            // await gettoken(serviceLocator, packageInfo);

            UserController.userController.mainbaseUrl =
                'https://admin-qatar.testuatah.com/';

            // UserController.userController.userstat =
            //     int.parse(profileResponce.user[0].availabilityStatus) == 0
            //         ? false
            //         : true;

            await PreferenceUtils.storeDataToShared("dutyval", "1");

            emit(LoginInitial(
                errorMessage: "Login Success",
                errorcode: responce.statusCode.toString()));
            // serviceLocator.navigationService.openOrderPage(context);

            Map<String, dynamic> data = {"selected": 0};
            if (profileResponce.user[0].role == "5") {
              serviceLocator.navigationService
                  .openNewScannerPage(context, data);
            } else if (profileResponce.user[0].role == "7") {
              serviceLocator.navigationService
                  .openSalesMansDashboardPage(context, data);
            } else if (profileResponce.user[0].role == "6") {
              // serviceLocator.navigationService
              //     .openSectionInchargeHomePage(context, data);
            } else {
              serviceLocator.navigationService.openWorkspacePage(context, data);
            }
          } else {
            showGeneralDialog(
              context: context,
              barrierDismissible: true,
              barrierLabel: "",
              pageBuilder: (context, animation, secondaryanimation) {
                return Container();
              },
              transitionBuilder:
                  (context, animation, secondaryAnimation, child) {
                var curve = Curves.easeInOut.transform(animation.value);

                return Transform.scale(
                  scale: curve,
                  child: AlertDialog(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Lottie.asset('assets/update_error.json', height: 100.0),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Your Account Was Disabled Please Contact With Admin..!",
                                textAlign: TextAlign.center,
                                style: customTextStyle(
                                    fontStyle: FontStyle.BodyL_Bold,
                                    color: FontColor.Danger),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 13.0),
                              decoration: BoxDecoration(
                                  color: customColors().carnationRed,
                                  borderRadius: BorderRadius.circular(5.0)),
                              child: Center(
                                child: Text(
                                  "OK",
                                  style: customTextStyle(
                                      fontStyle: FontStyle.BodyM_Bold,
                                      color: FontColor.White),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          }

          // emit(LoginInitial(
          //     errorMessage: "Login Success",
          //     errorcode: responce.statusCode.toString()));
        }
    }
  }
}
