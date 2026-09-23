import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../core/theme/app_colors.dart';

class PhotoEvidenceBox extends StatelessWidget {
  final String? imagePath;
  final Function(String?) onImageSelected;

  const PhotoEvidenceBox({
    super.key,
    required this.imagePath,
    required this.onImageSelected,
  });

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    try {
      final picker = ImagePicker();
      final pickedFile = await picker.pickImage(
        source: source,
        imageQuality: 80,
      );
      if (pickedFile != null) {
        onImageSelected(pickedFile.path);
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: const Color(0xFF2E2020),
            content: Text(
              'Could not access ${source == ImageSource.camera ? 'camera' : 'gallery'}: $e',
              style: GoogleFonts.inter(color: AppColors.creamText, fontSize: 13),
            ),
          ),
        );
      }
    }
  }

  void _showImageSourcePicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF1C1C1A),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        side: BorderSide(color: Color(0xFF2E2E2A)),
      ),
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Attach Photo Evidence',
                style: GoogleFonts.fraunces(
                  color: AppColors.creamText,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.camera_alt_rounded, color: AppColors.cardGoldAccent),
                title: Text('Take Photo with Camera', style: GoogleFonts.inter(color: Colors.white)),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _pickImage(context, ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library_rounded, color: AppColors.cardGoldAccent),
                title: Text('Choose from Gallery', style: GoogleFonts.inter(color: Colors.white)),
                onTap: () {
                  Navigator.pop(sheetContext);
                  _pickImage(context, ImageSource.gallery);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (imagePath != null && imagePath!.isNotEmpty) {
      return Container(
        height: 120,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF181816),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.cardGoldAccent, width: 1.2),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            // Image Preview (tapping allows re-uploading directly)
            Positioned.fill(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _showImageSourcePicker(context),
                child: Image.file(
                  File(imagePath!),
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: const Color(0xFF222220),
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.broken_image, color: Colors.white54, size: 28),
                        const SizedBox(height: 4),
                        Text(
                          'Tap to re-upload',
                          style: GoogleFonts.inter(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Bottom bar: Tap to change / re-upload
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => _showImageSourcePicker(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  color: Colors.black.withValues(alpha: 0.65),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.camera_alt_rounded, color: AppColors.cardGoldAccent, size: 14),
                      const SizedBox(width: 6),
                      Text(
                        'Tap to change / re-upload photo',
                        style: GoogleFonts.inter(
                          color: AppColors.creamText,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Top-right Red Cross button to remove photo
            Positioned(
              top: 6,
              right: 6,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  onImageSelected(null);
                },
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.8),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF444440),
                      width: 1.0,
                    ),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.close,
                      color: AppColors.error,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return InkWell(
      onTap: () => _showImageSourcePicker(context),
      borderRadius: BorderRadius.circular(16),
      child: Container(
        height: 96,
        width: double.infinity,
        decoration: BoxDecoration(
          color: const Color(0xFF161615),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: const Color(0xFF2E2E2A),
            style: BorderStyle.solid,
            width: 1.2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.no_photography_outlined,
              color: Color(0xFF71717A),
              size: 26,
            ),
            const SizedBox(height: 8),
            Text(
              'Take/Upload photo evidence',
              style: GoogleFonts.inter(
                color: const Color(0xFF71717A),
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
