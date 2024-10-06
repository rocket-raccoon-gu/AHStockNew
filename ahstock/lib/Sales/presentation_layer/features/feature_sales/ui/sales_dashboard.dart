import 'dart:developer';

import 'package:ahstock/Sales/presentation_layer/features/feature_sales/bloc/sales_dashboard_page_cubit.dart';
import 'package:ahstock/Sales/presentation_layer/features/feature_sales/bloc/sales_dashboard_page_state.dart';
import 'package:ahstock/Sales/repository_layer/more_content.dart';
import 'package:ahstock/constants/prefefence_utils.dart';
import 'package:ahstock/global_methods/global_colors.dart';
import 'package:ahstock/theme/styles.dart';
import 'package:ahstock/user_controller/user_controller.dart';
import 'package:ahstock/utils/utils.dart';
import 'package:barcode_scan2/model/scan_result.dart';
import 'package:barcode_scan2/platform_wrapper.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SalesDashboard extends StatefulWidget {
  const SalesDashboard({super.key});

  @override
  State<SalesDashboard> createState() => _SalesDashboardState();
}

class _SalesDashboardState extends State<SalesDashboard>
    with WidgetsBindingObserver {
  String _scanBarcode = 'Unknown';
  late CameraController _cameraController;

  Future<void> scanBarcodeNormal(BuildContext ctx) async {
    String? barcodescanRes;

    ScanResult scanResult;

    final cameras = await availableCameras();
    final firstCamera = cameras.first;
    int cameralist = await BarcodeScanner.numberOfCameras;

    _cameraController = CameraController(firstCamera, ResolutionPreset.medium);

    await _cameraController.initialize();

    try {
      barcodescanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        false,
        ScanMode.BARCODE,
      );

      // // var result = await BarcodeScanner.scan(
      // //     options: ScanOptions(useCamera: cameralist - 2));

      setState(() {
        // barcodescanRes = result.rawContent;f
        _scanBarcode = barcodescanRes!;
      });

      log(_scanBarcode);
    } on PlatformException {
      barcodescanRes = 'Failed to read barcode';
    }

    if (barcodescanRes == "" || barcodescanRes == "-1") {
      showSnackBar(
          context: context,
          snackBar: showErrorDialogue1(
              errorMessage: "Item Not Scanned Properly Retry...!"));
      return;
    }

    try {
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
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0, bottom: 25.0),
                    child: Text(
                      "Fetching data....!",
                      style: customTextStyle(
                          fontStyle: FontStyle.BodyL_Bold,
                          color: FontColor.FontPrimary),
                    ),
                  ),
                  const CircularProgressIndicator.adaptive(),
                  // Lottie.asset('assets/loading.json')
                ],
              ),
            ),
          );
        },
      );

      BlocProvider.of<SalesDashBoradPageCubit>(context)
          .checkBarcode(_scanBarcode);
    } catch (e) {
      // ignore: use_build_context_synchronously
      showSnackBar(
          context: context,
          snackBar: showErrorDialogue1(
              errorMessage: "Item Not Scanned Properly Retry...!"));
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double mheight = MediaQuery.of(context).size.height * 1.222;
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0.0),
        child: AppBar(
          elevation: 0,
          backgroundColor: customColors().backgroundPrimary,
        ),
      ),
      body: BlocBuilder<SalesDashBoradPageCubit, SalesDashBoardPageState>(
          builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // UserController.userController.profileResponce.user[0].role == "7"
            //     ?
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: HexColor('#b9d737'),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: mheight * .012,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              Scaffold.of(context).openDrawer();
                            },
                            icon: const Icon(Icons.menu)),
                        Padding(
                          padding: const EdgeInsets.only(left: 6.0),
                          child: Text(
                            "Sales DashBoard",
                            style: customTextStyle(
                                fontStyle: FontStyle.BodyL_Bold,
                                color: FontColor.FontSecondary),
                          ),
                        )
                      ],
                    ),
                    // Text(AppLocalizations.of(context).helloWorld),
                    Row(
                      children: [
                        // Clock(),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 7.0),
                          child: InkWell(
                            onTap: () async {
                              // BlocProvider.of<NewScanBarcodePageCubit>(
                              //         context)
                              //     .updatelogoutstat(0);

                              // context.gNavigationService
                              //     .openWorkspacePage(context, data);
                              await PreferenceUtils.removeDataFromShared(
                                  "userCode");
                              await PreferenceUtils.removeDataFromShared(
                                  "profiledetails");
                              await PreferenceUtils.clear();
                              // ignore: use_build_context_synchronously
                              await logout(context);
                            },
                            child: Image.asset(
                              'assets/logout.png',
                              height: 25,
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // : Container(),
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8.0, vertical: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            "Logged in User : ${UserController.userController.userName}"),
                        const Text("ahqa_sales")
                      ],
                    ),
                  ),
                  const Divider(
                    thickness: 1.2,
                  )
                  // GridView.builder(
                  //     shrinkWrap: true,
                  //     itemCount: 1,
                  //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  //         crossAxisCount: 2),
                  //     itemBuilder: (context, index) {
                  //       return Padding(
                  //         padding: const EdgeInsets.symmetric(
                  //             horizontal: 12.0, vertical: 12.0),
                  //         child: InkWell(
                  //           onTap: () {},
                  //           child: Container(
                  //             decoration: BoxDecoration(
                  //                 border: Border.all(
                  //                     color: customColors().fontTertiary),
                  //                 borderRadius: BorderRadius.circular(5.0)),
                  //             child: Column(
                  //               mainAxisAlignment: MainAxisAlignment.end,
                  //               children: [
                  //                 Image.asset(
                  //                   "assets/checklist.png",
                  //                   height: 80,
                  //                 ),
                  //                 Padding(
                  //                   padding: const EdgeInsets.symmetric(
                  //                       vertical: 16.0),
                  //                   child: Text(
                  //                     "Check Goods",
                  //                     style: customTextStyle(
                  //                         fontStyle: FontStyle.BodyM_Bold),
                  //                   ),
                  //                 )
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       );
                  //     })
                ],
              ),
            )
          ],
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: customColors().backgroundTertiary,
        elevation: 10.0,
        onPressed: () {
          scanBarcodeNormal(context);
        },
        child: Image.asset(
          'assets/barcode_scan.png',
          height: 25.0,
        ),
      ),
      bottomNavigationBar: Container(
        height: screenSize.height * 0.025,
        padding: const EdgeInsets.symmetric(vertical: 10.0),
      ),
    );
  }
}

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  String _currentTime = '';

  @override
  void initState() {
    super.initState();
    _updateTime();
  }

  void _updateTime() {
    setState(() {
      _currentTime = DateFormat('HH:mm:ss').format(DateTime.now());
    });
    Future.delayed(const Duration(seconds: 1), _updateTime);
  }

  @override
  Widget build(BuildContext context) {
    return Text(_currentTime,
        style: customTextStyle(
          fontStyle: FontStyle.BodyL_Bold,
          color: FontColor.Danger,
        ));
  }
}
