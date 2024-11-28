import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BannerSlider extends StatefulWidget {
  const BannerSlider({super.key});

  @override
  State<BannerSlider> createState() => _BannerSliderState();
}

class _BannerSliderState extends State<BannerSlider> {
  PageController sliderController = PageController();
  List<String> bannersList = [
    '../../assets/images/banner1.webp',
    '../../assets/images/banner2.webp',
    '../../assets/images/banner3.webp',
    '../../assets/images/banner4.webp'
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PageView.builder(
            controller: sliderController,
            itemCount: bannersList.length,
            itemBuilder: (context, position) {
              return bannerItem(bannersList[position]);
            }),
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: SmoothPageIndicator(
            controller: sliderController,
            count: bannersList.length,
            effect: const ExpandingDotsEffect(
                dotHeight: 10,
                dotWidth: 10,
                dotColor: Colors.grey,
                activeDotColor: Colors.redAccent),
            onDotClicked: (index) => {
              sliderController.animateToPage(index,
                  duration: const Duration(milliseconds: 240),
                  curve: Curves.easeInOut)
            },
          ),
        )
      ],
    );
  }
}

Padding bannerItem(item) {
  return Padding(
      padding: const EdgeInsets.all(10),
      child: Image(
        image: AssetImage(item),
        height: 400,
        width: 430,
      ));
}
