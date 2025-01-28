import 'package:expenses_tracker/utils/app_style.dart';
import 'package:flutter/material.dart';

class SummaryWidget extends StatelessWidget {
  String title;
  double count;
  Color color;
  SummaryWidget(
      {super.key,
      required this.title,
      required this.count,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: titleTextWhite),
              SizedBox(height: 8),
              Text(
                '€${count.toStringAsFixed(2)}',
                style: titleTextWhite22,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
