import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;

  const ImageContainer({
    super.key,
    required this.imageUrl,
    required this.height,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          alignment: Alignment.bottomCenter,
          image: AssetImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
