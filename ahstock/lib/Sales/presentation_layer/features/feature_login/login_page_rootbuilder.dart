import 'package:ahstock/Sales/presentation_layer/features/feature_login/bloc/login_cubit.dart';
import 'package:ahstock/Sales/presentation_layer/features/feature_login/login_page.dart';
import 'package:ahstock/services/service_locator.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPageRouteBuilder {
  final ServiceLocator _serviceLocator;

  LoginPageRouteBuilder(this._serviceLocator);

  Widget call(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) =>
                  LoginCubit(context, serviceLocator: _serviceLocator)),
        ],
        child: MultiRepositoryProvider(
            providers: [
              RepositoryProvider.value(value: _serviceLocator.tradingApi),
            ],
            child: LoginPage(
              serviceLocator: _serviceLocator,
            )));
  }
}
