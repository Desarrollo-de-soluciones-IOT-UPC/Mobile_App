import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class EmsafePageIndicator extends StatelessWidget {
  const EmsafePageIndicator({
    super.key,
    required this.count,
    required this.activeIndex,
    this.onTap,
  });

  final int count;
  final int activeIndex;
  final ValueChanged<int>? onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(count, (index) {
          final active = index == activeIndex;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: InkWell(
              onTap: onTap == null ? null : () => onTap!(index),
              borderRadius: BorderRadius.circular(99),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
                width: active ? 28 : 9,
                height: 7,
                decoration: BoxDecoration(
                  color: active
                      ? AppTheme.primaryBlue
                      : Colors.white.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(99),
                  boxShadow: active
                      ? [
                          BoxShadow(
                            color: AppTheme.primaryBlue.withValues(alpha: 0.35),
                            blurRadius: 10,
                          ),
                        ]
                      : null,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
