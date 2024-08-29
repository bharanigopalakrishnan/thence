import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thence/bloc/all_plants/plants_bloc.dart';
import 'package:thence/bloc/all_plants/plants_event.dart';
import 'package:thence/bloc/plant_detail/plant_detail_bloc.dart';
import 'package:thence/bloc/plant_detail/plant_detail_state.dart';
import 'package:thence/bloc/wishlist/wishlist_bloc.dart';
import 'package:thence/bloc/wishlist/wishlist_event.dart';
import 'package:thence/bloc/wishlist/wishlist_state.dart';
import 'package:thence/styles/app_color.dart';
import 'package:thence/styles/app_text_style.dart';
import 'package:thence/widgets/chip.dart';
import 'package:thence/widgets/loader.dart';

class PlantDetailPage extends StatefulWidget {
  const PlantDetailPage({super.key});

  @override
  State<PlantDetailPage> createState() => _PlantDetailPageState();
}

class _PlantDetailPageState extends State<PlantDetailPage> {
  late PlantDetailBloc _plantDetailBloc;
  int? selectedSize;
  late WishlistBloc wishlistBloc;
  bool isWishListAdded = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    wishlistBloc = context.read<WishlistBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            size: 24.sp,
          ),
        ),
      ),
      bottomNavigationBar: bottomBar(),
      body: BlocBuilder<PlantDetailBloc, PlantDetailState>(
        builder: (context, state) {
          if (state is PlantDetailLoaded) {
            return ListView(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: InteractiveViewer(
                    child: CachedNetworkImage(
                      imageUrl: state.plantDetail.imageUrl ?? "",
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ),
                SizedBox(
                  height: 30.sp,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          state.plantDetail.name ?? "----",
                          style: AppTextStyles.bold.copyWith(
                              color: AppColor.colorDark, fontSize: 24.sp),
                        ),
                      ),
                      Text(
                        "${state.plantDetail.price}${state.plantDetail.priceUnit}",
                        style: AppTextStyles.medium.copyWith(
                            fontSize: 16.sp, color: AppColor.colorDark),
                      )
                    ],
                  ),
                ),
                if (state.plantDetail.rating != null) ...[
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(top: 10.sp, left: 20.sp),
                        child: Icon(
                          Icons.star,
                          size: 15.sp,
                          color: AppColor.highlight,
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(top: 10.sp, left: 5.sp),
                          child: Text(
                            state.plantDetail.rating!.toStringAsFixed(1),
                            style: AppTextStyles.semiBold.copyWith(
                                fontSize: 13.sp, color: AppColor.highlight),
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
                    child: Text(
                      "Choose size",
                      style: AppTextStyles.semiBold
                          .copyWith(fontSize: 13.sp, color: AppColor.colorDark),
                    ),
                  ),
                  SizedBox(
                    height: 10.sp,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20.sp,
                    ),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: state.plantDetail.availableSize!
                            .map((each) => GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedSize = each;
                                  });
                                },
                                child: ChipFilter(
                                    title: "$each cm",
                                    isSelected: selectedSize == each)))
                            .toList(),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20.sp,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
                    child: Text(
                      "Description",
                      style: AppTextStyles.semiBold
                          .copyWith(fontSize: 13.sp, color: AppColor.colorDark),
                    ),
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20.sp, right: 20.sp),
                    child: Text(
                      state.plantDetail.description ?? "",
                      style: AppTextStyles.medium
                          .copyWith(fontSize: 13.sp, color: AppColor.primary),
                    ),
                  ),
                ]
              ],
            );
          } else {
            return const Loader();
          }
        },
      ),
    );
  }

  Widget bottomBar() {
    return BlocBuilder<PlantDetailBloc, PlantDetailState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(
              left: 20.sp, right: 20.sp, bottom: 20.sp, top: 20.sp),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  HapticFeedback.lightImpact();
                  wishlistBloc.add(AddOrRemovePlant(
                      (state as PlantDetailLoaded).plantDetail.id!));
                  context.read<PlantsBloc>().add(FetchPlants());
                  setState(() {});
                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.sp),
                      color: AppColor.shimmerColor),
                  padding: EdgeInsets.all(12.sp),
                  child: Icon(
                    (state is PlantDetailLoaded &&
                            (wishlistBloc.state as WishListLoaded)
                                .wishList
                                .contains(state.plantDetail.id))
                        ? Icons.favorite
                        : Icons.favorite_border,
                    size: 25.sp,
                    color: AppColor.colorDark,
                  ),
                ),
              ),
              SizedBox(
                width: 40.sp,
              ),
              Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.circular(16.sp)),
                    padding: EdgeInsets.only(top: 17.sp, bottom: 17.sp),
                    child: Text(
                      "Add to cart",
                      textAlign: TextAlign.center,
                      style: AppTextStyles.semiBold.copyWith(
                          color: AppColor.colorLight, fontSize: 13.sp),
                    ),
                  ))
            ],
          ),
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _plantDetailBloc = BlocProvider.of<PlantDetailBloc>(context);
  }

  @override
  void dispose() {
    _plantDetailBloc.close();
    super.dispose();
  }
}
