import 'package:equatable/equatable.dart';

abstract class PlantsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchPlants extends PlantsEvent {}

