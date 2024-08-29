import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thence/bloc/plant_detail/plant_detail_event.dart';
import 'package:thence/bloc/plant_detail/plant_detail_state.dart';

class PlantDetailBloc extends Bloc<PlantDetailEvent, PlantDetailState> {
  PlantDetailBloc() : super(PlantDetailInitial()) {
    on<SetPlantDetail>(_onFetchPlants);
  }

  Future<void> _onFetchPlants(
      SetPlantDetail event, Emitter<PlantDetailState> emit) async {
    try {
      emit(PlantDetailLoaded(event.plantData));
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Future<void> close() async {
    await super.close();
  }
}
