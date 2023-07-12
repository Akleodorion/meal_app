import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/meal.dart';
import '../models/category.dart';
import '../screens/meals.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen(
      {super.key,
      required this.onToggleFavorites,
      required this.availableMeals});

  final void Function(Meal meal) onToggleFavorites;
  final List<Meal> availableMeals;

  void _goToMeals(BuildContext context, Category category) {
    final categoryMeals = availableMeals.where((meal) {
      return meal.categories.contains(category.id);
    }).toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) {
          return MealsScreen(
            category: category,
            meals: categoryMeals,
            onToggleFavorites: onToggleFavorites,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            crossAxisCount: 2),
        children: [
          for (var category in availableCategories)
            InkWell(
              borderRadius: BorderRadius.circular(20),
              onTap: () {
                _goToMeals(context, category);
              },
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      category.color.withOpacity(0.55),
                      category.color.withOpacity(0.9)
                    ],
                  ),
                ),
                child: Text(
                  category.title,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white),
                ),
              ),
            )
        ],
      ),
    );
  }
}
