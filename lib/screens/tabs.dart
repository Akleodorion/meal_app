import 'package:flutter/material.dart';
import 'package:meal_app/screens/category.dart';
import '../models/meal.dart';
import '../screens/favorites.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _currentIndex = 0;
  String appBarTitle = 'Categories';
  final List<Meal> _favoriteMeals = [];

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

  @override
  Widget build(BuildContext context) {
    Widget content = CategoryScreen(
      onToggleFavorites: _toggleFavoriteMeal,
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
      );
      appBarTitle = 'Categories';
    }

    return Scaffold(
      drawer: const MainDrawer(),
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
