import 'package:flutter/material.dart';

/*
** Category model class
*/
class Category {
  int id;
  String title;
  IconData icon;

  Category({required this.id, required this.title, required this.icon});

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
