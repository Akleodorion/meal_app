import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/favorite_provider.dart';
import '../models/meal.dart';

class DetailScreen extends ConsumerWidget {
  const DetailScreen({
    super.key,
    required this.meal,
  });

  final Meal meal;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final isFavorite = favoriteMeals.contains(meal);

    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final wasRemoved = ref
                  .watch(favoriteMealsProvider.notifier)
                  .toggleFavoriteMeal(meal);
              ScaffoldMessenger.of(context).clearSnackBars();
              if (wasRemoved) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        'You have successfully removed this meal from favorite')));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text(
                      'You have successfully added this meal from favorite'),
                ));
              }
            },
            icon: Icon(isFavorite ? Icons.star : Icons.star_border),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.network(
              meal.imageUrl,
              height: 350,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            const SizedBox(
              height: 40,
            ),
            for (var ingredient in meal.ingredients)
              Text(ingredient,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground)),
            const SizedBox(
              height: 20,
            ),
            for (var step in meal.steps)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  step,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
