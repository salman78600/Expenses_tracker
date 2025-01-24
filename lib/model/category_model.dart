import 'package:flutter/src/widgets/icon_data.dart';

class Category {
  final int? id;
  final String title;
  final IconData icon;

  Category({this.id, required this.title, required this.icon});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'icon': icon,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'],
      title: map['title'],
      icon: map['icon'],
    );
  }
}
