import 'package:flutter/material.dart';

enum Filter { glutenFree, lactoseFree, vagetarian, vegan }

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.filters});

  final Map<Filter, bool> filters;
  @override
  State<FiltersScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FiltersScreen> {
  bool _isGlutenFree = true;
  bool _isLactoseFree = false;
  bool _isVegetarian = false;
  bool _isVegan = false;

  @override
  void initState() {
    _isGlutenFree = widget.filters[Filter.glutenFree]!;
    _isLactoseFree = widget.filters[Filter.lactoseFree]!;
    _isVegetarian = widget.filters[Filter.vagetarian]!;
    _isVegan = widget.filters[Filter.vegan]!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your filters'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          Navigator.of(context).pop({
            Filter.glutenFree: _isGlutenFree,
            Filter.lactoseFree: _isLactoseFree,
            Filter.vagetarian: _isVegetarian,
            Filter.vegan: _isVegan,
          });
          return false;
        },
        child: Column(
          children: [
            SwitchListTile(
              title: Text(
                'Gluten-Free',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text('Only includes gluten free meals',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground)),
              value: _isGlutenFree,
              onChanged: (value) {
                setState(() {
                  _isGlutenFree = value;
                });
              },
            ),
            SwitchListTile(
              title: Text(
                'Lactose-Free',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text('Only includes lactose free meals',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground)),
              value: _isLactoseFree,
              onChanged: (value) {
                setState(() {
                  _isLactoseFree = value;
                });
              },
            ),
            SwitchListTile(
              title: Text(
                'Vegetarian',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text('Only includes vegetarian meals',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground)),
              value: _isVegetarian,
              onChanged: (value) {
                setState(() {
                  _isVegetarian = value;
                });
              },
            ),
            SwitchListTile(
              title: Text(
                'Vegan',
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground),
              ),
              subtitle: Text('Only includes vegan meals',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onBackground)),
              value: _isVegan,
              onChanged: (value) {
                setState(() {
                  _isVegan = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
