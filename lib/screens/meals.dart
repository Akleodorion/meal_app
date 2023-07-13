import 'package:flutter/material.dart';
import 'package:meal_app/models/category.dart';
import '../models/meal.dart';
import '../widgets/meal_iteam.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({super.key, required this.meals, required this.category});

  final List<Meal> meals;
  final Category category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(category.title)),
      body: ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx, index) {
            return MealItem(
              meal: meals[index],
            );
          }),
    );
  }
}
