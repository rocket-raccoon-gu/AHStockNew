import 'package:ahstock/navigation/navigation.dart';
import 'package:ahstock/services/api_gateway.dart';
import 'package:ahstock/services/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

extension AppPageInjectable on BuildContext {
  NavigationService get gNavigationService =>
      read<ServiceLocator>().navigationService;

  StockApiGateway get gTradingApiGateway => read<ServiceLocator>().tradingApi;

  void resetCubits() {
    read<ServiceLocator>().resetCubits();
  }
}
