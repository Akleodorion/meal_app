import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_iteam.dart';

class MealScreen extends StatelessWidget {
  const MealScreen({super.key, required this.meals});

  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('meals')),
      body: ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx, index) {
            return MealItem(meal: meals[index]);
          }),
    );
  }
}
