import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_iteam.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen(
      {super.key, required this.meals, required this.onToggleFavorites});

  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavorites;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('meals')),
      body: ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx, index) {
            return MealItem(
              meal: meals[index],
              onToggleFavorites: onToggleFavorites,
            );
          }),
    );
  }
}
