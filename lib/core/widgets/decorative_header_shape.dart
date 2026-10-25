/// A decorative shape overlay positioned at the top-left of screens.
///
/// This widget renders the decorative header shape offset above and to
/// the left of its parent [Stack], producing the characteristic curved
/// accent that appears on the splash, login, signup, and dashboard screens.
///
/// Must be placed inside a [Stack] to honour the [Positioned] layout.
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todolist/core/constants/app_assets.dart';

/// A positioned image decoration for screen headers.
class DecorativeHeaderShape extends StatelessWidget {
  /// Creates a [DecorativeHeaderShape].
  ///
  /// [backgroundColor] optionally fills a container behind the shape.
  const DecorativeHeaderShape({
    super.key,
    this.backgroundColor,
  });

  /// Optional background colour rendered behind the decorative image.
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: -60.h,
      left: -60.w,
      child: IgnorePointer(
        child: Container(
          color: backgroundColor,
          child: Image.asset(
            AppAssets.shape,
            width: 240.w,
            height: 220.h,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
