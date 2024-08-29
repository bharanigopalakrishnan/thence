import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thence/styles/app_color.dart';
import 'package:thence/styles/app_text_style.dart';

class ChipFilter extends StatelessWidget {
  final String title;
  final bool isSelected;
  const ChipFilter({super.key, required this.title, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 15.sp),
      padding: EdgeInsets.all(10.sp),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.sp),
        color: isSelected?AppColor.primary:AppColor.shimmerColor
      ),
      child: Text(title,style: AppTextStyles.semiBold.copyWith(
        color: isSelected?AppColor.colorLight:AppColor.primary,
        fontSize: 13.sp
      ),),
    );
  }
}