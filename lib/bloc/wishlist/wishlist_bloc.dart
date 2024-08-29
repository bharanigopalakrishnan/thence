import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:thence/bloc/wishlist/wishlist_event.dart';
import 'package:thence/bloc/wishlist/wishlist_state.dart';


class WishlistBloc extends Bloc<WishlistEvent, WishlistState> {
  WishlistBloc() : super(WishlistInitial()) {
    on<AddOrRemovePlant>(_onPlantAdd);
    on<WishListInitialize>((event, emit) => emit(WishListLoaded(const [])),);
  }

Future<void> _onPlantAdd(
  AddOrRemovePlant event, Emitter<WishlistState> emit) async {
  try {
    if (state is WishListLoaded) {
      final currentState = state as WishListLoaded;
      final List<int> updatedWishlist = List.from(currentState.wishList);
      if(updatedWishlist.contains(event.plantId)){
        updatedWishlist.remove(event.plantId);
      }else{
      updatedWishlist.add(event.plantId);      

      }
      emit(WishListLoaded(updatedWishlist));
    } else {
      emit(WishListLoaded( [event.plantId]));
    }
  } catch (e) {
  }
}
}
