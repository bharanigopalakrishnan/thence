import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thence/bloc/wishlist/wishlist_bloc.dart';
import 'package:thence/bloc/wishlist/wishlist_event.dart';
import 'package:thence/bloc/wishlist/wishlist_state.dart';
import 'package:thence/models/plants/plant.dart';
import 'package:thence/styles/app_color.dart';
import 'package:thence/styles/app_text_style.dart';

class PlantCard extends StatefulWidget {
  final Plant plant;
  final Color bgColor;
  const PlantCard({super.key, required this.plant, required this.bgColor});

  @override
  State<PlantCard> createState() => _PlantCardState();
}

class _PlantCardState extends State<PlantCard> {
  bool isWishListAdded = false;

  @override
  Widget build(BuildContext context) {
    final wishlistBloc = context.read<WishlistBloc>();
    if (wishlistBloc.state is WishListLoaded) {
      isWishListAdded = (wishlistBloc.state as WishListLoaded)
          .wishList
          .contains(widget.plant.id);
    }
    return Container(
      color: AppColor.colorLight,
      padding: EdgeInsets.only(left: 15.sp, right: 15.sp),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                padding: EdgeInsets.only(top: 15.sp),
                constraints: BoxConstraints(maxHeight: 80.sp, maxWidth: 115.sp),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.sp),
                    color: widget.bgColor),
              ),
              CachedNetworkImage(
                imageUrl: widget.plant.imageUrl ?? "",
                height: 110.sp,
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
              ),
              Positioned(
                right: 10.sp,
                bottom: 6.sp,
                child: GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    wishlistBloc.add(AddOrRemovePlant(widget.plant.id!));
                    setState(() {});
                  },
                  child: Container(
                    padding: EdgeInsets.all(4.sp),
                    decoration: BoxDecoration(
                      color: AppColor.colorLight,
                      borderRadius: BorderRadius.circular(6.sp),
                    ),
                    child: Icon(
                      isWishListAdded ? Icons.favorite : Icons.favorite_border,
                      size: 14.sp,
                      color: AppColor.primary,
                    ),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            width: 15.sp,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 34.sp,
                ),
                Text(
                  widget.plant.name ?? "----",
                  style: AppTextStyles.bold
                      .copyWith(fontSize: 15.sp, color: AppColor.colorDark),
                ),
                SizedBox(
                  height: 5.sp,
                ),
                if (widget.plant.displaySize != null)
                  Text(
                    "${widget.plant.displaySize?.toString()} cm",
                    style: AppTextStyles.medium
                        .copyWith(fontSize: 13.sp, color: AppColor.primary),
                  ),
                SizedBox(
                  height: 15.sp,
                ),
                if (widget.plant.price != null)
                  Text(
                    "${widget.plant.price} ${widget.plant.priceUnit}",
                    style: AppTextStyles.medium
                        .copyWith(fontSize: 13.sp, color: AppColor.colorDark),
                  ),
              ],
            ),
          ),
          if (widget.plant.rating != null) ...[
            Padding(
              padding: EdgeInsets.only(top: 36.sp),
              child: Icon(
                Icons.star,
                size: 15.sp,
                color: AppColor.highlight,
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 36.sp, right: 5.sp),
                child: Text(
                  widget.plant.rating!.toStringAsFixed(1),
                  style: AppTextStyles.semiBold
                      .copyWith(fontSize: 13.sp, color: AppColor.highlight),
                ))
          ]
        ],
      ),
    );

  }
}
