import 'package:equatable/equatable.dart';

sealed class WishlistEvent extends Equatable {
  const WishlistEvent();

  @override
  List<Object> get props => [];
}

class AddOrRemovePlant extends WishlistEvent {
  final int plantId;

  const AddOrRemovePlant(this.plantId);
  @override
  List<Object> get props => [plantId];
}


class WishListInitialize extends WishlistEvent {
}
