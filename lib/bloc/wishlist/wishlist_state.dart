import 'package:equatable/equatable.dart';

abstract class WishlistState extends Equatable {
  @override
  List<Object> get props => [];
}

 class WishlistInitial extends WishlistState {}

class WishListLoaded extends WishlistState {
  final List<int> wishList;

  WishListLoaded(this.wishList);

  @override
  List<Object> get props => [wishList];
}
