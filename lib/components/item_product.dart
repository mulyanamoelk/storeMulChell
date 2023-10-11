import 'package:elektroku/shared/constants/themes.dart';
import 'package:elektroku/shared/extentions/money.dart';
import 'package:flutter/material.dart';

class ItemProduct extends StatelessWidget {
  final String image;
  final String title;
  final String shortDescription;
  final int price;
  final Function() onPressed;
  final Icon icon;
  const ItemProduct({
    super.key,
    required this.image,
    required this.title,
    required this.shortDescription,
    required this.price,
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 8.0),
      height: 100.0,
      width: MediaQuery.of(context).size.width * .5,
      decoration: BoxDecoration(
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            color: primaryColor.withOpacity(.2),
            blurRadius: 10.0,
            spreadRadius: 2,
            offset: const Offset(0, 6),
          )
        ],
        borderRadius: const BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              margin:
                  const EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(10.0),
                ),
                image: DecorationImage(
                    image: AssetImage(image), fit: BoxFit.cover),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: ThemesFonts.Font14Black.copyWith(
                      color: blackColor, fontWeight: FontWeight.bold),
                ),
                Text(
                  shortDescription,
                  style: ThemesFonts.Font12.copyWith(color: darkGrayColor),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      price.formatRupiah(),
                      style: ThemesFonts.Font14Black,
                    ),
                    InkWell(
                      onTap: onPressed,
                      child: icon,
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
