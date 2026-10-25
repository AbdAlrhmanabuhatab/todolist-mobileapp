/// Sign-up screen for new user registration.
///
/// Contains fields for full name, email, password, and confirm password
/// with comprehensive validation. Uses [AuthProvider] for state management.
/// Fully responsive across all screen sizes and keyboard states.
library;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'package:todolist/core/constants/app_strings.dart';
import 'package:todolist/core/extensions/context_extensions.dart';
import 'package:todolist/core/router/route_names.dart';
import 'package:todolist/core/widgets/app_primary_button.dart';
import 'package:todolist/core/widgets/app_text_field.dart';
import 'package:todolist/core/widgets/auth_navigation_link.dart';
import 'package:todolist/core/widgets/decorative_header_shape.dart';
import 'package:todolist/features/auth/presentation/providers/auth_provider.dart';

/// The registration screen for creating a new account.
class SignUpScreen extends StatefulWidget {
  /// Creates a [SignUpScreen].
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = context.read<AuthProvider>();

    final success = await authProvider.register(
      _nameController.text.trim(),
      _emailController.text.trim(),
      _passwordController.text,
    );

    if (!mounted) return;

    if (success) {
      Navigator.of(context).pushReplacementNamed(RouteNames.dashboard);
    } else {
      context.showSnackBar('Registration failed. Please try again.',
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
                                SizedBox(height: 36.h),

                                // Greeting
                                Text(
                                  '${AppStrings.welcomeOnboard}!',
                                  style: textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                SizedBox(height: 8.h),

                                Text(
                                  AppStrings.signUpSubtitle,
                                  style: textTheme.bodyMedium,
                                ),

                                SizedBox(height: 32.h),

                                // ── Registration Form ──
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      AppTextField(
                                        controller: _nameController,
                                        hintText: AppStrings.fullName,
                                        textInputAction: TextInputAction.next,
                                        validator: _validateName,
                                      ),

                                      SizedBox(height: 12.h),

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
                                        textInputAction: TextInputAction.next,
                                        validator: _validatePassword,
                                      ),

                                      SizedBox(height: 12.h),

                                      AppTextField(
                                        controller:
                                            _confirmPasswordController,
                                        hintText: AppStrings.confirmPassword,
                                        prefixIcon: Icons.lock_outline,
                                        obscureText: true,
                                        textInputAction: TextInputAction.done,
                                        onFieldSubmitted: (_) =>
                                            _handleRegister(),
                                        validator: _validateConfirmPassword,
                                      ),
                                    ],
                                  ),
                                ),

                                const Spacer(),

                                SizedBox(height: 28.h),

                                // Register button
                                AppPrimaryButton(
                                  label: AppStrings.register,
                                  isLoading: authProvider.isLoading,
                                  onPressed: _handleRegister,
                                ),

                                SizedBox(height: 16.h),

                                // Login navigation
                                AuthNavigationLink(
                                  message: '${AppStrings.haveAccount} ',
                                  actionText: AppStrings.signIn,
                                  onTap: () {
                                    Navigator.of(context)
                                        .pushReplacementNamed(
                                      RouteNames.login,
                                    );
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

  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your full name';
    }
    return null;
  }

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
      return 'Please enter a password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != _passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }
}
