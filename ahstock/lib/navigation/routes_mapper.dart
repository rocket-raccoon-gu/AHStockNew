part of 'navigation.dart';

Route<dynamic>? Function(RouteSettings settings) onGenerateAppRoute(
    RoutesFactory routesFactory) {
  return (RouteSettings settings) {
    switch (settings.name) {
      case _splash:
        return routesFactory.createSplashPageRoute();
      case _select_country:
        return routesFactory.createCountrySelectPage();
      case _loginPageRouteName:
        return routesFactory.createLoginPageRoute();
      case _workspacePageRouteName:
        final arg = settings.arguments as MapArguments;
        return routesFactory.createWorkspacePageRoute(arg.data);
      case _orderPageRouteName:
        return routesFactory.createOrderPageRoute();
      case _orderInnerPageRouteName:
        final arg = settings.arguments as MapArguments;
        return routesFactory.createOrderInnerPageRoute(arg.data);
      case _confirmPageRouteName:
        final arg = settings.arguments as MapArguments;
        return routesFactory.createConfirmPageRoute(arg.data);
      case _barcodePageRouteName:
        final arg = settings.arguments as MapArguments;
        return routesFactory.createBarcodeScannerRoute(arg.data);
      case _profilePageRouteName:
        final arg = settings.arguments as MapArguments;
        return routesFactory.createProfilePageRoute(arg.data);
      case _editOrderConfirmPageRouteName:
        final arg = settings.arguments as MapArguments;
        return routesFactory.createEditConfirmPageRoute(arg.data);
      case _additemPageRouteName:
        final arg = settings.arguments as MapArguments;
        return routesFactory.createItemAddPageRoute(arg.data);
      case _additemconfirmPageRouteName:
        final arg = settings.arguments as MapArguments;
        return routesFactory.createAddItemConfirmPageRoute(arg.data);
      case _confirmDriverPageRouteName:
        final arg = settings.arguments as MapArguments;
        return routesFactory.createConfirmDriverPageRoute(arg.data);
      case _confirmCancelRequestRouteName:
        final arg = settings.arguments as MapArguments;
        return routesFactory.createCancelConfirmPageRoute(arg.data);
      case _orderInnerPickerPageRouteName:
        final arg = settings.arguments as MapArguments;
        return routesFactory.createOrderInnerPickerPageRoute(arg.data);
      case _orderInnerDriverPageRouteName:
        final arg = settings.arguments as MapArguments;
        return routesFactory.createOrderInnerDriverPageRoute(arg.data);
      case _imagecapturePageRouteName:
        final arg = settings.arguments as MapArguments;
        return routesFactory.createImageCapturePageRoute(arg.data);
      case _invoicegeneratePageRouteName:
      case _mapViewPageRouteName:
        final arg = settings.arguments as MapArguments;
        return routesFactory.createMapViewPageRoute(arg.data);
      // case _generateReportPageRouteName:
      // final arg = settings.arguments as MapArguments;
      // return routesFactory.createGeneratePageRoute(arg.data);
      // case _generalOrderReportsPageRouteName:
      //   final arg = settings.arguments as MapArguments;
      //   return routesFactory.createGenerateOrdersReportPageRoute(arg.data);
      case _outStockPageRouteName:
        final arg = settings.arguments as MapArguments;
        return routesFactory.createOutStockMarkedItemsPageRoute(arg.data);
      case _uploadDocumentsPageRouteName:
        final arg = settings.arguments as MapArguments;
        return routesFactory.createUploadDocumentsPageRoute(arg.data);
      case _replacementmarkeditemspageRouteName:
        final arg = settings.arguments as MapArguments;
        return routesFactory.createReplacementMarkePageRoute(arg.data);
      case _markmissingitemspageRouteName:
        final arg = settings.arguments as MapArguments;
        return routesFactory.createMarkMissingItensPageRoute(arg.data);
      case _newScanBarcodePageRouteName:
        final arg = settings.arguments as MapArguments;
        return routesFactory.createNewScanBarcodePageRoute(arg.data);
      case _itemInnerPageRouteName:
        final arg = settings.arguments as MapArguments;
        return routesFactory.createItemInnerPageRoute(arg.data);
      case _itemReplacePageRouteName:
        final arg = settings.arguments as MapArguments;
        return routesFactory.createItemReplacePageRoute(arg.data);
      case _salesDashBoardPageRouteName:
        final arg = settings.arguments as MapArguments;
        return routesFactory.createSalesDashboardPageRoute(arg.data);
      case _productDetailsPageRouteName:
        final arg = settings.arguments as MapArguments;
        return routesFactory.createProductDetailsPageRoute(arg.data);
      case _selectRegionPageRouteName:
        final arg = settings.arguments as MapArguments;
        return routesFactory.createSelectRegionPageRoute(arg.data);
      case _sectionInChargePageRouteName:
        final arg = settings.arguments as MapArguments;
        return routesFactory.createSectionInchargePageRoute(arg.data);
      case _signupPageRouteName:
        final arg = settings.arguments as MapArguments;
        return routesFactory.createSignupPageRoute(arg.data);
      default:
        return null;
    }
  };
}
