import 'package:flutter/material.dart';
import '../models/meal.dart';
import '../widgets/meal_iteam.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen(
      {super.key, required this.meals, required this.onToggleFavorites});
  final List<Meal> meals;
  final void Function(Meal meal) onToggleFavorites;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your favorites meals'),
      ),
      body: meals.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Oh no, no favorites in here',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text('Feel free to mark some meals as favorites !',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground))
                ],
              ),
            )
          : ListView(
              children: [
                for (var meal in meals)
                  MealItem(meal: meal, onToggleFavorites: onToggleFavorites),
              ],
            ),
    );
  }
}
