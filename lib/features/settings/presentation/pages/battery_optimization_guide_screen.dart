import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';

class BatteryOptimizationGuideScreen extends StatefulWidget {
  final VoidCallback? onBack;

  const BatteryOptimizationGuideScreen({super.key, this.onBack});

  @override
  State<BatteryOptimizationGuideScreen> createState() =>
      _BatteryOptimizationGuideScreenState();
}

class _BatteryOptimizationGuideScreenState
    extends State<BatteryOptimizationGuideScreen> {
  int _selectedBrandIndex = 0;

  final List<Map<String, dynamic>> _brands = [
    {
      'name': 'Samsung',
      'version': 'One UI 5 / 6',
      'steps': [
        'Open Phone Settings -> Apps -> Eatoggy Partner.',
        'Tap on "Battery" and select "Unrestricted" (default is Optimized).',
        'Go to Settings -> Battery and device care -> Background usage limits.',
        'Add Eatoggy Partner to "Never sleeping apps".',
      ],
    },
    {
      'name': 'Xiaomi / Redmi',
      'version': 'MIUI / HyperOS',
      'steps': [
        'Open Phone Settings -> Apps -> Manage apps -> Eatoggy Partner.',
        'Enable the "Autostart" toggle switch.',
        'Scroll down to "Battery saver" and change from MIUI Battery Saver to "No restrictions".',
        'Lock Eatoggy in the Recent Apps tray by pulling down on the preview.',
      ],
    },
    {
      'name': 'Vivo / iQOO',
      'version': 'Funtouch OS',
      'steps': [
        'Open Phone Settings -> Battery -> Background power consumption management.',
        'Locate Eatoggy Partner and select "High background power consumption".',
        'Enable Autostart permissions under Apps -> Special permissions.',
      ],
    },
    {
      'name': 'Oppo / Realme',
      'version': 'ColorOS / Realme UI',
      'steps': [
        'Open Settings -> Battery -> Advanced settings -> App battery management.',
        'Select Eatoggy Partner and enable "Allow foreground activity" and "Allow background activity".',
        'Under App management, toggle "Auto launch" to ON.',
      ],
    },
    {
      'name': 'Stock Android',
      'version': 'Pixel / Moto / Nothing',
      'steps': [
        'Long press the Eatoggy app icon on home screen -> Tap (i) App info.',
        'Tap "App battery usage" -> Switch from "Optimized" to "Unrestricted".',
        'Ensure "Pause app activity if unused" is toggled OFF.',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final activeBrand = _brands[_selectedBrandIndex];

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: SafeArea(
        child: Column(
          children: [
            // Top Bar
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (widget.onBack != null) {
                        widget.onBack!();
                      } else {
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.border),
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: AppColors.textPrimary,
                          size: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      'Battery & GPS Guide',
                      style: GoogleFonts.fraunces(
                        color: AppColors.textPrimary,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Warning Alert Box
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFFDE68A)),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(
                            Icons.battery_alert_rounded,
                            color: Color(0xFFB45309),
                            size: 22,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Background Battery Restrictions Kill Orders',
                                  style: GoogleFonts.fraunces(
                                    color: const Color(0xFF92400E),
                                    fontSize: 14.5,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Phone manufacturers automatically freeze background apps. Without unrestricted battery permissions, your GPS will disconnect and you will miss incoming delivery assignments.',
                                  style: GoogleFonts.geist(
                                    color: const Color(0xFF92400E),
                                    fontSize: 12.5,
                                    height: 1.35,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Phone Brand Selector Chips
                    Text(
                      'SELECT YOUR PHONE BRAND',
                      style: GoogleFonts.geist(
                        color: AppColors.textMuted,
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      child: Row(
                        children: List.generate(_brands.length, (index) {
                          final isSelected = _selectedBrandIndex == index;
                          return Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: ChoiceChip(
                              label: Text(
                                _brands[index]['name'] as String,
                                style: GoogleFonts.geist(
                                  color: isSelected
                                      ? Colors.white
                                      : AppColors.textPrimary,
                                  fontSize: 13,
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                ),
                              ),
                              selected: isSelected,
                              selectedColor: AppColors.primary,
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                  color: isSelected
                                      ? AppColors.primary
                                      : AppColors.border,
                                ),
                              ),
                              showCheckmark: false,
                              onSelected: (_) =>
                                  setState(() => _selectedBrandIndex = index),
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Step by step guide card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '${activeBrand['name']} Instructions',
                                style: GoogleFonts.fraunces(
                                  color: AppColors.textPrimary,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF5F5F4),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  activeBrand['version'] as String,
                                  style: GoogleFonts.geist(
                                    color: AppColors.textSecondary,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          ...List.generate(
                            (activeBrand['steps'] as List<String>).length,
                            (index) {
                              final step = (activeBrand['steps'] as List<String>)[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 14),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 24,
                                      height: 24,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFFFF1F2),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: const Color(0xFFFECACA),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${index + 1}',
                                          style: GoogleFonts.geist(
                                            color: AppColors.primary,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Text(
                                        step,
                                        style: GoogleFonts.geist(
                                          color: AppColors.textPrimary,
                                          fontSize: 13.5,
                                          height: 1.4,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Floating App Permission Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.border),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              color: const Color(0xFFDCFCE7),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.picture_in_picture_alt_rounded,
                              color: Color(0xFF15803D),
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Draw Over Other Apps',
                                  style: GoogleFonts.fraunces(
                                    color: AppColors.textPrimary,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Allows floating order radar while navigating with Google Maps',
                                  style: GoogleFonts.geist(
                                    color: AppColors.textSecondary,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Primary Action Button
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Navigating to Device App Settings...',
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          'Open Device App Settings',
                          style: GoogleFonts.geist(
                            fontSize: 15.5,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
