import 'package:ahstock/Sales/presentation_layer/features/feature_login/login_page_rootbuilder.dart';
import 'package:ahstock/Sales/presentation_layer/features/feature_region/select_region_page_route_builder.dart';
import 'package:ahstock/Sales/presentation_layer/features/feature_sales/sales_dashboard_page_route_builder.dart';
import 'package:ahstock/Sales/presentation_layer/features/feature_splash/splash_page_rootbuilder.dart';
import 'package:ahstock/navigation/navigation.dart';
import 'package:ahstock/services/service_locator.dart';
import 'package:flutter/material.dart';

class AppRoutesFactory extends RoutesFactory {
  final ServiceLocator _serviceLocator;

  AppRoutesFactory(this._serviceLocator);

  @override
  Route createLoginPageRoute() {
    // TODO: implement createLoginPageRoute
    return CustomRoute(
      builder: LoginPageRouteBuilder(_serviceLocator).call,
    );
  }

  @override
  Route createSplashPageRoute() {
    // TODO: implement createSplashPageRoute
    return CustomRoute(builder: SplashPageRouteBuilder(_serviceLocator).call);
  }

  @override
  Route createAddItemConfirmPageRoute(Map<String, dynamic> data) {
    // TODO: implement createAddItemConfirmPageRoute
    throw UnimplementedError();
  }

  @override
  Route createBarcodeScannerRoute(Map<String, dynamic> data) {
    // TODO: implement createBarcodeScannerRoute
    throw UnimplementedError();
  }

  @override
  Route createCancelConfirmPageRoute(Map<String, dynamic> data) {
    // TODO: implement createCancelConfirmPageRoute
    throw UnimplementedError();
  }

  @override
  Route createConfirmDriverPageRoute(Map<String, dynamic> data) {
    // TODO: implement createConfirmDriverPageRoute
    throw UnimplementedError();
  }

  @override
  Route createConfirmPageRoute(Map<String, dynamic> data) {
    // TODO: implement createConfirmPageRoute
    throw UnimplementedError();
  }

  @override
  Route createCountrySelectPage() {
    // TODO: implement createCountrySelectPage
    throw UnimplementedError();
  }

  @override
  Route createEditConfirmPageRoute(Map<String, dynamic> data) {
    // TODO: implement createEditConfirmPageRoute
    throw UnimplementedError();
  }

  @override
  Route createImageCapturePageRoute(Map<String, dynamic> data) {
    // TODO: implement createImageCapturePageRoute
    throw UnimplementedError();
  }

  @override
  Route createItemAddPageRoute(Map<String, dynamic> data) {
    // TODO: implement createItemAddPageRoute
    throw UnimplementedError();
  }

  @override
  Route createItemInnerPageRoute(Map<String, dynamic> data) {
    // TODO: implement createItemInnerPageRoute
    throw UnimplementedError();
  }

  @override
  Route createItemReplacePageRoute(Map<String, dynamic> data) {
    // TODO: implement createItemReplacePageRoute
    throw UnimplementedError();
  }

  @override
  Route createMapViewPageRoute(Map<String, dynamic> data) {
    // TODO: implement createMapViewPageRoute
    throw UnimplementedError();
  }

  @override
  Route createMarkMissingItensPageRoute(Map<String, dynamic> data) {
    // TODO: implement createMarkMissingItensPageRoute
    throw UnimplementedError();
  }

  @override
  Route createNewScanBarcodePageRoute(Map<String, dynamic> data) {
    // TODO: implement createNewScanBarcodePageRoute
    throw UnimplementedError();
  }

  @override
  Route createOrderInnerDriverPageRoute(Map<String, dynamic> data) {
    // TODO: implement createOrderInnerDriverPageRoute
    throw UnimplementedError();
  }

  @override
  Route createOrderInnerPageRoute(Map<String, dynamic> data) {
    // TODO: implement createOrderInnerPageRoute
    throw UnimplementedError();
  }

  @override
  Route createOrderInnerPickerPageRoute(Map<String, dynamic> data) {
    // TODO: implement createOrderInnerPickerPageRoute
    throw UnimplementedError();
  }

  @override
  Route createOrderPageRoute() {
    // TODO: implement createOrderPageRoute
    throw UnimplementedError();
  }

  @override
  Route createOutStockMarkedItemsPageRoute(Map<String, dynamic> data) {
    // TODO: implement createOutStockMarkedItemsPageRoute
    throw UnimplementedError();
  }

  @override
  Route createProductDetailsPageRoute(Map<String, dynamic> data) {
    // TODO: implement createProductDetailsPageRoute
    throw UnimplementedError();
  }

  @override
  Route createProfilePageRoute(Map<String, dynamic> data) {
    // TODO: implement createProfilePageRoute
    throw UnimplementedError();
  }

  @override
  Route createReplacementMarkePageRoute(Map<String, dynamic> data) {
    // TODO: implement createReplacementMarkePageRoute
    throw UnimplementedError();
  }

  @override
  Route createSalesDashboardPageRoute(Map<String, dynamic> data) {
    // TODO: implement createSalesDashboardPageRoute
    return CustomRoute(
        builder: SalesDashBoardPageRouteBuilder(_serviceLocator, data).call);
  }

  @override
  Route createSectionInchargePageRoute(Map<String, dynamic> data) {
    // TODO: implement createSectionInchargePageRoute
    throw UnimplementedError();
  }

  @override
  Route createSelectRegionPageRoute(Map<String, dynamic> data) {
    // TODO: implement createSelectRegionPageRoute
    return CustomRoute(
        builder: SelectRegionPageRootBuilder(
                data: data, serviceLocator: _serviceLocator)
            .call);
  }

  @override
  Route createSignupPageRoute(Map<String, dynamic> data) {
    // TODO: implement createSignupPageRoute
    throw UnimplementedError();
  }

  @override
  Route createUploadDocumentsPageRoute(Map<String, dynamic> data) {
    // TODO: implement createUploadDocumentsPageRoute
    throw UnimplementedError();
  }

  @override
  Route createWorkspacePageRoute(Map<String, dynamic> data) {
    // TODO: implement createWorkspacePageRoute
    throw UnimplementedError();
  }
}

class CustomRoute<T> extends MaterialPageRoute<T> {
  CustomRoute({required super.builder});
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    return SlideTransition(
      transformHitTests: false,
      position: Tween<Offset>(
        begin: const Offset(1.0, 0.0),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        reverseCurve: Curves.easeOut,
        parent: animation,
        curve: Curves.ease,
      )),
      child: child,
    );
  }
}
