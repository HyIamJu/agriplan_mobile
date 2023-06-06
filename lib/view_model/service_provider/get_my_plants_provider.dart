import 'package:flutter/material.dart';
import 'package:mobile_flutter/models/plants_response_model.dart';

import '../../services/services_restapi_impl.dart';
import '../../utils/state/finite_state.dart';

class GetMyPlantsProvider extends ChangeNotifier {
  final service = ServicesRestApiImpl();
  MyState state = MyState.loading;
  List<PlantsResponseModel> myPlants = [];

  void getMyPlantsData() async {
    if (state == MyState.loaded || state == MyState.failed) {
      state = MyState.loading;
      notifyListeners();
    }
    try {
      myPlants.clear();
      final response = await service.getMyPlants();
      myPlants = response;

      state = MyState.loaded;
      notifyListeners();
    } catch (e) {
      state = MyState.failed;
      notifyListeners();
    }
  }
}
