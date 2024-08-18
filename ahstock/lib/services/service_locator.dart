import 'dart:async';

import 'package:ahstock/navigation/navigation.dart';
import 'package:ahstock/services/api_gateway.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:stock_api/stock_api.dart';



abstract class CubitsLocator {
  void resetCubits();
  void configCubits();
}

class ServiceLocator implements CubitsLocator {
  final GetIt _registry;
  final String _baseUrl;
  final String _applicationPath;
  final bool _debuggable;

  ServiceLocator(this._baseUrl, this._applicationPath,
      {bool debuggable = kDebugMode})
      : _debuggable = debuggable,
        _registry = GetIt.asNewInstance();

  NavigationService get navigationService => _registry.get<NavigationService>();

  StockApiGateway get tradingApi => _registry.get<StockApiGateway>();

  void config() {
    _registry.registerLazySingleton(
      () => NavigationService(),
    );

    _registry.registerLazySingleton(
      () => StockApiGateway(
          _debuggable
              ? StockApi.debuggable(
                  baseUrl: _baseUrl, applicationPath: _applicationPath)
              : StockApi.create(
                  baseUrl: _baseUrl, applicationPath: _applicationPath),
          StreamController<String>.broadcast()),
    );
  }

  @override
  void configCubits() {
    // TODO: implement configCubits
  }

  @override
  void resetCubits() {
    // TODO: implement resetCubits
  }
}
