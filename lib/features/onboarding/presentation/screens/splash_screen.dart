/// Splash / onboarding screen — the first screen users see.
///
/// Displays the app illustration, a motivational headline, and a
/// call-to-action button that navigates to the login screen.
/// Fully responsive across all device sizes and orientations.
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:todolist/core/constants/app_assets.dart';
import 'package:todolist/core/constants/app_strings.dart';
import 'package:todolist/core/router/route_names.dart';
import 'package:todolist/core/widgets/app_primary_button.dart';
import 'package:todolist/core/widgets/decorative_header_shape.dart';

/// The initial onboarding screen shown on app launch.
class SplashScreen extends StatelessWidget {
  /// Creates a [SplashScreen].
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                // ── Decorative shape at top-left ──
                const DecorativeHeaderShape(),

                // ── Scrollable adaptive content ──
                SingleChildScrollView(
                  physics: const ClampingScrollPhysics(),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                      minWidth: constraints.maxWidth,
                    ),
                    child: IntrinsicHeight(
                      child: Center(
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(maxWidth: 480),
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 24.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Spacer(flex: 2),

                                // Illustration
                                Image.asset(
                                  AppAssets.onboarding,
                                  width: 180.w,
                                  height: (constraints.maxHeight * 0.26)
                                      .clamp(120.0, 200.0),
                                  fit: BoxFit.contain,
                                ),

                                const Spacer(flex: 1),

                                // Headline
                                Text(
                                  AppStrings.splashTitle,
                                  style: textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.center,
                                ),

                                SizedBox(height: 16.h),

                                // Description
                                ConstrainedBox(
                                  constraints: BoxConstraints(maxWidth: 300.w),
                                  child: Text(
                                    AppStrings.splashDescription,
                                    style: textTheme.bodyMedium,
                                    textAlign: TextAlign.center,
                                  ),
                                ),

                                const Spacer(flex: 2),

                                // CTA Button
                                AppPrimaryButton(
                                  label: AppStrings.getStarted,
                                  onPressed: () {
                                    Navigator.of(context).pushReplacementNamed(
                                      RouteNames.login,
                                    );
                                  },
                                ),

                                SizedBox(height: 24.h),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
