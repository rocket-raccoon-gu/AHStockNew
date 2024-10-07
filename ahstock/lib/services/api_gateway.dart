import 'dart:async';

import 'package:ahstock/constants/prefefence_utils.dart';
import 'package:ahstock/services/authentication_service.dart';
import 'package:ahstock/utils/network/network_service_status.dart';
import 'package:ahstock/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:stock_api/stock_api.dart';
import 'package:stock_api/utils/utils.dart';

class StockApiGateway implements AuthenticationService {
  final StockApi tradingApi;
  final StreamController<String> networkStreamController;
  StockApiGateway(this.tradingApi, this.networkStreamController) {
    NetworkStatusService.networkStatusController.stream
        .listen((NetworkStatus status) {
      if (status == NetworkStatus.Online) {
        tradingApi.networkOnline = true;
      } else if (status == NetworkStatus.Offline) {
        tradingApi.networkOnline = false;
      }
    });
  }

  // @override
  // Future<String> generalService({required String endpoint}) async {
  //   return await tradingApi.generalService(endpoint: endpoint).catchError((e) {
  //     networkStreamController.sink.add(e.toString());
  //     throw e;
  //   });
  // }

  // @override
  // Future<String> categoryservice() async {
  //   String? token11 = nonexpiry_token;
  //   String response =
  //       await tradingApi.categorylistservice(token: token11).catchError((e) {
  //     networkStreamController.sink.add(e.toString());
  //     throw e;
  //   });
  //   return response;
  // }

  // @override
  // Future updateitemaddstatus(
  //     {required String sku,
  //     required String order_id,
  //     required int picker_id,
  //     required int qty,
  //     required String tokn}) async {
  //   try {
  //     final response = await tradingApi
  //         .updateItemAddStatus(
  //             sku: sku,
  //             picker_id: picker_id,
  //             order_id: order_id,
  //             qty: qty,
  //             tokn: tokn)
  //         .catchError((e) {
  //       networkStreamController.sink.add(e.toString());
  //       throw e;
  //     }).timeout(Duration(seconds: 10));
  //     return response;
  //   } catch (e) {
  //     serviceSendError("Item Add Api Error");

  //     return "Retry";
  //   }
  // }

  // @override
  // Future updatereplacementstatus(
  //     {required String cancel_sku,
  //     required String replace_sku,
  //     required int qty,
  //     required int picker_id,
  //     required String order_id,
  //     required int shipping,
  //     required String tokn,
  //     required String reason}) async {
  //   try {
  //     final response = await tradingApi
  //         .updatereplacementstatus(
  //             re_sku: replace_sku,
  //             can_sku: cancel_sku,
  //             qty: qty,
  //             order_id: order_id,
  //             picker_id: picker_id,
  //             shipping: shipping,
  //             tokn: tokn,
  //             reason: reason)
  //         .catchError((e, trace) {
  //       networkStreamController.sink.add(e.toString());
  //       throw e;
  //     }).timeout(Duration(seconds: 10));
  //     return response;
  //   } catch (e) {
  //     serviceSendError("Replacement Api Error...!");

  //     return "Retry";
  //   }
  // }

  // @override
  // Future updateItemStatus(
  //     {required ItemStatusChangeRequest itemStatusChangeRequest,
  //     required String tokn}) async {
  //   final response = await tradingApi
  //       .updateItemStatus(
  //           itemStatusChangeRequest: itemStatusChangeRequest, tokn: tokn)
  //       .catchError((e, trace) {
  //     networkStreamController.sink.add(e.toString());
  //     throw e;
  //   });
  //   return response;
  // }

  // @override
  // Future<String> updateMainOrderStat(
  //     {required String orderid,
  //     required String orderstatus,
  //     required String comment,
  //     required String userid}) async {
  //   try {
  //     final response = await tradingApi
  //         .updatemainorderstat(
  //             orderid: orderid,
  //             order_status: orderstatus,
  //             comment: comment,
  //             user_id: userid)
  //         .catchError((e, trace) {
  //       networkStreamController.sink.add(e.toString());
  //       throw e;
  //     }).timeout(Duration(seconds: 10));
  //     return response;
  //   } catch (e) {
  //     serviceSendError("Status Update Failed");

  //     return "Retry";
  //   }
  // }

  // @override
  // Future updatedocuments(
  //     {required Uint8List imagebytes,
  //     required Uint8List imagebytesdSign,
  //     required Uint8List imagebytesqId,
  //     required String orderid,
  //     required int driverid}) async {
  //   final response = await tradingApi
  //       .uploadDocumentService(
  //           imagebytes, imagebytesdSign, imagebytesqId, orderid, driverid)
  //       .catchError((e, trace) {
  //     networkStreamController.sink.add(e.toString());
  //     throw e;
  //   });
  //   return response;
  // }

