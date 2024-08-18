part of 'navigation.dart';

class NavigationService {
  Future<void> openSplashPage(BuildContext context) {
    return Navigator.of(context).pushNamed(_splash);
  }

  Future<void> openselectCountryPage(BuildContext context) {
    return Navigator.of(context).pushNamed(_select_country);
  }

  Future<void> openLoginPage(BuildContext context) {
    return Navigator.of(context).pushNamedAndRemoveUntil(
        _loginPageRouteName, (Route<dynamic> route) => false);
  }

  Future<void> openWorkspacePage(
      BuildContext context, Map<String, dynamic> data) {
    return Navigator.of(context).pushNamedAndRemoveUntil(
        _workspacePageRouteName, (Route<dynamic> route) => false,
        arguments: MapArguments(data));
  }

  // Future<void> openOrderPage(BuildContext context) {
  //   return Navigator.of(context).pushNamedAndRemoveUntil(
  //       _orderPageRouteName, (Route<dynamic> route) => false);
  // }

  // Future<void> openOrderInnerPage(
  //     BuildContext context, Map<String, dynamic> data) {
  //   return Navigator.of(context)
  //       .pushNamed(_orderInnerPageRouteName, arguments: MapArguments(data));
  // }

  // Future<void> openOrderInnerPagePicker(
  //     BuildContext context, Map<String, dynamic> data) {
  //   return Navigator.of(context).pushNamed(_orderInnerPickerPageRouteName,
  //       arguments: MapArguments(data));
  // }

  // Future<void> openOrderInnerPageDriver(
  //     BuildContext context, Map<String, dynamic> data) {
  //   return Navigator.of(context).pushNamed(_orderInnerDriverPageRouteName,
  //       arguments: MapArguments(data));
  // }

  // dynamic back(BuildContext context, {Map<String, dynamic>? arg}) {
  //   return Navigator.pop(context, arg);
  // }

  // Future<void> openConfirmPage(
  //     BuildContext context, Map<String, dynamic> data) {
  //   return Navigator.of(context).pushNamedAndRemoveUntil(
  //       _confirmPageRouteName, (Route<dynamic> route) => false,
  //       arguments: MapArguments(data));
  // }

  // Future<void> openPickerAssignPage(
  //     BuildContext context, Map<String, dynamic> data) {
  //   return Navigator.of(context)
  //       .pushNamed(_pickerAssignPageRouteName, arguments: MapArguments(data));
  // }

  // Future<void> openBarcodeScannerPage(
  //     BuildContext context, Map<String, dynamic> data) {
  //   return Navigator.of(context)
  //       .pushNamed(_barcodePageRouteName, arguments: MapArguments(data));
  // }

  // Future<void> openOrderStatusPage(
  //     BuildContext context, Map<String, dynamic> data) {
  //   return Navigator.of(context)
  //       .pushNamed(_orderStatusPageRouteName, arguments: MapArguments(data));
  // }

  // Future<void> openManageOrderPage(BuildContext context) {
  //   return Navigator.of(context).pushNamed(_manageorderPageRouteName);
  // }

  // Future<void> openManageOrderConfirmPage(
  //     BuildContext context, Map<String, dynamic> data) {
  //   return Navigator.of(context).pushNamed(_manageorderConfirmPageRouteName,
  //       arguments: MapArguments(data));
  // }

  // Future<void> openManageOrderItemList(
  //     BuildContext context, Map<String, dynamic> data) {
  //   return Navigator.of(context).pushNamed(_manageOrderlistItemPageRouteName,
  //       arguments: MapArguments(data));
  // }

  // Future<void> openProfilePage(
  //     BuildContext context, Map<String, dynamic> data) {
  //   return Navigator.of(context)
  //       .pushNamed(_profilePageRouteName, arguments: MapArguments(data));
  // }

  // Future<void> openPickerSummery(
  //     BuildContext context, Map<String, dynamic> data) {
  //   return Navigator.of(context)
  //       .pushNamed(_pickerSummeryPageRouteName, arguments: MapArguments(data));
  // }

  // Future<void> openoutofstockItemslist(BuildContext context) {
  //   return Navigator.of(context).pushNamed(_outofstockitemsPageRouteName);
  // }

  // Future<void> openoutstockMarkedItemsPage(
  //     BuildContext context, Map<String, dynamic> data) {
  //   return Navigator.of(context)
  //       .pushNamed(_outStockPageRouteName, arguments: MapArguments(data));
  // }

  // Future<void> openUploadDocumentsPage(
  //     BuildContext context, Map<String, dynamic> data) {
  //   return Navigator.of(context).pushNamed(_uploadDocumentsPageRouteName,
  //       arguments: MapArguments(data));
  // }

  // Future<void> openconfirmedit(
  //     BuildContext context, Map<String, dynamic> data) {
  //   return Navigator.of(context).pushNamedAndRemoveUntil(
  //       _editOrderConfirmPageRouteName, (Route<dynamic> route) => false,
  //       arguments: MapArguments(data));
  // }

  // Future<void> openAddItem(BuildContext context, Map<String, dynamic> data) {
  //   return Navigator.of(context)
  //       .pushNamed(_additemPageRouteName, arguments: MapArguments(data));
  // }

  // Future<void> openAddItemConfirm(
  //     BuildContext context, Map<String, dynamic> data) {
  //   return Navigator.of(context).pushNamedAndRemoveUntil(
  //       _additemconfirmPageRouteName, (Route<dynamic> route) => false,
  //       arguments: MapArguments(data));
  // }

  // Future<void> openConfirmDriver(
  //     BuildContext context, Map<String, dynamic> data) {
  //   return Navigator.of(context).pushNamedAndRemoveUntil(
  //       _confirmDriverPageRouteName, (Route<dynamic> route) => false,
  //       arguments: MapArguments(data));
  // }

