import 'package:expenses_tracker/bloc/category/category_bloc.dart';
import 'package:expenses_tracker/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryList extends StatelessWidget {
  const CategoryList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoryBloc, CategoryState>(
      builder: (context, state) {
        if (state is CategoryInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CategoryLoaded) {
          return SingleChildScrollView(
            child: SizedBox(
              height: 70,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: state.categories.length,
                itemBuilder: (context, index) {
                  final category = state.categories[index];
                  final isSelected = category == state.selectedCategory;
                  return GestureDetector(
                    onTap: () {
                      // Dispatch the category selection event
                      print('Selected category: ${category.title}');
                      context
                          .read<CategoryBloc>()
                          .add(CategorySelected(category));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.black : Colors.white,
                          border: Border.all(
                            color: isSelected ? Colors.black : Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        width: 70,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              category.icon,
                              size: 15,
                              color: isSelected ? Colors.white : Colors.grey,
                            ),
                            const SizedBox(height: 5),
                            Text(
                              category.title,
                              style: isSelected
                                  ? bodyText.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    )
                                  : bodyText,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        }
        return const Center(child: Text('Unknown state'));
      },
    );
  }
}