  @override
  Future loginRequest(
      {required String userId,
      required String password,
      required String version}) async {
    final response = await tradingApi
        .loginService(password: password, userId: userId, version: version)
        .catchError((e, trace) {
      // fatalError(e.toString(), trace);
      networkStreamController.sink.add(e.toString());
      throw e;
    });
    return response;
  }

  @override
  Future loginOtherREgion(
      {required String userId, required String password}) async {
    final response = await tradingApi
        .loginServiceOtherRgion(userId: userId, password: password, version: "")
        .catchError((e, trace) {
      // fatalError(e.toString(), trace);

      networkStreamController.sink.add(e.toString());
      throw e;
    });

    return response;
  }

  // @override
  // Future<String> orderRequest({
  //   required int pagesize,
  //   required int currentpage,
  //   required String token,
  //   required String status,
  // }) async {
  //   String? token11 = await PreferenceUtils.getDataFromShared("usertoken");

  //   print(token11);

  //   try {
  //     print("pagesize " + pagesize.toString());
  //     print("current page " + UserController().mainbaseUrl);
  //     final response = await tradingApi
  //         .orderService(
  //             pagesize: pagesize,
  //             currentpage: currentpage,
  //             token: token11,
  //             role: UserController().profileResponce.user[0].role,
  //             userid: UserController().profileResponce.user[0].empId,
  //             status: status)
  //         .catchError((e, trace) {
  //       networkStreamController.sink.add(e.toString());
  //       throw e;
  //     });
  //     // OrderResponse orderResponse =
  //     //     OrderResponse.fromJson(jsonDecode(response));
  //     return response;
  //   } catch (e) {
  //     // showSnackBar(context: context, snackBar: snackBar)
  //     return "";
  //   }

  //   // return response;
  // }

  // @override
  // Future<String> orderRegionRequest(
  //     {required int pagesize,
  //     required int currentpage,
  //     required String token}) async {
  //   String? token11 = await PreferenceUtils.getDataFromShared("usertoken");

  //   print(token11);

  //   try {
  //     print("pagesize " + pagesize.toString());
  //     print("current page " + currentpage.toString());
  //     final response = await tradingApi
  //         .orderRegionService(
  //             pagesize: pagesize,
  //             currentpage: currentpage,
  //             token: token11,
  //             role: UserController().profileResponce.user[0].role,
  //             userid: UserController().profileResponce.user[0].id)
  //         .catchError((e, trace) {
  //       networkStreamController.sink.add(e.toString());
  //       throw e;
  //     });
  //     // OrderResponse orderResponse =
  //     //     OrderResponse.fromJson(jsonDecode(response));
  //     return response;
  //   } catch (e) {
  //     // showSnackBar(context: context, snackBar: snackBar)
  //     return "";
  //   }

  //   // return response;
  // }

  // @override
  // Future<String> orderIdDetailsRequest({
  //   required String orderid,
  // }) async {
  //   String? token11 = await PreferenceUtils.getDataFromShared("usertoken");

  //   print(token11);

  //   try {
  //     final response = await tradingApi
  //         .getidwiseOrderDetails(orderid: orderid, token1: token11!)
  //         .catchError((e, trace) {
  //       networkStreamController.sink.add(e.toString());
  //       throw e;
  //     }).timeout(Duration(seconds: 10));
  //     // OrderResponse orderResponse =
  //     //     OrderResponse.fromJson(jsonDecode(response));
  //     return response;
  //   } catch (e) {
  //     // showSnackBar(context: context, snackBar: snackBar)
  //     serviceSendError("Service Send Error...!");
  //     return "Retry";
  //   }

  //   // return response;
  // }

  // @override
  // Future<String> searchOrdersReport({
  //   required String status,
  //   required String datestart,
  //   required String dateend,
  // }) async {
  //   String? token11 = nonexpiry_token;
  //   print(datestart);
  //   print(dateend);
  //   try {
  //     final response = await tradingApi
  //         .getOrderDateRange(
  //             fromdate: datestart,
  //             todate: dateend,
  //             status: status,
  //             token1: token11)
  //         .catchError((e, trace) {
  //       networkStreamController.sink.add(e.toString());
  //       throw e;
  //     });
  //     return response;
  //   } catch (e) {
  //     return "";
  //   }
  // }

