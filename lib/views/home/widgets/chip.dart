import 'package:elektroku/shared/constants/themes.dart';
import 'package:flutter/material.dart';

class ChipWidget extends StatelessWidget {
  final String chipLabel;
  final Function()? onTap;
  const ChipWidget({
    super.key,
    required this.chipLabel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Chip(
        backgroundColor: whiteColor,
        label: Text(chipLabel),
      ),
    );
  }
}
