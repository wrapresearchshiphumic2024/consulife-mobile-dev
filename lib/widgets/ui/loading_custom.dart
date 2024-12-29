import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingCustom extends StatelessWidget {
  const LoadingCustom({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.progressiveDots(
        color: Colors.black,
        size: 50,
      ),
    );
  }
}
