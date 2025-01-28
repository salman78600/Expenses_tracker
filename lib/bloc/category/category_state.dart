part of 'category_bloc.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<Category> categories;
  final Category? selectedCategory; // Track selected category

  CategoryLoaded({required this.categories, this.selectedCategory});
}

class CategoryError extends CategoryState {
  final String error;

  CategoryError(this.error);
}
