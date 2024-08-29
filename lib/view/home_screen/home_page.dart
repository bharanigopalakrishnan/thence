import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:thence/bloc/all_plants/plants_bloc.dart';

import 'package:thence/bloc/all_plants/plants_state.dart';
import 'package:thence/bloc/plant_detail/plant_detail_bloc.dart';
import 'package:thence/bloc/plant_detail/plant_detail_event.dart';
import 'package:thence/models/plants/plant.dart';
import 'package:thence/styles/app_color.dart';
import 'package:thence/styles/app_text_style.dart';
import 'package:thence/view/home_screen/home_page_loader.dart';
import 'package:thence/view/home_screen/widgets/plant_card.dart';
import 'package:thence/view/plant_detail/plant_detail_page.dart';
import 'package:thence/widgets/banner.dart';
import 'package:thence/widgets/chip.dart';
import 'package:uni_links2/uni_links.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? selectedType;
  List<int> wishListItems = [];
  StreamSubscription? _sub;

  @override
  void initState() {
    super.initState();
    handleInitialLink();
    initDeepLinkListener(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.colorLight,
      appBar: AppBar(
        backgroundColor: AppColor.colorLight,
        title: Padding(
          padding: EdgeInsets.only(left: 5.sp),
          child: Text(
            "All plants",
            style: AppTextStyles.semiBold,
          ),
        ),
        actions: [
          Icon(
            Icons.search,
            size: 23.sp,
            color: AppColor.colorDark,
          ),
          SizedBox(
            width: 20.sp,
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20.sp, 10.sp, 20.sp, 20.sp),
            child: Text(
              "Houseplants",
              style: AppTextStyles.bold
                  .copyWith(color: AppColor.colorDark, fontSize: 26.sp),
            ),
          ),
          BlocBuilder<PlantsBloc, PlantsState>(
            builder: (context, state) {
              if (state is PlantsLoading) {
                return const HomePageLoader();
              } else if (state is PlantsLoaded) {
                return Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 20.sp,
                        ),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              "All",
                              "Succulents",
                              "In pots",
                              "Dried flowers"
                            ]
                                .map((each) => GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedType = each;
                                        });
                                      },
                                      child: ChipFilter(
                                          title: each,
                                          isSelected: selectedType == each),
                                    ))
                                .toList(),
                          ),
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.plants.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            BlocProvider.value(
                                          value: PlantDetailBloc()
                                            ..add(SetPlantDetail(
                                                state.plants[index])),
                                          child: const PlantDetailPage(),
                                        ),
                                      ),
                                    );
                                  },
                                  child: PlantCard(
                                    key: ValueKey(index),
                                    bgColor: (index % 2 == 0)
                                        ? Colors.blue.withOpacity(0.1)
                                        : AppColor.highlight.withOpacity(0.2),
                                    plant: state.plants[index],
                                  ),
                                ),
                                if ((state.plants.length > 2 && index == 1) ||
                                    ((state.plants.length < 2 &&
                                        index == (state.plants.length - 1))))
                                  const HomeBanner()
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              } else if (state is PlantsEmpty) {
                return const Expanded(child:  EmptyState());
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }

  void initDeepLinkListener(BuildContext bc) {
    _sub = uriLinkStream.listen((Uri? uri) {
      if (uri != null) {
        handleDeepLink(uri);
      }
    }, onError: (err) {
      Fluttertoast.showToast(msg: err.toString());
    });
  }

  Future<void> handleInitialLink() async {
    final initialUri = await getInitialUri();
    if (initialUri != null) {
      handleDeepLink(initialUri);
    }
  }

  void handleDeepLink(Uri uri) async {
    try {
      final pathSegments = uri.pathSegments;

      if (pathSegments.isNotEmpty &&
          pathSegments[0] == 'flutter' &&
          pathSegments[1] == 'assignment' &&
          pathSegments[2] == 'product') {
        final productId = int.parse(pathSegments[3]);
        Plant? plant;
        final plantsBloc = context.read<PlantsBloc>();
        plant = await waitTillPlantsLoaded(plantsBloc, plant, productId);
        if (plant != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BlocProvider.value(
                value: PlantDetailBloc()..add(SetPlantDetail(plant!)),
                child: const PlantDetailPage(),
              ),
            ),
          );
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Scaffold(
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
                      body: const EmptyState(),
                    )),
          );
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<Plant?> waitTillPlantsLoaded(
      PlantsBloc wishlistBloc, Plant? plant, int productId) async {
    if (wishlistBloc.state is PlantsLoading) {
      await Future.delayed(const Duration(milliseconds: 100));
      return waitTillPlantsLoaded(wishlistBloc, plant, productId);
    } else {
      if (wishlistBloc.state is PlantsLoaded) {
        if ((wishlistBloc.state as PlantsLoaded)
            .plants
            .any((each) => each.id == productId)) {
          plant = (wishlistBloc.state as PlantsLoaded)
              .plants
              .firstWhere((each) => each.id == productId);
        }
      }
    }

    return plant;
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset("assets/images/pngs/empty_state.png"),
        SizedBox(
          height: 10.sp,
        ),
        Text(
          "No Plants found",
          style: AppTextStyles.bold
              .copyWith(color: AppColor.colorDark, fontSize: 16.sp),
        )
      ],
    );
  }
}
