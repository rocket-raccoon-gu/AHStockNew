import 'dart:convert';
import 'dart:developer';

import 'package:ahstock/Sales/presentation_layer/features/feature_sales/bloc/sales_dashboard_page_state.dart';
import 'package:ahstock/global_methods/global_colors.dart';
import 'package:ahstock/services/service_locator.dart';
import 'package:ahstock/theme/styles.dart';
import 'package:ahstock/user_controller/user_controller.dart';
import 'package:ahstock/utils/utils.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SalesDashBoradPageCubit extends Cubit<SalesDashBoardPageState> {
  final ServiceLocator serviceLocator;
  Map<String, dynamic> data;
  BuildContext context;
  SalesDashBoradPageCubit(this.serviceLocator, this.data, this.context)
      : super(SalesDshBoardPageLoadingState()) {
    updateData();
  }

  void updateData() {
    emit(SalesDashBoardPageInitialState());
  }

  checkBarcode(String sku) async {
    if (UserController.userController.userName == "ahuae_sales" ||
        UserController.userController.userName == "ahoman_sales" ||
        UserController.userController.userName == "ahbahrain_sales") {
      // ahuae uae sales

      try {
        String promotionresponse = await serviceLocator.tradingApi
            .generalPromotionServiceRegions(endpoint: sku);

        Navigator.pop(context);
        Map<String, dynamic> data = jsonDecode(promotionresponse);

        if (data['items'].isEmpty) {
          // ignore: use_build_context_synchronously
          showGeneralDialog(
            context: context,
            barrierDismissible: true,
            barrierLabel: "",
            pageBuilder: (context, animation, secondaryAnimation) {
              return Container();
            },
            transitionBuilder: (context, animation, secondaryAnimation, child) {
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.close,
                              size: 25.0,
                            ),
                          )
                        ],
                      ),
                      // Lottie.asset("assets/update_error.json",
                      //     height: 150.0, width: 150.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          sku,
                          textAlign: TextAlign.center,
                          style: customTextStyle(
                              fontStyle: FontStyle.BodyL_Bold,
                              color: FontColor.FontPrimary),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "Oh No, This Item Not In The Promotion",
                          textAlign: TextAlign.center,
                          style: customTextStyle(
                              fontStyle: FontStyle.BodyL_Bold,
                              color: FontColor.FontPrimary),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          String promotionpercentage = data['items'][0]['discount_percentage'];

          // ignore: use_build_context_synchronously
          showGeneralDialog(
            context: context,
            barrierDismissible: true,
            barrierLabel: "",
            pageBuilder: (context, animation, secondaryAnimation) {
              return Container();
            },
            transitionBuilder: (context, animation, secondaryAnimation, child) {
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.close,
                              size: 25.0,
                            ),
                          )
                        ],
                      ),
                      // Lottie.asset("assets/success_animation.json",
                      //     height: 150.0, width: 150.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          sku,
                          textAlign: TextAlign.center,
                          style: customTextStyle(
                              fontStyle: FontStyle.BodyL_Bold,
                              color: FontColor.FontPrimary),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "Yes, This Item In Promotion",
                          textAlign: TextAlign.center,
                          style: customTextStyle(
                              fontStyle: FontStyle.BodyL_Bold,
                              color: FontColor.FontPrimary),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "Retail Price : ${data['items'][0]['retail_price']} ${getcurrencyfromurl(UserController.userController.mainbaseUrl)}",
                          textAlign: TextAlign.center,
                          style: customTextStyle(
                              fontStyle: FontStyle.BodyL_Bold,
                              color: FontColor.FontPrimary),
                        ),
                      ),
                      SizedBox(
                        child: Center(
                          child: AnimatedTextKit(
                            animatedTexts: [
                              ColorizeAnimatedText(
                                  promotionpercentage + "% OFF",
                                  textStyle: colorizeTextStyle,
                                  colors: colorizeColors,
                                  textAlign: TextAlign.center),
                            ],
                            isRepeatingAnimation: true,
                            onTap: () {
                              print("Tap Event");
                            },
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "Discount Price : ${data['items'][0]['discount_price']} ${getcurrencyfromurl(UserController.userController.mainbaseUrl)}",
                          textAlign: TextAlign.center,
                          style: customTextStyle(
                              fontStyle: FontStyle.BodyL_Bold,
                              color: FontColor.FontPrimary),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Final Price : ",
                              textAlign: TextAlign.center,
                              style: customTextStyle(
                                  fontStyle: FontStyle.HeaderS_Bold,
                                  color: FontColor.FontPrimary),
                            ),
                            Text(
                              "${data['items'][0]['final_price']} ${getcurrencyfromurl(UserController.userController.mainbaseUrl)}",
                              style: customTextStyle(
                                  fontStyle: FontStyle.HeaderS_Bold,
                                  color: FontColor.CarnationRed),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      } catch (e) {}
    } else {
      // ahqa qatar sales

      try {
        String promotionresponse = await serviceLocator.tradingApi
            .generalPromotionService(endpoint: sku);

        Navigator.pop(context);
        Map<String, dynamic> data = jsonDecode(promotionresponse);

        log(promotionresponse);

        if (data['items'].isEmpty) {
          // ignore: use_build_context_synchronously
          showGeneralDialog(
            context: context,
            barrierDismissible: true,
            barrierLabel: "",
            pageBuilder: (context, animation, secondaryAnimation) {
              return Container();
            },
            transitionBuilder: (context, animation, secondaryAnimation, child) {
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.close,
                              size: 25.0,
                            ),
                          )
                        ],
                      ),
                      // Lottie.asset("assets/update_error.json",
                      //     height: 150.0, width: 150.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          sku,
                          textAlign: TextAlign.center,
                          style: customTextStyle(
                              fontStyle: FontStyle.BodyL_Bold,
                              color: FontColor.FontPrimary),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "Oh No, This Item Not In The Promotion",
                          textAlign: TextAlign.center,
                          style: customTextStyle(
                              fontStyle: FontStyle.BodyL_Bold,
                              color: FontColor.FontPrimary),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        } else {
          // String promotionpercentage = data['items'][0]['percentage'];

          // ignore: use_build_context_synchronously
          showGeneralDialog(
            context: context,
            barrierDismissible: true,
            barrierLabel: "",
            pageBuilder: (context, animation, secondaryAnimation) {
              return Container();
            },
            transitionBuilder: (context, animation, secondaryAnimation, child) {
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.close,
                              size: 25.0,
                            ),
                          )
                        ],
                      ),
                      // Lottie.asset("assets/success_animation.json",
                      //     height: 150.0, width: 150.0),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Text(
                          sku,
                          textAlign: TextAlign.center,
                          style: customTextStyle(
                              fontStyle: FontStyle.BodyL_Bold,
                              color: FontColor.FontPrimary),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "Retail Price : ${data['items'][0]['retail_price']} ${getcurrencyfromurl(UserController.userController.mainbaseUrl)}",
                          textAlign: TextAlign.center,
                          style: customTextStyle(
                              fontStyle: FontStyle.BodyL_Bold,
                              color: FontColor.FontPrimary),
                        ),
                      ),
                      SizedBox(
                        child: Center(
                            child: getPromotionStatusWithOff(
                                data['items'][0]['promotion_status'])),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          "Discount Price : ${data['items'][0]['discount_amount']} ${getcurrencyfromurl(UserController.userController.mainbaseUrl)}",
                          textAlign: TextAlign.center,
                          style: customTextStyle(
                              fontStyle: FontStyle.BodyL_Bold,
                              color: FontColor.FontPrimary),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Offer Price : ",
                              textAlign: TextAlign.center,
                              style: customTextStyle(
                                  fontStyle: FontStyle.HeaderS_Bold,
                                  color: FontColor.FontPrimary),
                            ),
                            Text(
                              "${data['items'][0]['offer_price']} ${getcurrencyfromurl(UserController.userController.mainbaseUrl)}",
                              style: customTextStyle(
                                  fontStyle: FontStyle.HeaderS_Bold,
                                  color: FontColor.CarnationRed),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        }
      } catch (e) {
        showSnackBar(
            context: context,
            snackBar: showErrorDialogue1(
                errorMessage:
                    "Item Not Scanned Properly Please Try Again...!"));
      }
    }
  }

  checkBarcodeUAE(String sku) async {
    try {
      String promotionresponse = await serviceLocator.tradingApi
          .generalPromotionService(endpoint: sku);
    } catch (e) {}
  }
}

Widget getPromotionStatusWithOff(String promotionStatus) {
  // Check if the promotion status is a number
  final parsedNumber = num.tryParse(promotionStatus);
  if (parsedNumber != null) {
    // If it's a number, format it accordingly
    return AnimatedTextKit(animatedTexts: [
      ColorizeAnimatedText("$promotionStatus% OFF",
          colors: colorizeColors, textStyle: colorizeTextStyle)
    ]);
  } else {
    // If it's not a number, append "OFF" to the status
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Status : ",
          style: customTextStyle(fontStyle: FontStyle.BodyL_Bold),
        ),
        AnimatedTextKit(animatedTexts: [
          ColorizeAnimatedText("$promotionStatus",
              textStyle: colorizeTextStyle, colors: colorizeColors)
        ]),
      ],
    );
  }
}

const colorizeColors = [
  Colors.purple,
  Colors.blue,
  Colors.yellow,
  Colors.red,
];

const colorizeTextStyle = TextStyle(
  fontSize: 20.0,
  fontFamily: 'Horizon',
);
