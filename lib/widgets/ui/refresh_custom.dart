import 'package:consulin_mobile_dev/app/constants/color.dart';
import 'package:flutter/material.dart';

class CustomRefreshIndicator extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget child;
  final Color color;
  final Color backgroundColor;

  const CustomRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.child,
    this.color = primaryColor, // Warna default
    this.backgroundColor = Colors.white, // Warna background default
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: color,
      backgroundColor: backgroundColor,
      onRefresh: onRefresh,
      child: child,
    );
  }
}
