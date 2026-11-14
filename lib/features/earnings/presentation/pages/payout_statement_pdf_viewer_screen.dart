import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../core/theme/app_colors.dart';

class PayoutStatementPdfViewerScreen extends StatelessWidget {
  final String statementId;
  final String period;
  final double netAmount;
  final String utrNumber;
  final VoidCallback? onBack;

  const PayoutStatementPdfViewerScreen({
    super.key,
    this.statementId = '#STM-2025-W41',
    this.period = '06 Oct 2025 – 12 Oct 2025',
    this.netAmount = 2994.10,
    this.utrNumber = 'HDFC902817281920',
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
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
                      if (onBack != null) {
                        onBack!();
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
                      'Weekly Pay Statement',
                      style: GoogleFonts.fraunces(
                        color: AppColors.textPrimary,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.share_outlined,
                      color: AppColors.textPrimary,
                    ),
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Sharing Pay Statement PDF...'),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),

            // Scrollable PDF Preview Document
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  children: [
                    // Official Invoice Document Sheet
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(22),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: AppColors.border),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 14,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Document Header
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'EATOGGY FLEET',
                                    style: GoogleFonts.fraunces(
                                      color: AppColors.primary,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Partner Settlement Voucher',
                                    style: GoogleFonts.geist(
                                      color: AppColors.textSecondary,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFDCFCE7),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'PROCESSED',
                                  style: GoogleFonts.geist(
                                    color: const Color(0xFF15803D),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                    letterSpacing: 0.6,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 24, color: AppColors.border),

                          // Partner Metadata
                          _buildVoucherRow('Statement ID', statementId),
                          const SizedBox(height: 6),
                          _buildVoucherRow('Settlement Cycle', period),
                          const SizedBox(height: 6),
                          _buildVoucherRow('Partner', 'Kabir Singh (#EG-992)'),
                          const SizedBox(height: 6),
                          _buildVoucherRow('Bank Account', 'HDFC Bank (*** 9012)'),
                          const SizedBox(height: 6),
                          _buildVoucherRow('Bank Reference UTR', utrNumber),
                          const Divider(height: 24, color: AppColors.border),

                          // Earnings Section
                          Text(
                            'GROSS EARNINGS BREAKDOWN',
                            style: GoogleFonts.geist(
                              color: AppColors.textMuted,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.8,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buildLineItem('Base Delivery Fare (42 Orders)', '₹3,570.00'),
                          const SizedBox(height: 6),
                          _buildLineItem('Peak & Weather Surge Pay', '₹630.00'),
                          const SizedBox(height: 6),
                          _buildLineItem('Customer In-App Tips (100% Passed)', '₹240.00'),
                          const SizedBox(height: 6),
                          _buildLineItem('Target Milestone & Quest Bonuses', '₹450.00'),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Gross Earnings',
                                style: GoogleFonts.geist(
                                  color: AppColors.textPrimary,
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                '₹4,890.00',
                                style: GoogleFonts.geist(
                                  color: AppColors.textPrimary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          const Divider(height: 24, color: AppColors.border),

                          // Deductions & Adjustments
                          Text(
                            'DEDUCTIONS & ADJUSTMENTS',
                            style: GoogleFonts.geist(
                              color: AppColors.textMuted,
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.8,
                            ),
                          ),
                          const SizedBox(height: 10),
                          _buildLineItem('COD Cash in Hand Adjusted', '- ₹1,847.00', isDeduction: true),
                          const SizedBox(height: 6),
                          _buildLineItem('TDS Tax Deduction (1% Sec 194-O)', '- ₹48.90', isDeduction: true),
                          const SizedBox(height: 6),
                          _buildLineItem('Order Cancellation Penalties', '₹0.00'),
                          const Divider(height: 24, color: AppColors.border),

                          // Final Net Amount Transferred
                          Container(
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFAF7F2),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(color: AppColors.border),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'NET BANK TRANSFER',
                                      style: GoogleFonts.geist(
                                        color: AppColors.textMuted,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w700,
                                        letterSpacing: 0.8,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      'Transferred to HDFC',
                                      style: GoogleFonts.geist(
                                        color: AppColors.textSecondary,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  '₹${netAmount.toStringAsFixed(2)}',
                                  style: GoogleFonts.fraunces(
                                    color: const Color(0xFF15803D),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Action Buttons
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Downloading official PDF statement & TDS certificate...'),
                              backgroundColor: Color(0xFF16A34A),
                            ),
                          );
                        },
                        icon: const Icon(Icons.download_rounded, color: Colors.white, size: 20),
                        label: Text(
                          'Download PDF Statement',
                          style: GoogleFonts.geist(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    OutlinedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Discrepancy ticket #DIS-891 created for Fleet Accounts team.'),
                          ),
                        );
                      },
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        side: const BorderSide(color: AppColors.border),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Report Settlement Discrepancy',
                          style: GoogleFonts.geist(
                            color: AppColors.textSecondary,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
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

  Widget _buildVoucherRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.geist(
            color: AppColors.textSecondary,
            fontSize: 12.5,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.geist(
            color: AppColors.textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildLineItem(String item, String amount, {bool isDeduction = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          item,
          style: GoogleFonts.geist(
            color: AppColors.textSecondary,
            fontSize: 13,
          ),
        ),
        Text(
          amount,
          style: GoogleFonts.geist(
            color: isDeduction ? AppColors.primary : AppColors.textPrimary,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
