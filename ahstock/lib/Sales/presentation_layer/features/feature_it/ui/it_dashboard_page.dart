import 'dart:developer';

import 'package:ahstock/Sales/presentation_layer/features/feature_it/bloc/it_dashboard_page_cubit.dart';
import 'package:ahstock/Sales/presentation_layer/features/feature_it/bloc/it_dashboard_page_state.dart';
import 'package:ahstock/Sales/repository_layer/more_content.dart';
import 'package:ahstock/constants/prefefence_utils.dart';
import 'package:ahstock/global_methods/global_colors.dart';
import 'package:ahstock/theme/styles.dart';
import 'package:ahstock/utils/utils.dart';
import 'package:barcode_scan2/barcode_scan2.dart';
import 'package:barcode_scan2/model/scan_result.dart';
import 'package:camera/camera.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stock_api/responses/it_data_response.dart';

class ItDashboardPage extends StatefulWidget {
  const ItDashboardPage({super.key});

  @override
  State<ItDashboardPage> createState() => _ItDashboardPageState();
}

class _ItDashboardPageState extends State<ItDashboardPage>
    with WidgetsBindingObserver {
  String _scanBarcode = 'Unknown';
  late CameraController _cameraController;

  final _formKey = GlobalKey<FormState>();

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
                  const CircularProgressIndicator(
                    color: Colors.cyan,
                  ),
                  // Lottie.asset('assets/loading.json')
                ],
              ),
            ),
          );
        },
      );

      BlocProvider.of<ItDashboardPageCubit>(context).checkBarcode(_scanBarcode);
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
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
      body: BlocBuilder<ItDashboardPageCubit, ItDashboardPageState>(
          builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
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
                            "IT DashBoard",
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
            Expanded(
                child: context.read<ItDashboardPageCubit>().items.isEmpty
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Stack(
                            children: [
                              Center(
                                child: Image.asset(
                                  'assets/barcode_scan.png',
                                  height: 120.0,
                                ),
                              ),
                              Positioned(
                                  child: Center(
                                child: Container(
                                  height: 120,
                                  width: 120,
                                  decoration: BoxDecoration(
                                      color: customColors()
                                          .backgroundPrimary
                                          .withOpacity(0.8)),
                                ),
                              ))
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 20.0),
                            child: Text(
                              "Tap To Scan For Add Barcodes...",
                              style: customTextStyle(
                                  fontStyle: FontStyle.BodyM_Bold,
                                  color: FontColor.FontTertiary),
                            ),
                          )
                        ],
                      )
                    : ListView.builder(
                        itemCount:
                            context.read<ItDashboardPageCubit>().items.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8.0, vertical: 5.0),
                            child: ExpandableNotifier(
                              child: ScrollOnExpand(
                                  child: Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 16.0, horizontal: 3.0),
                                decoration: BoxDecoration(
                                    border:
                                        Border.all(color: customColors().grey),
                                    borderRadius: BorderRadius.circular(5.0)),
                                child: Builder(builder: (context) {
                                  var controller = ExpandableController.of(
                                      context,
                                      required: true);

                                  return InkWell(
                                    onTap: () {
                                      controller!.toggle();
                                    },
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Container(
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                        child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8.0),
                                                      child: Text(context
                                                          .read<
                                                              ItDashboardPageCubit>()
                                                          .items[index]
                                                          .barcodes),
                                                    )),
                                                    Row(
                                                      children: [
                                                        InkWell(
                                                          onTap: () {
                                                            controller!
                                                                .toggle();
                                                          },
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    right: 8.0),
                                                            child: Image.asset(
                                                              'assets/edit.png',
                                                              height: 21.0,
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        ExpandableSection(
                                          index: index,
                                          skulist: context
                                              .read<ItDashboardPageCubit>()
                                              .items,
                                          trigger: () {
                                            controller!.toggle();
                                          },
                                          removetrigger: () {},
                                        ),
                                        Expandable(
                                            collapsed: Container(),
                                            expanded: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 12.0),
                                                  child: Row(
                                                    children: [
                                                      //   Expanded(
                                                      //       child: CustomTextFormFieldReport(
                                                      //           autoFocus:
                                                      //               context.read<NewScanBarcodePageCubit>().skulist[index]
                                                      //                       [
                                                      //                       'title'] ==
                                                      //                   "",
                                                      //           keyboardType:
                                                      //               TextInputType
                                                      //                   .name,
                                                      //           context:
                                                      //               context,
                                                      //           controller:
                                                      //               namecontroller,
                                                      //           fieldName:
                                                      //               'Name'),
                                                      //     ),
                                                      //   ],
                                                      // ),
                                                      // ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ))
                                      ],
                                    ),
                                  );
                                }),
                              )),
                            ),
                          );
                        }))
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
      bottomNavigationBar: InkWell(
        onTap: () {
          List<Map<String, dynamic>> listentry = [];

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
                          "Updating data....!",
                          style: customTextStyle(
                              fontStyle: FontStyle.BodyL_Bold,
                              color: FontColor.FontPrimary),
                        ),
                      ),
                      const CircularProgressIndicator(
                        color: Colors.cyan,
                      ),
                      // Lottie.asset('assets/loading.json')
                    ],
                  ),
                ),
              );
            },
          );

          for (var element in context.read<ItDashboardPageCubit>().items) {
            listentry.add({
              "id": element.id.toString(),
              "package_uom": element.packageUom,
              "uom_weight": element.uomWeight
            });
          }

          BlocProvider.of<ItDashboardPageCubit>(context)
              .updateListData(listentry);
        },
        child: Container(
          height: screenSize.height * 0.065,
          padding: const EdgeInsets.symmetric(vertical: 12.0),
          decoration: BoxDecoration(color: customColors().accent),
          child: Center(
            child: Text(
              "Update Data",
              style: customTextStyle(
                  fontStyle: FontStyle.BodyL_Bold,
                  color: FontColor.FontPrimary),
            ),
          ),
        ),
      ),
    );
  }
}