  // @override
  // Future<String> manageOrderRequest(
  //     {required int pagesize,
  //     required int currentpage,
  //     required String token}) async {
  //   String? token11 = await PreferenceUtils.getDataFromShared("usertoken");
  //   // try {
  //   //   print("pagesize " + pagesize.toString());
  //   //   print("current page " + currentpage.toString());
  //   //   final response = await tradingApi
  //   //       .manageOrderRequest(
  //   //           pagesize: pagesize,
  //   //           currentpage: currentpage,
  //   //           token: token11,
  //   //           role: UserController().profileResponce.body.rolename,
  //   //           userid: UserController().profileResponce.body.userId)
  //   //       .catchError((e, trace) {
  //   //     networkStreamController.sink.add(e.toString());
  //   //     throw e;
  //   //   });
  //   //   // OrderResponse orderResponse =
  //   //   //     OrderResponse.fromJson(jsonDecode(response));
  //   //   return response;
  //   // } catch (e) {
  //   // showSnackBar(context: context, snackBar: snackBar)
  //   return "";
  //   // }
  // }

  // @override
  // Future<String> reAssignmanageOrderRequest(
  //     {required int pagesize,
  //     required int currentpage,
  //     required String token}) async {
  //   String? token11 = await PreferenceUtils.getDataFromShared("usertoken");
  //   // try {
  //   print("pagesize " + pagesize.toString());
  //   print("current page " + currentpage.toString());
  //   //   final response = await tradingApi.ReAssignRequest(
  //   //           pagesize: pagesize,
  //   //           currentpage: currentpage,
  //   //           token: token11,
  //   //           role: UserController().profileResponce.body.rolename,
  //   //           userid: UserController().profileResponce.body.userId)
  //   //       .catchError((e, trace) {
  //   //     networkStreamController.sink.add(e.toString());
  //   //     throw e;
  //   //   });
  //   //   // OrderResponse orderResponse =
  //   //   //     OrderResponse.fromJson(jsonDecode(response));
  //   //   return response;
  //   // } catch (e) {
  //   // showSnackBar(context: context, snackBar: snackBar)
  //   return "";
  //   // }
  // }

  // @override
  // Future<String> getOrderById({required String incrementid}) async {
  //   String? token11 = await PreferenceUtils.getDataFromShared("usertoken");
  //   try {
  //     final response = await tradingApi
  //         .orderServiceIncrementid(incrementid, token11!)
  //         .catchError((e, trace) {
  //       networkStreamController.sink.add(e.toString());
  //       throw e;
  //     });
  //     return response;
  //   } catch (e) {
  //     return "";
  //   }
  // }

  @override
  Future<String> generalSPService({required String endpoint}) async {
    String? token11 = await PreferenceUtils.getDataFromShared("usertoken");
    return await tradingApi
        .generalService(endpoint: endpoint, token: token11!)
        .catchError((e) {
      networkStreamController.sink.add(e.toString());
      throw e;
    });
  }

  // @override
  // Future<String> generalPickerService({required String endpoint}) async {
  //   String token =
  //       await PreferenceUtils.getDataFromShared("usertoken").toString();
  //   return await tradingApi.pickerService().catchError((e) {
  //     networkStreamController.sink.add(e.toString());
  //     throw e;
  //   });
  // }

  // @override
  // Future pickerAssignservicepost(
  //     {required PickerAssignRequest pickerAssignRequest}) async {
  //   String? token11 = await PreferenceUtils.getDataFromShared("usertoken");
  //   return await tradingApi
  //       .pickerAssignService(
  //           pickerAssignRequest: pickerAssignRequest, token1: token11!)
  //       .catchError((e) {
  //     networkStreamController.sink.add(e.toString());
  //     throw e;
  //   });
  // }

  // @override
  // Future orderstatuschangeServicePost(
  //     {required String endpoint, required int entity_id}) async {
  //   String? token11 = await PreferenceUtils.getDataFromShared("usertoken");
  //   return await tradingApi
  //       .orderstatusServicePost(
  //           endpoint: endpoint, token: token11!, entity_id: entity_id)
  //       .catchError((e) {
  //     networkStreamController.sink.add(e.toString());
  //     throw e;
  //   });
  // }

  // @override
  // Future generalProductServiceGet({required String endpoint}) async {
  //   String? token11 = await PreferenceUtils.getDataFromShared("usertoken");
  //   try {
  //     final responce = await tradingApi
  //         .generalProductService(endpoint: endpoint, token: token11!)
  //         .catchError((e) {
  //       // networkStreamController.sink.add(e.toString());
  //       // throw e;
  //     });
  //     return responce;
  //   } catch (e) {
  //     serviceSendError("customer request Failed");
  //     return "";
  //   }
  //   // return await tradingApi
  //   //     .generalProductService(
  //   //         endpoint: endpoint, token: UserController().usertoken)
  //   //     .catchError((e) {
  //   //   networkStreamController.sink.add(e.toString());
  //   //   throw e;
  //   // });
  // }

