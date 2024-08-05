import 'dart:async';
import 'package:flutter/material.dart';

class ImageSliderBar extends StatefulWidget {
  final Function(int) onchange;
  final int currentSlide;

  const ImageSliderBar({
    Key? key,
    required this.currentSlide,
    required this.onchange,
  }) : super(key: key);

  @override
  _ImageSliderBarState createState() => _ImageSliderBarState();
}

class _ImageSliderBarState extends State<ImageSliderBar> {
  late PageController _pageController;
  late Timer _timer;
  int _currentPage = 0;
  final int _autoSlideDuration = 3; // Duration in seconds

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _timer = Timer.periodic(Duration(seconds: _autoSlideDuration), (timer) {
      _currentPage = (_currentPage + 1) % 5; // Number of images
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      widget.onchange(_currentPage);
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

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
              controller: _pageController,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
                widget.onchange(index);
              },
              physics: const ClampingScrollPhysics(),
              children: [
                Image.asset(
                  "asset/images/offer.png",
                  fit: BoxFit.cover,
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
                5, // Number of images
                    (index) => AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: _currentPage == index ? 15 : 8,
                  height: 8,
                  margin: EdgeInsets.only(right: 3),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: _currentPage == index
                        ? Colors.black
                        : Colors.transparent,
                    border: Border.all(color: Colors.black),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
