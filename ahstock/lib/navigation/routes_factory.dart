part of 'navigation.dart';

abstract class RoutesFactory {
  Route<dynamic> createSplashPageRoute();
  Route<dynamic> createCountrySelectPage();
  Route<dynamic> createLoginPageRoute();
  Route<dynamic> createWorkspacePageRoute(Map<String, dynamic> data);
  Route<dynamic> createOrderPageRoute();
  Route<dynamic> createOrderInnerPageRoute(Map<String, dynamic> data);
  Route<dynamic> createConfirmPageRoute(Map<String, dynamic> data);
  Route<dynamic> createBarcodeScannerRoute(Map<String, dynamic> data);
  Route<dynamic> createProfilePageRoute(Map<String, dynamic> data);
  Route<dynamic> createEditConfirmPageRoute(Map<String, dynamic> data);
  Route<dynamic> createItemAddPageRoute(Map<String, dynamic> data);
  Route<dynamic> createAddItemConfirmPageRoute(Map<String, dynamic> data);
  Route<dynamic> createConfirmDriverPageRoute(Map<String, dynamic> data);
  Route<dynamic> createCancelConfirmPageRoute(Map<String, dynamic> data);
  Route<dynamic> createOrderInnerPickerPageRoute(Map<String, dynamic> data);
  Route<dynamic> createOrderInnerDriverPageRoute(Map<String, dynamic> data);
  Route<dynamic> createImageCapturePageRoute(Map<String, dynamic> data);
  Route<dynamic> createMapViewPageRoute(Map<String, dynamic> data);
  // Route<dynamic> createGeneratePageRoute(Map<String, dynamic> data);
  // Route<dynamic> createOrderViewPageRoute(Map<String, dynamic> data);
  // Route<dynamic> createGenerateOrdersReportPageRoute(Map<String, dynamic> data);
  Route<dynamic> createOutStockMarkedItemsPageRoute(Map<String, dynamic> data);
  Route<dynamic> createUploadDocumentsPageRoute(Map<String, dynamic> data);
  Route<dynamic> createReplacementMarkePageRoute(Map<String, dynamic> data);
  Route<dynamic> createMarkMissingItensPageRoute(Map<String, dynamic> data);
  Route<dynamic> createNewScanBarcodePageRoute(Map<String, dynamic> data);
  Route<dynamic> createItemInnerPageRoute(Map<String, dynamic> data);
  Route<dynamic> createItemReplacePageRoute(Map<String, dynamic> data);
  Route<dynamic> createSalesDashboardPageRoute(Map<String, dynamic> data);
  Route<dynamic> createProductDetailsPageRoute(Map<String, dynamic> data);
  Route<dynamic> createSelectRegionPageRoute(Map<String, dynamic> data);
  Route<dynamic> createSectionInchargePageRoute(Map<String, dynamic> data);
  Route<dynamic> createSignupPageRoute(Map<String, dynamic> data);
}
