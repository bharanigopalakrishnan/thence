import 'package:equatable/equatable.dart';
import 'package:thence/models/plants/plant.dart';

abstract class PlantDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SetPlantDetail extends PlantDetailEvent {
  final Plant plantData;

  SetPlantDetail(
    this.plantData,
  );

  @override
  List<Object> get props => [plantData];
}
