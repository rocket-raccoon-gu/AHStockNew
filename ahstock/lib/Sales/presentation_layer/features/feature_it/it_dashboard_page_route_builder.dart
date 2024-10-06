import 'package:ahstock/Sales/presentation_layer/features/feature_it/bloc/it_dashboard_page_cubit.dart';
import 'package:ahstock/Sales/presentation_layer/features/feature_it/ui/it_dashboard_page.dart';
import 'package:ahstock/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItDashboardPageRouteBuilder {
  final ServiceLocator serviceLocator;
  Map<String, dynamic> data;

  ItDashboardPageRouteBuilder(this.serviceLocator,this.data);

  Widget call(BuildContext context){
    return MultiBlocProvider(providers: [
BlocProvider(
              create: (context) =>
                  ItDashboardPageCubit(serviceLocator, {}, context))
    ], child: MultiRepositoryProvider(providers: [
      RepositoryProvider.value(value: serviceLocator.tradingApi),
    ], child: ItDashboardPage()));
  }
}