  @override
  Future generalPromotionService({required String endpoint}) async {
    String? token11 = await PreferenceUtils.getDataFromShared("usertoken");
    try {
      final response = await tradingApi
          .checkPromotionService(endpoint: endpoint)
          .catchError((e) {
        networkStreamController.sink.add(e.toString());
        throw e;
      });

      return response;
    } catch (e) {
      serviceSendError("general PromotionService Error");
      return "";
    }
  }

  // @override
  Future generalPromotionServiceRegions({required String endpoint}) async {
    try {
      final response = await tradingApi
          .checkPromotionServiceRegions(endpoint: endpoint)
          .catchError((e) {
        networkStreamController.sink.add(e.toString());
        throw e;
      });

      return response;
    } catch (e) {
      serviceSendError("general PromotionService UAE Error");
      return "";
    }
  }

  // @override
  Future itDashboardService({required String endpoint}) async {
    try {
      final response = await tradingApi
          .checkItDataService(endpoint: endpoint)
          .catchError((e) {
        networkStreamController.sink.add(e.toString());
        throw e;
      });

      return response;
    } catch (e) {
      serviceSendError("general It Dashboard Service");
      return "";
    }
  }

  Future itDashboardEntryService(
      {required List<Map<String, dynamic>> data}) async {
    try {
      final response =
          await tradingApi.updateDashboardEntry(data: data).catchError((e) {
        networkStreamController.sink.add(e.toString());
        throw e;
      });

      return response;
    } catch (e) {
      serviceSendError("general It Dashboard Service");
      return "";
    }
  }

  // @override
  // Future generalOrderService({required String endpoint}) async {
  //   String? token11 = await PreferenceUtils.getDataFromShared("usertoken");
  //   return await tradingApi
  //       .generalOrderService(endpoint: endpoint, token1: token11!)
  //       .catchError((e) {
  //     networkStreamController.sink.add(e.toString());
  //     throw e;
  //   });
  // }

  // Future getorderreport(
  //     {required String userid,
  //     required String startdate,
  //     required String enddate}) async {
  //   String? token11 = await PreferenceUtils.getDataFromShared("usertoken");

  //   final responce = await tradingApi
  //       .orderReportService(
  //           userid,
  //           UserController().profileResponce.user[0].role,
  //           token11!,
  //           startdate,
  //           enddate)
  //       .catchError((e) {
  //     networkStreamController.sink.add(e.toString());
  //     throw e;
  //   });

  //   return responce;
  //   // return "";
  // }

  // Future getAllOrderReport() async {
  //   return await tradingApi.allOrderReportService().catchError((e) {
  //     networkStreamController.sink.add(e.toString());
  //     throw e;
  //   });
  // }

  // Future uploadBillRequest(File billfile, String ordernumber) async {
  //   try {
  //     final response = await tradingApi
  //         .uploadBillService(billfile, ordernumber)
  //         .catchError((e) {
  //       networkStreamController.sink.add(e.toString());
  //       throw e;
  //     });

  //     return response;
  //   } catch (e) {
  //     serviceSendError("Upload Bill Api Error");

  //     return "Retry";
  //   }
  // }

  // Future generalOrderStatusService() async {
  //   return await tradingApi.orderStatusService().catchError((e) {
  //     networkStreamController.sink.add(e.toString());
  //     throw e;
  //   });
  // }

  // Future<String> commonOrder({required String endpoint}) async {
  //   String? token11 = await PreferenceUtils.getDataFromShared("usertoken");
  //   return await tradingApi
  //       .commonOrderService(endpoint: endpoint, token1: token11!)
  //       .catchError((e) {
  //     networkStreamController.sink.add(e.toString());
  //     throw e;
  //   });
  // }

  // Future<String> conformcommonOrder({required String endpoint}) async {
  //   String? token11 = "2dhdhimvhb2eg5pczxquwhmh1e1v9x70";
  //   return await tradingApi
  //       .conformcommonOrderService(endpoint: endpoint, token1: token11)
  //       .catchError((e) {
  //     networkStreamController.sink.add(e.toString());
  //     throw e;
  //   });
  // }

  // @override
  // Future customerRequest() async {
  //   String? token11 = await PreferenceUtils.getDataFromShared("usertoken");
  //   try {
  //     serviceSend("customer request");
  //     final response = await tradingApi
  //         .commonCustomerService(
  //             "search?searchCriteria[sortOrders][0][field]=telephone&searchCriteria[sortOrders][0][direction]=asc",
  //             token11!)
  //         .catchError((e, trace) {
  //       networkStreamController.sink.add(e.toString());
  //       throw e;
  //     });
  //     return response;
  //   } catch (e) {
  //     serviceSendError("customer request Failed");
  //     return "";
  //   }
  // }

