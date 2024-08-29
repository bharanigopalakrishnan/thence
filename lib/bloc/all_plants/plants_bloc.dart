import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thence/bloc/all_plants/plants_event.dart';
import 'package:thence/bloc/all_plants/plants_state.dart';
import 'package:thence/service/plants/plant_service.dart';

class PlantsBloc extends Bloc<PlantsEvent, PlantsState> {
  PlantsBloc() : super(PlantsInitial()) {
    on<FetchPlants>(_onFetchPlants);
  }

  Future<void> _onFetchPlants(
      FetchPlants event, Emitter<PlantsState> emit) async {
    emit(PlantsLoading());
    try {
      final response = await PlantService.getAllPlants();
      if (response?.data != null && response!.data!.isNotEmpty) {
        emit(PlantsLoaded(response.data!));
      } else {
        emit(PlantsEmpty());
      }
    } catch (e) {
      emit(PlantsError(e.toString()));
    }
  }
}