  // Future<void> openReAssignManageOrder(
  //     BuildContext context, Map<String, dynamic> data) {
  //   return Navigator.of(context).pushNamed(_reassignmanageorderRouteName,
  //       arguments: MapArguments(data));
  // }

  // Future<void> openCancelConfirm(
  //     BuildContext context, Map<String, dynamic> data) {
  //   return Navigator.of(context).pushNamedAndRemoveUntil(
  //       _confirmCancelRequestRouteName, (Route<dynamic> route) => false,
  //       arguments: MapArguments(data));
  // }

  // Future<void> openDeleteConfirm(
  //     BuildContext context, Map<String, dynamic> data) {
  //   return Navigator.of(context).pushNamedAndRemoveUntil(
  //       _deleteItemConfirmPageRouteName, (Route<dynamic> data) => false,
  //       arguments: MapArguments(data));
  // }

  // Future<void> openCaptureImage(
  //     BuildContext context, Map<String, dynamic> data) {
  //   return Navigator.of(context)
  //       .pushNamed(_imagecapturePageRouteName, arguments: MapArguments(data));
  // }

  // Future<void> openInvoiceGeneratePage(
  //     BuildContext context, Map<String, dynamic> data) {
  //   return Navigator.of(context).pushNamed(_invoicegeneratePageRouteName,
  //       arguments: MapArguments(data));
  // }

  // Future<void> openMapViewPage(
  //     BuildContext context, Map<String, dynamic> data) {
  //   return Navigator.of(context)
  //       .pushNamed(_mapViewPageRouteName, arguments: MapArguments(data));
  // }

  // Future<void> openGenerateReportPage(
  //     BuildContext context, Map<String, dynamic> data) {
  //   return Navigator.of(context).pushNamed(_generalOrderReportsPageRouteName,
  //       arguments: MapArguments(data));
  // }

  // Future<void> openOrderViewPage(
  //     BuildContext context, Map<String, dynamic> data) {
  //   return Navigator.of(context)
  //       .pushNamed(_orderViewPageRouteName, arguments: MapArguments(data));
  // }

  // Future<void> openGenerateOrderReportPage(
  //     BuildContext context, Map<String, dynamic> data) {
  //   return Navigator.of(context).pushNamed(_generalOrderReportsPageRouteName,
  //       arguments: MapArguments(data));
  // }

  // Future<void> openReplacementMarkItemsPage(
  //     BuildContext context, Map<String, dynamic> data) {
  //   return Navigator.of(context).pushNamed(_replacementmarkeditemspageRouteName,
  //       arguments: MapArguments(data));
  // }

  // Future<void> openMarkMissingItemsPage(
  //     BuildContext context, Map<String, dynamic> data) {
  //   return Navigator.of(context).pushNamed(_markmissingitemspageRouteName,
  //       arguments: MapArguments(data));
  // }

  Future<void> openNewScannerPage(
      BuildContext context, Map<String, dynamic> data) {
    // return Navigator.of(context)
    //     .pushNamed(_newScanBarcodePageRouteName, arguments: MapArguments(data));
    return Navigator.of(context).pushNamedAndRemoveUntil(
        _newScanBarcodePageRouteName, (Route<dynamic> route) => false,
        arguments: MapArguments(data));
  }

  // Future<void> openNewScannerPage2(
  //     BuildContext context, Map<String, dynamic> data) {
  //   return Navigator.of(context)
  //       .pushNamed(_newScanBarcodePageRouteName, arguments: MapArguments(data));
  // }

  // Future<void> openItemInnerPage(
  //     BuildContext context, Map<String, dynamic> data) {
  //   return Navigator.of(context)
  //       .pushNamed(_itemInnerPageRouteName, arguments: MapArguments(data));
  // }

  // Future<void> openItemReplacePage(
  //     BuildContext context, Map<String, dynamic> data) {
  //   return Navigator.of(context)
  //       .pushNamed(_itemReplacePageRouteName, arguments: MapArguments(data));
  // }

  Future<void> openSalesMansDashboardPage(
      BuildContext context, Map<String, dynamic> data) {
    // return Navigator.of(context)
    //     .pushNamed(_salesDashBoardPageRouteName, arguments: MapArguments(data));

    return Navigator.of(context).pushNamedAndRemoveUntil(
        _salesDashBoardPageRouteName, (Route<dynamic> route) => false,
        arguments: MapArguments(data));
  }

  // Future<void> openSectionInchargeHomePage(
  //     BuildContext context, Map<String, dynamic> data) {
  //   // return Navigator.of(context)
  //   //     .pushNamed(_salesDashBoardPageRouteName, arguments: MapArguments(data));

  //   return Navigator.of(context).pushNamedAndRemoveUntil(
  //       _sectionInChargePageRouteName, (Route<dynamic> route) => false,
  //       arguments: MapArguments(data));
  // }

  // Future<void> openProductDetailsPage(
  //     BuildContext context, Map<String, dynamic> data) {
  //   return Navigator.of(context)
  //       .pushNamed(_productDetailsPageRouteName, arguments: MapArguments(data));
  // }

  Future<void> openSelectRegionsPage(
      BuildContext context, Map<String, dynamic> data) {
    return Navigator.of(context)
        .pushNamed(_selectRegionPageRouteName, arguments: MapArguments(data));
  }

  // Future<void> openSignupPage(BuildContext context, Map<String, dynamic> data) {
  //   return Navigator.of(context)
  //       .pushNamed(_signupPageRouteName, arguments: MapArguments(data));
  // }
}
