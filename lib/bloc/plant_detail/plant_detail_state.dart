import 'package:equatable/equatable.dart';
import 'package:thence/models/plants/plant.dart';
// Adjust path as needed

abstract class PlantDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class PlantDetailInitial extends PlantDetailState {}

class PlantDetailLoaded extends PlantDetailState {
  final Plant plantDetail;

  PlantDetailLoaded(this.plantDetail);

  @override
  List<Object> get props => [plantDetail];
}
