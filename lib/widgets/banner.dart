import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thence/styles/app_color.dart';
import 'package:thence/styles/app_text_style.dart';

class HomeBanner extends StatelessWidget {
  const HomeBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            padding: EdgeInsets.only(left: 30.sp, top: 15.sp),
            width: double.infinity,
            margin: EdgeInsets.only(left: 15.sp, right: 15.sp, top: 30.sp),
            height: 85.sp,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.sp),
                gradient: const LinearGradient(colors: [
                  Color(0xffDCEEFF),
                  Color(0xffFFE6CF),
                ])),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Free shipping",
                  style: AppTextStyles.bold
                      .copyWith(color: AppColor.colorDark, fontSize: 14.sp),
                ),
                SizedBox(
                  height: 4.sp,
                ),
                Row(
                  children: [
                    Text(
                      "on orders",
                      style: AppTextStyles.medium
                          .copyWith(color: AppColor.primary, fontSize: 13.sp),
                    ),
                    Container(
                      padding: EdgeInsets.all(1.sp),
                      margin:  EdgeInsets.only(left: 2.sp),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4.sp),
                        color: const Color(0xffFFC37C),
                      ),
                      child: Text(
                        ' over \$100',
                        style: AppTextStyles.medium.copyWith(
                            color: AppColor.colorLight, fontSize: 13.sp),
                      ),
                    )
                  ],
                )
              ],
            )),
        Positioned(
          right: 50.sp,
          bottom: 0.sp,
          child: Image.asset(
            "assets/images/pngs/Saly-3.png",
            scale: 2,
          ),
        )
      ],
    );
  }
}
