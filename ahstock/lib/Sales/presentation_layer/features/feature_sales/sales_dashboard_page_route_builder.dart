import 'package:ahstock/Sales/presentation_layer/features/feature_sales/bloc/sales_dashboard_page_cubit.dart';
import 'package:ahstock/Sales/presentation_layer/features/feature_sales/ui/sales_dashboard.dart';
import 'package:ahstock/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SalesDashBoardPageRouteBuilder {
  final ServiceLocator serviceLocator;
  Map<String, dynamic> data;

  SalesDashBoardPageRouteBuilder(this.serviceLocator, this.data);
  Widget call(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  SalesDashBoradPageCubit(serviceLocator, {}, context))
        ],
        child: MultiRepositoryProvider(providers: [
          RepositoryProvider.value(value: serviceLocator.tradingApi),
        ], child: const SalesDashboard()));
  }
}
