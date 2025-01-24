import 'package:expenses_tracker/utils/app_style.dart';
import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hello user,', style: Appstyle.bodyText),
              Text('Welcome Back!', style: Appstyle.titleText),
            ],
          ),
          // Icon(Icons.person_2_outlined)
        ],
      ),
    );
  }
}