  // @override
  // Future getApproximateLocation(
  //     {required String buildingnumber,
  //     required String streetnumber,
  //     required String zone}) async {
  //   try {
  //     serviceSend("location request");
  //     final response = await tradingApi
  //         .getApproximateLocation(
  //             buildingnumber: buildingnumber,
  //             streetnumber: streetnumber,
  //             zone: zone)
  //         .catchError((e, trace) {
  //       networkStreamController.sink.add(e.toString());
  //       throw e;
  //     });
  //     return response;
  //   } catch (e) {
  //     serviceSendError("location request Failed");
  //     return "";
  //   }
  // }

  // @override
  // Future checkupdates({required String appversion}) async {
  //   try {
  //     serviceSend("updation check");
  //     final response = await tradingApi
  //         .checkappversion(appversion: appversion)
  //         .catchError((e, trace) {
  //       networkStreamController.sink.add(e.toString());
  //       throw e;
  //     });
  //     return response;
  //   } catch (e) {
  //     serviceSendError("updation check failed");
  //     return "";
  //   }
  // }

  // @override
  // Future getDestinationDirection(
  //     {required String origin,
  //     required String destination,
  //     required String apikey}) async {
  //   try {
  //     serviceSend("direction request");
  //     final response = await tradingApi
  //         .getdirectiontodestination(
  //             origin: origin, destination: destination, apikey: apikey)
  //         .catchError((e, trace) {
  //       networkStreamController.sink.add(e.toString());
  //       throw e;
  //     });
  //     return response;
  //   } catch (e) {
  //     serviceSendError("direction request Failed");
  //     return "";
  //   }
  // }

  // @override
  // Future addMoreQuantityRequest(
  //     {required QuantityUpdateRequest quantityUpdateRequest}) async {
  //   try {
  //     String? token11 = await PreferenceUtils.getDataFromShared("usertoken");

  //     serviceSend("Add More Quantity");

  //     final response = await tradingApi
  //         .updatequantity(quantityUpdateRequest: quantityUpdateRequest)
  //         .catchError((e, trace) {
  //       networkStreamController.sink.add(e.toString());
  //       throw e;
  //     });

  //     return response;
  //   } catch (e) {
  //     serviceSendError("Add More Quantity");
  //     return e;
  //   }
  // }

  // @override
  // Future addCommentRequest(
  //     {required int entityid,
  //     required String comment,
  //     required int parentid,
  //     required int customer_notified,
  //     required int visible_infront,
  //     required String status}) async {
  //   String? token11 = await PreferenceUtils.getDataFromShared("usertoken");
  //   try {
  //     serviceSend("AddComment service");
  //     final response = await tradingApi
  //         .addnewCommentService(
  //             token1: token11!,
  //             endpoint: "${entityid.toString()}/comments",
  //             comment: comment,
  //             parentid: parentid,
  //             customer_notified: customer_notified,
  //             visible_in_front: visible_infront,
  //             status: status)
  //         .catchError((e, trace) {
  //       networkStreamController.sink.add(e.toString());
  //       throw e;
  //     });

  //     return response;
  //   } catch (e) {
  //     serviceSendError("Add Comment");
  //     return e;
  //   }
  // }

  // @override
  // Future sendNotificationRequest({
  //   required String devicetoken,
  //   required String messageid,
  //   required String title,
  //   required String body,
  //   required int id,
  // }) async {
  //   try {
  //     serviceSend("Send Notication Request");

  //     final response = await tradingApi
  //         .sendNotification(
  //             devtoken: devicetoken,
  //             messageid: messageid,
  //             title: title,
  //             body: body,
  //             id: id)
  //         .catchError((e, trace) {
  //       networkStreamController.sink.add(e.toString());
  //       throw e;
  //     });
  //     return response;
  //   } catch (e) {
  //     serviceSendError("push notification error");
  //     return e;
  //   }
  // }

  // @override
  // Future modifyItemRequest(
  //     {required String userid,
  //     required String orderid,
  //     required String incrementid,
  //     required List<String> olditemsku,
  //     required List<String> newitemsku}) async {
  //   try {
  //     serviceSend("Modify Request service");
  //     final response = await tradingApi
  //         .modifyitemrequestService(
  //             userid: userid,
  //             orderid: orderid,
  //             incrementid: incrementid,
  //             olditemsku: olditemsku,
  //             newitemsku: newitemsku)
  //         .catchError((e, trace) {
  //       networkStreamController.sink.add(e.toString());
  //       throw e;
  //     });
  //     return response;
  //   } catch (e) {
  //     serviceSendError("Modify Request");
  //     rethrow;
  //   }
  // }

