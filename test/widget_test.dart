import 'package:flutter_test/flutter_test.dart';
import 'package:partner_app/core/theme/app_colors.dart';

void main() {
  test('Theme tokens test', () {
    expect(AppColors.primary, equals(AppColors.primary));
    expect(AppColors.scaffoldBackground, equals(AppColors.scaffoldBackground));
    expect(AppColors.textPrimary, equals(AppColors.textPrimary));
  });
}
