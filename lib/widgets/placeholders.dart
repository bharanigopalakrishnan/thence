import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thence/styles/app_color.dart';

class ChipPlaceHolder extends StatelessWidget {
  final double width;

  const ChipPlaceHolder({
    Key? key,
    required this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: AppColor.colorLight,
          borderRadius: BorderRadius.circular(8.sp)),
      width: width,
      height: 30.sp,
      margin: EdgeInsets.only(right: 15.sp),
    );
  }
}

enum ContentLineType {
  combined,
  single,
}

class ContentPlaceholder extends StatelessWidget {
  final double bannerHeight;
  final double bannerWidth;

  final ContentLineType lineType;

  const ContentPlaceholder({
    Key? key,
    required this.lineType,
    required this.bannerHeight,
    required this.bannerWidth,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: bannerWidth,
            height: bannerHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.sp),
              color: AppColor.colorLight,
            ),
          ),
          SizedBox(width: 12.sp),
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                contentSection(),
                if (lineType == ContentLineType.combined) ...[contentSection()]
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget contentSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
              color: AppColor.colorLight,
              borderRadius: BorderRadius.circular(8.sp)),
          width: double.infinity,
          height: 15.sp,
          margin: EdgeInsets.only(bottom: 8.sp),
        ),
        Container(
          decoration: BoxDecoration(
              color: AppColor.colorLight,
              borderRadius: BorderRadius.circular(8.sp)),
          width: 43.sp,
          height: 15.sp,
          margin: EdgeInsets.only(bottom: 14.sp),
        ),
        Container(
          decoration: BoxDecoration(
              color: AppColor.colorLight,
              borderRadius: BorderRadius.circular(8.sp)),
          width: 43.sp,
          height: 15.sp,
          margin: EdgeInsets.only(bottom: 8.sp),
        ),
      ],
    );
  }
}
