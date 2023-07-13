import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/screens/category.dart';

import '../models/meal.dart';
import '../providers/meals_provider.dart';
import '../providers/favorite_provider.dart';
import '../screens/favorites.dart';
import '../screens/filters.dart';
import '../widgets/main_drawer.dart';

var kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vagetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _currentIndex = 0;
  String appBarTitle = 'Categories';
  Map<Filter, bool> myFilters = kInitialFilters;

  void _setScreens(String identifier) async {
    Navigator.pop(context);

    if (identifier == 'filters') {
      myFilters = await Navigator.of(context).push(
        MaterialPageRoute(
          builder: ((context) {
            return FiltersScreen(
              filters: myFilters,
            );
          }),
        ),
      );

      setState(() {
        final meals = dummyMeals.where((meal) {
          if (myFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
            return false;
          }
          if (myFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
            return false;
          }
          if (myFilters[Filter.vagetarian]! && !meal.isVegetarian) {
            return false;
          }
          if (myFilters[Filter.vegan]! && !meal.isVegan) {
            return false;
          }

          return true;
        }).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final favoriteMeals = ref.watch(favoriteMealsProvider);

    Widget content = CategoryScreen(
      availableMeals: meals,
    );
    if (_currentIndex == 1) {
      appBarTitle = 'Your favorite meals';
      content = FavoritesScreen(
        meals: favoriteMeals,
      );
    } else {
      content = CategoryScreen(
        availableMeals: meals,
      );
      appBarTitle = 'Categories';
    }

    return Scaffold(
      drawer: MainDrawer(onSelected: _setScreens),
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: content,
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.restaurant), label: 'categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites')
        ],
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex = value;
          });
        },
      ),
    );
  }
}
