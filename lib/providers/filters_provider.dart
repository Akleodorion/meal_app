import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/meals_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vagetarian,
  vegan,
}

class FiltersNotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vagetarian: false,
          Filter.vegan: false,
        });

  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }

  void setFilters(Map<Filter, bool> filters) {
    state = filters;
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, Map<Filter, bool>>((ref) {
  return FiltersNotifier();
});

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final filters = ref.watch(filtersProvider);

  final filteredMeals = meals.where((meal) {
    if (filters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (filters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (filters[Filter.vagetarian]! && !meal.isVegetarian) {
      return false;
    }
    if (filters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }

    return true;
  }).toList();
  return filteredMeals;
});
