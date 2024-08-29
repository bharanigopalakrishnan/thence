import 'package:equatable/equatable.dart';
import 'package:thence/models/plants/plant.dart';
// Adjust path as needed

abstract class PlantsState extends Equatable {
  @override
  List<Object> get props => [];
}

class PlantsInitial extends PlantsState {}

class PlantsLoading extends PlantsState {}

class PlantsEmpty extends PlantsState {}

class PlantsLoaded extends PlantsState {
  final List<Plant> plants;

  PlantsLoaded(this.plants);

  @override
  List<Object> get props => [plants];
}

class PlantsError extends PlantsState {
  final String message;

  PlantsError(this.message);

  @override
  List<Object> get props => [message];
}
