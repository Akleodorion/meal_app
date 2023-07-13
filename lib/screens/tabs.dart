import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/screens/category.dart';

import '../providers/favorite_provider.dart';
import '../providers/filters_provider.dart';
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

  void _setScreens(String identifier) {
    Navigator.pop(context);

    if (identifier == 'filters') {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: ((context) {
            return const FiltersScreen();
          }),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoriteMeals = ref.watch(favoriteMealsProvider);
    final filteredMeals = ref.watch(filteredMealsProvider);

    Widget content = CategoryScreen(
      availableMeals: filteredMeals,
    );
    if (_currentIndex == 1) {
      appBarTitle = 'Your favorite meals';
      content = FavoritesScreen(
        meals: favoriteMeals,
      );
    } else {
      content = CategoryScreen(
        availableMeals: filteredMeals,
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
