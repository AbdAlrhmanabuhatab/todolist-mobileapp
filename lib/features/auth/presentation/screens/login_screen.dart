/// Login screen for user authentication.
///
/// Contains email and password fields with validation, a forgot-password
/// link, and navigation to the sign-up screen. Uses [AuthProvider] for
/// state management and simulated authentication.
/// Fully responsive across all mobile screens, aspect ratios, and keyboard states.
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:todolist/core/constants/app_assets.dart';
import 'package:todolist/core/constants/app_strings.dart';
import 'package:todolist/core/extensions/context_extensions.dart';
import 'package:todolist/core/router/route_names.dart';
import 'package:todolist/core/widgets/app_primary_button.dart';
import 'package:todolist/core/widgets/app_text_field.dart';
import 'package:todolist/core/widgets/auth_navigation_link.dart';
import 'package:todolist/core/widgets/decorative_header_shape.dart';
import 'package:todolist/features/auth/presentation/providers/auth_provider.dart';

/// The login screen that authenticates existing users.
class LoginScreen extends StatefulWidget {
  /// Creates a [LoginScreen].
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = context.read<AuthProvider>();

    final success = await authProvider.login(
      _emailController.text.trim(),
      _passwordController.text,
    );

    if (!mounted) return;

    if (success) {
      Navigator.of(context).pushReplacementNamed(RouteNames.dashboard);
    } else {
      context.showSnackBar('Invalid credentials. Please try again.',
          isError: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final authProvider = context.watch<AuthProvider>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: [
                // ── Decorative shape ──
                const DecorativeHeaderShape(),

                // ── Main scrollable content ──
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
                              children: [
                                SizedBox(height: 32.h),

                                // Greeting
                                Text(
                                  '${AppStrings.welcomeBack}!',
                                  style: textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                SizedBox(height: 16.h),

                                // Responsive illustration
                                Image.asset(
                                  AppAssets.loginIllustration,
                                  height: (constraints.maxHeight * 0.22)
                                      .clamp(100.0, 180.0),
                                  fit: BoxFit.contain,
                                ),

                                SizedBox(height: 24.h),

                                // ── Login Form ──
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      AppTextField(
                                        controller: _emailController,
                                        hintText: AppStrings.email,
                                        prefixIcon: Icons.email_outlined,
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        textInputAction: TextInputAction.next,
                                        validator: _validateEmail,
                                      ),

                                      SizedBox(height: 12.h),

                                      AppTextField(
                                        controller: _passwordController,
                                        hintText: AppStrings.password,
                                        prefixIcon: Icons.lock_outline,
                                        obscureText: true,
                                        textInputAction: TextInputAction.done,
                                        onFieldSubmitted: (_) =>
                                            _handleLogin(),
                                        validator: _validatePassword,
                                      ),

                                      // Forgot Password link
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 8.h),
                                          child: InkWell(
                                            onTap: () {
                                              // Future: Navigate to forgot password screen.
                                            },
                                            borderRadius:
                                                BorderRadius.circular(4.r),
                                            child: Padding(
                                              padding: EdgeInsets.all(4.r),
                                              child: Text(
                                                AppStrings.forgotPassword,
                                                style: textTheme.bodyMedium
                                                    ?.copyWith(
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .primary,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const Spacer(),

                                SizedBox(height: 24.h),

                                // Login button (fills width cleanly)
                                AppPrimaryButton(
                                  label: AppStrings.login,
                                  isLoading: authProvider.isLoading,
                                  onPressed: _handleLogin,
                                ),

                                SizedBox(height: 16.h),

                                // Sign-up navigation
                                AuthNavigationLink(
                                  message: AppStrings.noAccount,
                                  actionText: ' ${AppStrings.clickHere}',
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushNamed(RouteNames.signup);
                                  },
                                ),

                                SizedBox(height: 20.h),
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

  // ─── Validators ──────────────────────────────────────────────────────

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}
