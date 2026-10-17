import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';
import '../../../core/theme/app_colors.dart';
import '../bloc/splash_bloc.dart';

class SplashScreen extends StatelessWidget {
  final VoidCallback onFinish;

  const SplashScreen({super.key, required this.onFinish});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(const SplashStarted()),
      child: SplashView(onFinish: onFinish),
    );
  }
}

class SplashView extends StatefulWidget {
  final VoidCallback onFinish;

  const SplashView({super.key, required this.onFinish});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _scaleAnimation = Tween<double>(
      begin: 0.85,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textPrimary = AppColors.textPrimary;
    final textSecondary = AppColors.textSecondary;
    const bgColor = AppColors.background;

    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state is SplashCompleted) {
          widget.onFinish();
        }
      },
      child: Scaffold(
        backgroundColor: bgColor,
        body: Stack(
          children: [
            // Soft Radial Pinkish-Red Glow in Center matching d01-splash.svg
            Center(
              child: Container(
                width: 80.w,
                height: 80.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [
                      AppColors.primaryGlow.withValues(alpha: 0.6),
                      AppColors.primaryGlow.withValues(alpha: 0.2),
                      Colors.transparent,
                    ],
                    stops: const [0.0, 0.55, 1.0],
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Center(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _fadeAnimation,
                      child: ScaleTransition(
                        scale: _scaleAnimation,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Center Logo Icon & EATOGGY Text Row
                            Container(
                              width: 48.w,
                              height: 48.w,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/logo.png',
                                  fit: BoxFit.contain,
                                  errorBuilder:
                                      (context, error, stackTrace) =>
                                          Container(
                                            color: AppColors.primaryLight,
                                            child: const Icon(
                                              Icons.restaurant,
                                              color: AppColors.primary,
                                              size: 40,
                                            ),
                                          ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Subtitles (DELIVERY PARTNER & Luxurious Gourmet Logistics)
                            Column(
                              children: [
                                Text(
                                  'DELIVERY PARTNER',
                                  style: GoogleFonts.geist(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w700,
                                    color: textPrimary,
                                    letterSpacing: 2.2,
                                  ),
                                ),
                                SizedBox(height: 0.8.h),
                                Text(
                                  'Luxurious Gourmet Logistics',
                                  style: GoogleFonts.geist(
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w400,
                                    color: textSecondary,
                                    letterSpacing: 0.6,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4.h),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            // Bottom indicator pill matching d01-splash.svg
            Positioned(
              bottom: 16,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 140,
                  height: 5,
                  decoration: BoxDecoration(
                    color: AppColors.borderMedium.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(2.5),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
