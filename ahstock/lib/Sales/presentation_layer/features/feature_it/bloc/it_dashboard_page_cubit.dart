import 'dart:convert';
import 'dart:developer';

import 'package:ahstock/Sales/presentation_layer/features/feature_it/bloc/it_dashboard_page_state.dart';
import 'package:ahstock/services/service_locator.dart';
import 'package:ahstock/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';
import 'package:stock_api/responses/it_data_response.dart';

class ItDashboardPageCubit extends Cubit<ItDashboardPageState> {
  final ServiceLocator serviceLocator;
  Map<String, dynamic> data;
  BuildContext context;

  ItDashboardPageCubit(this.serviceLocator, this.data, this.context)
      : super(ItDashboardLoadingPageState()) {
    updateData();
  }

  List<Item> items = [];

  void updateData() {
    emit(ItDashboardInitialPageState(items));
  }

  checkBarcode(String sku) async {
    try {
      String data =
          await serviceLocator.tradingApi.itDashboardService(endpoint: sku);

      Navigator.pop(context);
      Map<String, dynamic> datamap = jsonDecode(data);

      if (!datamap.containsKey('message')) {
        ItData itData = ItData.fromJson(datamap);

        items = itData.items;
      }
    } catch (e) {}

    emit(ItDashboardInitialPageState(items));
  }

  updateListData(List<Map<String, dynamic>> listdata) async {
    try {
      final updateresp = await serviceLocator.tradingApi
          .itDashboardEntryService(data: listdata);

      Navigator.pop(context);

      if (updateresp.statusCode == 200) {
        items.clear();
        showSnackBar(
            context: context,
            snackBar: showSuccessDialogue(message: "Data Updated"));
        emit(ItDashboardInitialPageState(items));
      } else {
        showSnackBar(
            context: context,
            snackBar:
                showErrorDialogue1(errorMessage: "Data Update Failed...!"));
      }
    } catch (e) {
      log(e.toString());
      showSnackBar(
          context: context,
          snackBar:
              showErrorDialogue1(errorMessage: "Something went wrong...!"));
    }
  }
}
