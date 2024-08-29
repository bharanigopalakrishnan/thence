import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:thence/styles/app_color.dart';
import 'package:thence/widgets/placeholders.dart';

class HomePageLoader extends StatelessWidget {
  const HomePageLoader({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: AppColor.shimmerColor,
        highlightColor: AppColor.shimmerColor.withOpacity(0.2),
        enabled: true,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 15.sp,
                  ),
                  ChipPlaceHolder(
                    width: 50.sp,
                  ),
                  ChipPlaceHolder(
                    width: 95.sp,
                  ),
                  ChipPlaceHolder(
                    width: 85.sp,
                  ),
                  Expanded(
                    child: ChipPlaceHolder(
                      width: 0.sp,
                    ),
                  )
                ],
              ),
              const SizedBox(height: 16.0),
              ContentPlaceholder(
                lineType: ContentLineType.combined,
                bannerWidth: 124.sp,
                bannerHeight: 180.sp,
              ),
              const SizedBox(height: 16.0),
              ContentPlaceholder(
                bannerWidth: 124.sp,
                bannerHeight: 103.sp,
                lineType: ContentLineType.single,
              ),
              SizedBox(height: 16.sp),
              ContentPlaceholder(
                bannerWidth: 124.sp,
                bannerHeight: 103.sp,
                lineType: ContentLineType.single,
              ),
              SizedBox(height: 16.sp),
              ContentPlaceholder(
                bannerWidth: 124.sp,
                bannerHeight: 103.sp,
                lineType: ContentLineType.single,
              ),
            ],
          ),
        ));
  }
}
