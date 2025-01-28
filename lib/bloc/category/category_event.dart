part of 'category_bloc.dart';

@immutable
sealed class CategoryEvent {
  //
}

class LoadCategories extends CategoryEvent {
  final List<Category> categories;

  LoadCategories(this.categories);
}

class CategorySelected extends CategoryEvent {
  final Category selectedCategory;

  CategorySelected(this.selectedCategory);
}
