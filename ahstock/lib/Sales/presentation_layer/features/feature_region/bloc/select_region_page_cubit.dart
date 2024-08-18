
import 'package:ahstock/Sales/presentation_layer/features/feature_region/bloc/select_region_page_state.dart';
import 'package:ahstock/services/service_locator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectRegionPageCubit extends Cubit<SelectRegionPageState> {
  final ServiceLocator serviceLocator;
  Map<String, dynamic> data;

  SelectRegionPageCubit(this.serviceLocator, this.data)
      : super(SelectRegionPageLoadingState()) {
    updatedata();
  }

  updatedata() {}
}
