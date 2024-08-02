import 'package:flutter/material.dart';

class ImageSliderBar extends StatelessWidget {
  final Function(int) onchange;
  final int currentSlide;
  const ImageSliderBar(
      {super.key, required this.currentSlide, required this.onchange});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 220,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: PageView(
              scrollDirection: Axis.horizontal,
              allowImplicitScrolling: true,
              onPageChanged: onchange,
              physics: const ClampingScrollPhysics(),
              children: [
                Image.asset(
                  "asset/images/offer.png",
                  fit: BoxFit.fill,
                ),
                Image.asset(
                  "asset/images/Screenshot 2024-06-16 145442.png",
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  "asset/images/Screenshot 2024-06-16 150002.png",
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  "asset/images/offer.png",
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  "asset/images/offer.png",
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        ),
        Positioned.fill(
          bottom: 10,
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                5,
                (index) => AnimatedContainer(
                  duration: Duration(microseconds: 300),
                  width: currentSlide == index ? 15 : 8,
                  height: 8,
                  margin: EdgeInsets.only(right: 3),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: currentSlide == index
                          ? Colors.black
                          : Colors.transparent,
                  border: Border.all(color: Colors.black)),

                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
