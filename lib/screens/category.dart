import 'package:flutter/material.dart';
import '../data/dummy_data.dart';
import '../models/meal.dart';
import '../models/category.dart';
import '../screens/meals.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  void _goToMeals(BuildContext context, Category category) {
    final categoryMeals = widget.availableMeals.where((meal) {
      return meal.categories.contains(category.id);
    }).toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) {
          return MealsScreen(
            category: category,
            meals: categoryMeals,
          );
        },
      ),
    );
  }

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (ctx, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(0.0, 0.2),
            end: const Offset(0.0, 0.0),
          ).animate(_animationController),
          child: child,
        );
      },
      child: Scaffold(
        body: GridView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              crossAxisCount: 2),
          children: [
            for (var category in availableCategories)
              InkWell(
                borderRadius: BorderRadius.circular(20),
                onTap: () {
                  _goToMeals(context, category);
                },
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                      colors: [
                        category.color.withOpacity(0.55),
                        category.color.withOpacity(0.9)
                      ],
                    ),
                  ),
                  child: Text(
                    category.title,
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.white),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
