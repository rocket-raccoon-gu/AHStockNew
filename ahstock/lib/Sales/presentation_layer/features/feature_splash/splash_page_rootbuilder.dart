import 'package:ahstock/Sales/presentation_layer/features/feature_splash/bloc/splash_page_cubit.dart';
import 'package:ahstock/Sales/presentation_layer/features/feature_splash/splash_page.dart';
import 'package:ahstock/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashPageRouteBuilder {
  final ServiceLocator _serviceLocator;

  SplashPageRouteBuilder(this._serviceLocator);

  Widget call(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => SplashInitialPageCubit(context,
                  serviceLocator: _serviceLocator))
        ],
        child: MultiRepositoryProvider(providers: [
          RepositoryProvider.value(value: _serviceLocator.tradingApi),
        ], child: const SplashPage()));
  }
}
