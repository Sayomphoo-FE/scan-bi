import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

class ProgressBarWidget extends StatelessWidget {
  final double greenFlex;
  final double redFlex;

  const ProgressBarWidget({
    super.key,
    required this.greenFlex,
    required this.redFlex,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 600),
      tween: Tween<double>(begin: redFlex == 0 ? 0 : 0.5, end: redFlex),
      curve: Curves.easeInOut,
      builder: (context, animatedRedFlex, _) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            height: 14,
            child: Row(
              children: [
                Flexible(
                  flex: (greenFlex * 1000).toInt(),
                  child: Container(color: AppColors.progressGreen),
                ),
                if (animatedRedFlex > 0) ...[
                  const SizedBox(width: 2),
                  Flexible(
                    flex: (animatedRedFlex * 1000).toInt(),
                    child: Container(color: AppColors.progressRed),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
