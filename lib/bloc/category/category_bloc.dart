import 'package:bloc/bloc.dart';
import 'package:expenses_tracker/model/category_model.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<LoadCategories>((event, emit) {
      // Emit the predefined categories
      final categories = [
        Category(id: 1, title: 'Food', icon: Icons.fastfood),
        Category(id: 2, title: 'Travel', icon: Icons.flight),
        Category(id: 3, title: 'Shopping', icon: Icons.shopping_cart),
        Category(id: 4, title: 'Education', icon: Icons.school),
        Category(id: 5, title: 'Health', icon: Icons.local_hospital),
      ];
      emit(CategoryLoaded(categories));
    });
  }
}
