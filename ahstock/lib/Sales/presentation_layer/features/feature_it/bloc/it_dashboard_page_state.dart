import 'package:stock_api/responses/it_data_response.dart';

abstract class ItDashboardPageState {}

class ItDashboardInitialPageState extends ItDashboardPageState {
  List<Item> items = [];

  ItDashboardInitialPageState(this.items);
}

class ItDashboardLoadingPageState extends ItDashboardPageState {}
