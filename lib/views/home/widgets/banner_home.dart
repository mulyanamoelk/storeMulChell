import 'package:elektroku/shared/constants/themes.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BannerHome extends StatefulWidget {
  const BannerHome({super.key});

  @override
  State<BannerHome> createState() => _BannerHomeState();
}

class _BannerHomeState extends State<BannerHome> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 10.0,
      ),
      height: 175.0,
      width: MediaQuery.of(context).size.width,
      child: CarouselSlider.builder(
        itemCount: 4,
        itemBuilder: (context, index, realIndex) {
          return Container(
            padding: const EdgeInsets.only(
              left: 10.0,
            ),
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.symmetric(horizontal: 5.0),
            decoration: const BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Apple Store",
                          style: ThemesFonts.Font22WhiteBold),
                      const Text(
                        "Find the Apple Product and\naccesories You're looking for",
                        style: ThemesFonts.Font13White,
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: whiteColor,
                          foregroundColor: secondaryColor,
                        ),
                        onPressed: () {},
                        child: Text(
                          "Show new Year",
                          style: ThemesFonts.Font13White.copyWith(
                              color: blackColor),
                        ),
                      )
                    ],
                  ),
                ),
                Image.asset("assets/images/general/landing.png")
              ],
            ),
          );
        },
        options: CarouselOptions(),
      ),
    );
  }
}
