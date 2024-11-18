import 'package:consulin_mobile_dev/app/constants/color.dart';
import 'package:flutter/material.dart';

class DotIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;

  const DotIndicator({
    super.key,
    required this.itemCount,
    required this.currentIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: 10,
          width: 10,
          margin: const EdgeInsets.symmetric(horizontal: 5),
          decoration: BoxDecoration(
            color:
                currentIndex == index ? primaryColor : const Color(0xffE7E8EB),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ),
    );
  }
}
