import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/category.dart';
import '../screens/meals.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  // void _goToMeal(BuildContext context, List<Meal> meals) {
  //   Navigator.of(context).push(MaterialPageRoute(builder: (ctx) {
  //     return MealScreen(meals: meals);
  //   }));
  // }

  void _goToMeals(BuildContext context, Category category) {
    final availableMeals = dummyMeals.where((meal) {
      return meal.categories.contains(category.id);
    }).toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) {
          return MealsScreen(meals: availableMeals);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My app'),
      ),
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
