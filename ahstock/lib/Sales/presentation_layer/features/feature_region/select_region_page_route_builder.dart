import 'package:ahstock/Sales/presentation_layer/features/feature_region/bloc/select_region_page_cubit.dart';
import 'package:ahstock/Sales/presentation_layer/features/feature_region/select_region_page.dart';
import 'package:ahstock/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectRegionPageRootBuilder {
  final ServiceLocator serviceLocator;
  Map<String, dynamic> data;
  SelectRegionPageRootBuilder(
      {required this.serviceLocator, required this.data});

  Widget call(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => SelectRegionPageCubit(serviceLocator, data))
        ],
        child: MultiRepositoryProvider(providers: [
          RepositoryProvider.value(value: serviceLocator.tradingApi)
        ], child: const SelectRegionPage()));
  }
}
