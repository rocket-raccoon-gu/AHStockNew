import 'package:ahstock/Sales/presentation_layer/features/feature_it/bloc/it_dashboard_page_state.dart';
import 'package:ahstock/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItDashboardPageCubit extends Cubit<ItDashboardPageState> {
  final ServiceLocator serviceLocator;
  Map<String, dynamic> data;
  BuildContext context;

  ItDashboardPageCubit(this.serviceLocator,this.data,this.context) : super (ItDashboardLoadingPageState()) {
    updateData();
  }

  void updateData() {
    
  }
}