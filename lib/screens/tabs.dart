import 'package:flutter/material.dart';
import 'package:meal_app/data/dummy_data.dart';
import 'package:meal_app/screens/category.dart';
import '../models/meal.dart';
import '../screens/favorites.dart';
import '../widgets/main_drawer.dart';
import '../screens/filters.dart';

var kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vagetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _currentIndex = 0;
  String appBarTitle = 'Categories';
  Map<Filter, bool> myFilters = kInitialFilters;
  final List<Meal> _favoriteMeals = [];
  List<Meal> availableMeals = dummyMeals;

  void _toggleFavoriteMeal(Meal meal) {
    if (_favoriteMeals.contains(meal)) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully added this meal from favorite'),
      ));
    } else {
      setState(() {
        _favoriteMeals.add(meal);
      });
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully removed this meal from favorite'),
      ));
    }
  }

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
        availableMeals = dummyMeals.where((meal) {
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
    Widget content = CategoryScreen(
      onToggleFavorites: _toggleFavoriteMeal,
      availableMeals: availableMeals,
    );
    if (_currentIndex == 1) {
      appBarTitle = 'Your favorite meals';
      content = FavoritesScreen(
        meals: _favoriteMeals,
        onToggleFavorites: _toggleFavoriteMeal,
      );
    } else {
      content = CategoryScreen(
        onToggleFavorites: _toggleFavoriteMeal,
        availableMeals: availableMeals,
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
