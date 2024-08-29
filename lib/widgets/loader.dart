import 'package:flutter/material.dart';
import 'package:thence/styles/app_color.dart';

class Loader extends StatelessWidget {
  final Color? color;
  const Loader({super.key, this.color});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: color ?? AppColor.primary,
    );
  }
}
