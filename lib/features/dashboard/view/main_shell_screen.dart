import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_colors.dart';
import '../bloc/navigation_bloc.dart';
import '../../home/presentation/pages/home_screen.dart';
import '../../deliveries/presentation/pages/deliveries_screen.dart';
import '../../earnings/presentation/pages/earnings_screen.dart';
import '../../profile/presentation/pages/profile_screen.dart';

class MainShellScreen extends StatelessWidget {
  final VoidCallback onLogout;

  const MainShellScreen({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NavigationBloc(),
      child: MainShellView(onLogout: onLogout),
    );
  }
}

class MainShellView extends StatelessWidget {
  final VoidCallback onLogout;

  const MainShellView({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {

    const goldColor = Color(0xFFE5A64E);
    const unselectedColor = Color(0xFF8E8E93);
    const navBgColor = Color(0xFF0E0E10);

    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        final currentIndex = state.tabIndex;

        final List<Widget> pages = [
          const HomeScreen(),
          DeliveriesScreen(key: ValueKey('deliveries_tab_$currentIndex')),
          const EarningsScreen(),
          ProfileScreen(onLogout: onLogout),
        ];

        return Scaffold(
          backgroundColor: AppColors.darkBackground,
          body: SafeArea(
            child: IndexedStack(
              index: currentIndex,
              children: pages,
            ),
          ),
          bottomNavigationBar: Container(
            color: navBgColor,
            child: SafeArea(
              top: false,
              child: Container(
                height: 62,
                decoration: const BoxDecoration(
                  color: navBgColor,
                  border: Border(
                    top: BorderSide(
                      color: Color(0xFF202022),
                      width: 0.8,
                    ),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(
                      context: context,
                      index: 0,
                      currentIndex: currentIndex,
                      label: 'Dashboard',
                      icon: Icons.grid_view_rounded,
                      activeIcon: Icons.grid_view_rounded,
                      goldColor: goldColor,
                      unselectedColor: unselectedColor,
                    ),
                    _buildNavItem(
                      context: context,
                      index: 1,
                      currentIndex: currentIndex,
                      label: 'Deliveries',
                      icon: Icons.local_shipping_outlined,
                      activeIcon: Icons.local_shipping_rounded,
                      goldColor: goldColor,
                      unselectedColor: unselectedColor,
                    ),
                    _buildNavItem(
                      context: context,
                      index: 2,
                      currentIndex: currentIndex,
                      label: 'Earnings',
                      icon: Icons.trending_up_rounded,
                      activeIcon: Icons.trending_up_rounded,
                      goldColor: goldColor,
                      unselectedColor: unselectedColor,
                    ),
                    _buildNavItem(
                      context: context,
                      index: 3,
                      currentIndex: currentIndex,
                      label: 'Profile',
                      icon: Icons.person_outline_rounded,
                      activeIcon: Icons.person_rounded,
                      goldColor: goldColor,
                      unselectedColor: unselectedColor,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required int index,
    required int currentIndex,
    required String label,
    required IconData icon,
    required IconData activeIcon,
    required Color goldColor,
    required Color unselectedColor,
  }) {
    final isSelected = currentIndex == index;
    final color = isSelected ? goldColor : unselectedColor;

    return InkWell(
      onTap: () => context.read<NavigationBloc>().add(TabChanged(index)),
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isSelected ? activeIcon : icon,
            color: color,
            size: 24,
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 11.5,
              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}


