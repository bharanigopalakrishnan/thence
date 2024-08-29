import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  static const TextStyle base = TextStyle(
    fontFamily: 'Montserrat',
  );

  static final TextStyle regular = base.copyWith(
    fontWeight: FontWeight.w400,
    fontSize: 16.sp,
  );

  static final TextStyle medium = base.copyWith(
    fontWeight: FontWeight.w500,
    fontSize: 16.sp,
  );

  static final TextStyle semiBold = base.copyWith(
    fontWeight: FontWeight.w600,
    fontSize: 16.sp,
  );

  static final TextStyle bold = base.copyWith(
    fontWeight: FontWeight.w700,
    fontSize: 16.sp,
  );
}