class ExpandableSection extends StatefulWidget {
  int index;
  List<Item> skulist;
  final VoidCallback trigger;
  final VoidCallback removetrigger;
  // CarouselSliderController sliderController;
  ExpandableSection({
    super.key,
    required this.index,
    required this.skulist,
    required this.trigger,
    required this.removetrigger,
    // required this.sliderController
  });

  @override
  State<ExpandableSection> createState() => _ExpandableSectionState();
}

class _ExpandableSectionState extends State<ExpandableSection> {
  TextEditingController namecontroller1 = TextEditingController();
  TextEditingController pricecontroller1 = TextEditingController();
  TextEditingController qtycontroller1 = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<String> _locations = ['KG', 'GM', 'LTR', 'ML', 'PCS']; // Option 2
  // String _selectedLocation; // Option 2

  @override
  Widget build(BuildContext context) {
    return Expandable(
        collapsed: Container(),
        expanded: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      widget.skulist[widget.index].barcodes != ""
                          ? Expanded(
                              child: Container(
                                child: TextFormField(
                                  // autoFocus: true,
                                  initialValue: widget
                                              .skulist[widget.index]
                                              // ignore: unnecessary_null_comparison
                                              .barcodes !=
                                          null
                                      ? widget.skulist[widget.index].barcodes
                                          .toString()
                                      : "",
                                  keyboardType: TextInputType.name,
                                  // controller: namecontroller1,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: customColors()
                                                .backgroundTertiary,
                                            width: 1),
                                        borderRadius:
                                            BorderRadius.circular(4.0)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: customColors()
                                                .backgroundTertiary,
                                            width: 1),
                                        borderRadius:
                                            BorderRadius.circular(4.0)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: customColors()
                                                .backgroundTertiary,
                                            width: 1),
                                        borderRadius:
                                            BorderRadius.circular(4.0)),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      widget.skulist[widget.index].barcodes =
                                          value;
                                    });
                                  },
                                ),
                              ),
                            )
                          : Expanded(
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 8.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: customColors().grey),
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Text(
                                    "",
                                    style: customTextStyle(
                                        fontStyle: FontStyle.BodyM_Bold,
                                        color: FontColor.FontPrimary),
                                  ))),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 10.0),
                  child: Row(
                    children: [
                      widget.skulist[widget.index].description != ""
                          ? Expanded(
                              child: Container(
                                child: TextFormField(
                                  // autoFocus: true,
                                  initialValue: widget
                                              .skulist[widget.index]
                                              // ignore: unnecessary_null_comparison
                                              .description !=
                                          null
                                      ? widget.skulist[widget.index].description
                                          .toString()
                                      : "",
                                  keyboardType: TextInputType.name,
                                  // controller: namecontroller1,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: customColors()
                                                .backgroundTertiary,
                                            width: 1),
                                        borderRadius:
                                            BorderRadius.circular(4.0)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: customColors()
                                                .backgroundTertiary,
                                            width: 1),
                                        borderRadius:
                                            BorderRadius.circular(4.0)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: customColors()
                                                .backgroundTertiary,
                                            width: 1),
                                        borderRadius:
                                            BorderRadius.circular(4.0)),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      widget.skulist[widget.index].description =
                                          value;
                                    });
                                  },
                                ),
                              ),
                            )
                          : Expanded(
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 8.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: customColors().grey),
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Text(
                                    "",
                                    style: customTextStyle(
                                        fontStyle: FontStyle.BodyM_Bold,
                                        color: FontColor.FontPrimary),
                                  ))),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      widget.skulist[widget.index].uomWeight != ""
                          ? Expanded(
                              child: Container(
                                child: TextFormField(
                                  // autoFocus: true,
                                  initialValue: widget
                                              .skulist[widget.index]
                                              // ignore: unnecessary_null_comparison
                                              .uomWeight !=
                                          null
                                      ? widget.skulist[widget.index].uomWeight
                                          .toString()
                                      : "",
                                  keyboardType: TextInputType.name,
                                  // controller: namecontroller1,
                                  decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: customColors()
                                                .backgroundTertiary,
                                            width: 1),
                                        borderRadius:
                                            BorderRadius.circular(4.0)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: customColors()
                                                .backgroundTertiary,
                                            width: 1),
                                        borderRadius:
                                            BorderRadius.circular(4.0)),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: customColors()
                                                .backgroundTertiary,
                                            width: 1),
                                        borderRadius:
                                            BorderRadius.circular(4.0)),
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 10),
                                  ),
                                  onChanged: (value) {
                                    setState(() {
                                      widget.skulist[widget.index].uomWeight =
                                          int.parse(value ?? "0");
                                    });
                                  },
                                ),
                              ),
                            )
                          : Expanded(
                              child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 8.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: customColors().grey),
                                      borderRadius: BorderRadius.circular(5.0)),
                                  child: Text(
                                    "",
                                    style: customTextStyle(
                                        fontStyle: FontStyle.BodyM_Bold,
                                        color: FontColor.FontPrimary),
                                  ))),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0, vertical: 10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: TextFormField(
                            // autoFocus: true,
                            initialValue: widget
                                        .skulist[widget.index]
                                        // ignore: unnecessary_null_comparison
                                        .uom !=
                                    null
                                ? widget.skulist[widget.index].uom.toString()
                                : "",
                            keyboardType: TextInputType.name,
                            // controller: namecontroller1,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: customColors().backgroundTertiary,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(4.0)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: customColors().backgroundTertiary,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(4.0)),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: customColors().backgroundTertiary,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(4.0)),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 15, horizontal: 10),
                            ),
                            onChanged: (value) {
                              setState(() {
                                widget.skulist[widget.index].uom = value;
                              });
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 3.0, top: 14.0),
                          child: DropdownButton(
                            isExpanded: true,
                            hint: Text(
                                'Please Choose'), // Not necessary for Option 1
                            value: widget.skulist[widget.index].packageUom,
                            onChanged: (newValue) {
                              setState(() {
                                widget.skulist[widget.index].packageUom =
                                    newValue!;
                              });
                            },
                            items: _locations.map((location) {
                              return DropdownMenuItem(
                                child: new Text(location),
                                value: location,
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 15.0,
                ),
              ],
            ),
          ),
        ));
  }
}