  @override
  Future getProfile(BuildContext context) async {
    String? token11 = await PreferenceUtils.getDataFromShared("usertoken");
    try {
      serviceSend("Profile service");
      final response =
          await tradingApi.profileService(token11!).catchError((e, trace) {
        networkStreamController.sink.add(e.toString());
        throw e;
      });
      return response;
    } catch (e) {
      serviceSendError("Buying power");
      showSnackBar(
          context: context,
          snackBar: showErrorDialogue1(
              errorMessage:
                  "Server not reachable restart your Application...!"));
      return e;
    }
  }

  // @override
  // Future editorderService(
  //     {required OrderItemEditRequest itemEditRequest}) async {
  //   String? token11 = nonexpiry_token;
  //   try {
  //     serviceSend("Order Edit Service");
  //     final response = await tradingApi
  //         .ordereditservice(token: token11, itemEditRequest: itemEditRequest)
  //         .catchError((e, trace) {
  //       networkStreamController.sink.add(e.toString());
  //       throw e;
  //     });
  //     return response;
  //   } catch (e) {
  //     serviceSendError("order edit Service Failed");
  //     rethrow;
  //   }
  // }

  // @override
  // Future ItemReplacementService(
  //     {required ItemReplacementRequest itemEditRequest}) async {
  //   String? token11 = "2dhdhimvhb2eg5pczxquwhmh1e1v9x70";
  //   try {
  //     serviceSend("Order Edit Service");
  //     final response = await tradingApi.ItemReplacementService(
  //             token: token11, itemEditRequest: itemEditRequest)
  //         .catchError((e, trace) {
  //       networkStreamController.sink.add(e.toString());
  //       throw e;
  //     });
  //     return response;
  //   } catch (e) {
  //     serviceSendError("order edit Service Failed");
  //     rethrow;
  //   }
  // }

  // @override
  // Future discountchecking({required String ruleid}) async {
  //   String? token11 = "2dhdhimvhb2eg5pczxquwhmh1e1v9x70";

  //   try {
  //     serviceSend("Discount check Service");

  //     final response = await tradingApi
  //         .discountcheck(token11: token11, ruleid: ruleid)
  //         .catchError((e, trace) {
  //       networkStreamController.sink.add(e.toString());
  //       throw e;
  //     });
  //     return response;
  //   } catch (e) {
  //     serviceSendError("Discount Check Failed");
  //     rethrow;
  //   }
  // }

  // @override
  // Future getcreditmemoService({
  //   required String entityid,
  //   required CreditMemoRefundRequest creditMemoRefundRequest,
  // }) async {
  //   String? token11 = await PreferenceUtils.getDataFromShared("usertoken");
  //   try {
  //     serviceSend("Credit Service");
  //     final response = await tradingApi
  //         .creditmemoservice(
  //             userId: token11!,
  //             entityid: entityid,
  //             creditMemoRefundRequest: creditMemoRefundRequest)
  //         .catchError((e, trace) {
  //       networkStreamController.sink.add(e.toString());
  //       throw e;
  //     });
  //     return response;
  //   } catch (e) {
  //     serviceSendError("Credit Service");
  //     rethrow;
  //   }
  // }

  // @override
  // Future getshipmentservice({
  //   required String entityid,
  //   required ItemShipRequest itemShipRequest,
  // }) async {
  //   serviceSend("generate shipment");
  //   String? token11 = await PreferenceUtils.getDataFromShared("usertoken");

  //   try {
  //     final response = await tradingApi
  //         .shipmentservice(
  //             token1: token11!,
  //             entityid: entityid,
  //             itemShipRequest: itemShipRequest)
  //         .catchError((e, trace) {
  //       networkStreamController.sink.add(e.toString());
  //       throw e;
  //     });
  //     return response;
  //   } catch (e) {
  //     serviceSendError("generate shipment");
  //     rethrow;
  //   }
  // }

  // Future getInvoiceRequest({required String entityid}) async {
  //   try {
  //     serviceSend("generating invoice");

  //     String? token11 = await PreferenceUtils.getDataFromShared("usertoken");

  //     final response = await tradingApi
  //         .generateInvoice(entityid: entityid, token1: token11)
  //         .catchError((e, trace) {
  //       networkStreamController.sink.add(e.toString());
  //       throw e;
  //     });
  //     return response;
  //   } catch (e) {
  //     serviceSend("generate invoice");
  //     rethrow;
  //   }
  // }

  // Future getItemInvoiceRequest(
  //     {required String entityid,
  //     required ItemInvoiceRequest invoiceRequest}) async {
  //   try {
  //     serviceSend("generating invoice");

  //     String? token11 = await PreferenceUtils.getDataFromShared("usertoken");

