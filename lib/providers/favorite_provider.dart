import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/meal.dart';

class FavoriteNotifier extends StateNotifier<List<Meal>> {
  FavoriteNotifier() : super([]);

  bool toggleFavoriteMeal(Meal meal) {
    // vérifié si le meal est dans la liste
    final bool isFavorite = state.contains(meal);

    if (isFavorite) {
      state = state.where((m) => meal.id != m.id).toList();
    } else {
      state = [
        ...state,
        meal
      ]; // cette ligne créer un nouveau tableau avec une nouvelle valeur dedans
    }
    return isFavorite;
  }
}

final favoriteMealsProvider =
    StateNotifierProvider<FavoriteNotifier, List<Meal>>((ref) {
  return FavoriteNotifier();
});
