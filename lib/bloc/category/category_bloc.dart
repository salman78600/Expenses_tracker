import 'package:bloc/bloc.dart';

import 'package:expenses_tracker/model/category_model.dart';
import 'package:expenses_tracker/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'category_event.dart';
part 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {
    on<LoadCategories>(_loadCategories);
    on<CategorySelected>((event, emit) {
      if (state is CategoryLoaded) {
        final currentState = state as CategoryLoaded;
        emit(CategoryLoaded(
          categories: currentState.categories,
          selectedCategory:
              event.selectedCategory, // Update the selected category
        ));
      }
    });
  }

  void _loadCategories(LoadCategories event, Emitter<CategoryState> emit) {
    emit(CategoryLoaded(categories: categories));
  }
}
