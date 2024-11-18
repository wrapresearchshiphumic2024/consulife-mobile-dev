import 'package:consulin_mobile_dev/app/constants/color.dart';
import 'package:flutter/material.dart';
import 'image_container.dart'; // Pastikan ini adalah import yang benar untuk ImageContainer
import 'package:consulin_mobile_dev/app/models/onboard.dart';

class SliderWidget extends StatelessWidget {
  final PageController pageController;
  final List<OnBoard> onboard;
  final int pageIndex;
  final double height;
  final double width;
  final Function(int index) onChange;

  const SliderWidget({
    super.key,
    required this.pageController,
    required this.onboard,
    required this.pageIndex,
    required this.height,
    required this.width,
    required this.onChange,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.82, // Slider mengambil 60% dari tinggi layar
      child: PageView.builder(
        controller: pageController,
        itemCount: onboard.length,
        scrollDirection: Axis.horizontal,
        onPageChanged: onChange,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ImageContainer(
                  imageUrl: onboard[index].image,
                  height:
                      height / 1.78, // Gambar mengambil 40% dari tinggi layar
                  width: width,
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  onboard[index].title.toUpperCase(),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height:
                      height / 10, // Deskripsi mengambil 10% dari tinggi layar
                  child: Text(
                    onboard[index].description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: textColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