  //     final response = await tradingApi
  //         .generateItemInvoice(
  //             entityid: entityid,
  //             token1: token11,
  //             invoiceRequest: invoiceRequest)
  //         .catchError((e, trace) {
  //       networkStreamController.sink.add(e.toString());
  //       throw e;
  //     });
  //     return response;
  //   } catch (e) {
  //     serviceSend("generate invoice");
  //     rethrow;
  //   }
  // }

  // Future saveDeviceInfoRequest(
  //     {required String devicetoken, required Map<String, dynamic> data}) async {
  //   String? token11 = await PreferenceUtils.getDataFromShared("usertoken");
  //   try {
  //     final responce = await tradingApi
  //         .saveuserDeviceinfo(
  //             devicetoken: devicetoken,
  //             userId: UserController().profileResponce.user[0].id,
  //             token1: token11!,
  //             data: data)
  //         .catchError((e, trace) {
  //       networkStreamController.sink.add(e.toString());
  //       throw e;
  //     });
  //     return responce;
  //   } catch (e) {
  //     serviceSendError("device info");
  //     rethrow;
  //   }
  // }

  // Future changeorderStat({
  //   required String entityid,
  //   required String status,
  // }) async {
  //   String? token11 = await PreferenceUtils.getDataFromShared("usertoken");
  //   try {
  //     serviceSend('change orderstat');
  //     final response = await tradingApi
  //         .changeorderstat(entityid: entityid, status: status, token: token11!)
  //         .catchError((e, trace) {
  //       networkStreamController.sink.add(e.toString());
  //       throw e;
  //     });

  //     return response;
  //   } catch (e) {
  //     serviceSendError("order stat");
  //     rethrow;
  //   }
  // }

  // @override
  // Future addMissingRequest(
  //     {required String orderid,
  //     required String pickerid,
  //     required String missing_sku,
  //     required String missing_price,
  //     required String missing_qty,
  //     required String reason}) async {
  //   try {
  //     final response = await tradingApi
  //         .addMissingItem(
  //             orderid: orderid,
  //             pickerid: pickerid,
  //             missingsku: missing_sku,
  //             missingprice: missing_price,
  //             missingqty: missing_qty,
  //             reason: reason)
  //         .catchError((e) {
  //       networkStreamController.sink.add(e.toString());
  //       throw e;
  //     });
  //     return response;
  //   } catch (e) {
  //     rethrow;
  //   }
  // }

  // Future addReplacementItemRequest(
  //     {required String orderid,
  //     required String pickerid,
  //     required String missingsku,
  //     required String missingprice,
  //     required String missingqty,
  //     required String replacedsku,
  //     required String replacedprice,
  //     required String replacedqty,
  //     required String reason}) async {
  //   try {
  //     final response = await tradingApi
  //         .addReplaceItem(
  //             orderid: orderid,
  //             pickerid: pickerid,
  //             missingsku: missingsku,
  //             missingprice: missingprice,
  //             missingqty: missingqty,
  //             replacedsku: replacedsku,
  //             replacedprice: replacedprice,
  //             replacedqty: replacedqty,
  //             reason: reason)
  //         .catchError((e) {
  //       networkStreamController.sink.add(e.toString());
  //       throw e;
  //     });

  //     return response;
  //   } catch (e) {
  //     serviceSendError("Replacement Error");
  //     rethrow;
  //   }
  // }

  // Future changeuserStat({required int userId, required int status}) async {
  //   String? token = await PreferenceUtils.getDataFromShared("usertoken");

  //   try {
  //     serviceSend("status info");
  //     final response = await tradingApi
  //         .changeuserstat(userId: userId, status: status, token1: token!)
  //         .catchError((e, trace) {
  //       networkStreamController.sink.add(e.toString());
  //       throw e;
  //     });
  //     return response;
  //   } catch (e) {
  //     serviceSendError("status info error");
  //     rethrow;
  //   }
  // }

  // Future sendRescheduleRequest(
  //     {required String orderid,
  //     required String deliverydate,
  //     required String timerange,
  //     required int userid,
  //     required bool candeliver}) async {
  //   try {
  //     serviceSend("Reshedule Request");
  //     final response = await tradingApi
  //         .rescheduleRequest(
  //             orderid: orderid,
  //             deliverydate: deliverydate,
  //             userid: userid,
  //             timerange: timerange,
  //             candeliver: candeliver)
  //         .catchError((e, trace) {
  //       networkStreamController.sink.add(e.toString());
  //       throw e;
  //     });
  //     return response;
  //   } catch (e) {
  //     serviceSendError("Reschedule Request" + e.toString());
  //     rethrow;
  //   }
  // }

