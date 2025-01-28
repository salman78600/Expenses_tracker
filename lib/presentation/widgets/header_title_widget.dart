import 'package:expenses_tracker/utils/app_style.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HeaderTitleWidget extends StatelessWidget {
  String? title;
  String? viewTitle;
  HeaderTitleWidget({super.key, this.title, this.viewTitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title!, style: titleText),
          Text(viewTitle!, style: bodyText),
        ],
      ),
    );
  }
}