  // Future sendRescheduleRequestNOL(
  //     {required String orderid,
  //     required String deliverydate,
  //     required bool candeliver,
  //     required String comment,
  //     required int userid}) async {
  //   try {
  //     serviceSend("Reshedule Request");
  //     final response = await tradingApi
  //         .rescheduleRequestNOL(
  //             orderid: orderid,
  //             deliverydate: deliverydate,
  //             userid: userid,
  //             candeliver: candeliver,
  //             comment: comment)
  //         .catchError((e, trace) {
  //       networkStreamController.sink.add(e.toString());
  //       throw e;
  //     });
  //     return response;
  //   } catch (e) {
  //     serviceSendError("send Scheduled Request For NOL");
  //     rethrow;
  //   }
  // }

  // Future sendRescheduleRequestOthers(
  //     {required String orderid,
  //     required String fromdate,
  //     required String todate,
  //     required int userid,
  //     required String comment,
  //     required bool candeliver}) async {
  //   try {
  //     serviceSend("Reschedule Request");
  //     final response = await tradingApi
  //         .rescheduleRequestOthers(
  //             orderid: orderid,
  //             deliveryfrom: fromdate,
  //             deliveryto: todate,
  //             userid: userid,
  //             candeliver: candeliver,
  //             comment: comment)
  //         .catchError((e, trace) {
  //       networkStreamController.sink.add(e.toString());
  //       throw e;
  //     });
  //     return response;
  //   } catch (e) {
  //     serviceSendError("Reschedule Request Error");
  //     rethrow;
  //   }
  // }

  // Future changestatusRequest(
  //     {required String devicetoken,
  //     required Map<String, dynamic> data,
  //     required String userId,
  //     required String status}) async {
  //   String? token11 = await PreferenceUtils.getDataFromShared("usertoken");
  //   try {
  //     serviceSend("device info");
  //     final responce = await tradingApi
  //         .changeuserstatusinfo(
  //             devicetoken: devicetoken,
  //             userId: UserController().profileResponce.user[0].empId,
  //             token1: token11!,
  //             data: data,
  //             status: status,
  //             roleid: UserController().profileResponce.user[0].role)
  //         .catchError((e, trace) {
  //       networkStreamController.sink.add(e.toString());
  //       throw e;
  //     });
  //     return responce;
  //   } catch (e) {
  //     serviceSendError("device info");
  //     rethrow;
  //   }
  // }

  // Future addtoProductList(
  //     {required List<Map<String, dynamic>> dynamiclist}) async {
  //   try {
  //     final response = await tradingApi
  //         .addtoproductlist(dynamiclist: dynamiclist)
  //         .catchError((e, trace) {
  //       networkStreamController.sink.add(e.toString());
  //       throw e;
  //     });
  //     // print(dynamiclist);
  //     return response;
  //   } catch (e) {
  //     serviceSendError("Product Add To List API Error");

  //     return "Retry";
  //   }
  // }

  // Future getSimiliarItemsRequest({
  //   required String productid,
  // }) async {
  //   try {
  //     final response = await tradingApi
  //         .getsimilarProducts(product_id: productid)
  //         .catchError((e, trace) {
  //       networkStreamController.sink.add(e.toString());
  //       throw e;
  //     });
  //     //
  //     return response;
  //   } catch (e) {
  //     serviceSendError("get similiar requesterror");
  //     rethrow;
  //   }
  // }

  // Future updateSectionDataRequest(
  //     {required UpdateSectionRequest updateSectionRequest}) async {
  //   try {
  //     final response = await tradingApi
  //         .updateSectionData(updateSectionRequest: updateSectionRequest)
  //         .catchError((e, trace) {
  //       networkStreamController.sink.add(e.toString());
  //       throw e;
  //     });
  //     //
  //     return response;
  //   } catch (e) {
  //     serviceSendError("update section data request");
  //     rethrow;
  //   }
  // }

  // Future getSectionDataRequest(String user) async {
  //   try {
  //     final response =
  //         await tradingApi.getSectionData(user).catchError((e, trace) {
  //       networkStreamController.sink.add(e.toString());
  //       throw e;
  //     });
  //     //
  //     return response;
  //   } catch (e) {
  //     serviceSendError("get Section Data Request Error");
  //     rethrow;
  //   }
  // }

  // Future checkbarcodeavailablity({required String sku}) async {
  //   try {
  //     final response = await tradingApi
  //         .checkavailabilitybarcode(sku: sku)
  //         .catchError((e, trace) {
  //       networkStreamController.sink.add(e.toString());
  //       throw e;
  //     });

  //     return response;
  //   } catch (e) {
  //     serviceSendError("Product Barcode Check Error..!");

  //     return "Retry";
  //   }
  // }
}
