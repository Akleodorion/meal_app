import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meal_app/providers/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(filtersProvider);

    final isGlutenFree = filters[Filter.glutenFree];
    final isLactoseFree = filters[Filter.lactoseFree];
    final isVegetarian = filters[Filter.vagetarian];
    final isVegan = filters[Filter.vegan];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your filters'),
      ),
      body: WillPopScope(
        onWillPop: () async {
          ref.read(filtersProvider.notifier).setFilters({
            Filter.glutenFree: isGlutenFree,
            Filter.lactoseFree: isLactoseFree,
            Filter.vagetarian: isVegetarian,
            Filter.vegan: isVegan,
          });

          return true;
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
              value: isGlutenFree!,
              onChanged: (value) {
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filter.glutenFree, value);
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
              value: isLactoseFree!,
              onChanged: (value) {
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filter.lactoseFree, value);
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
              value: isVegetarian!,
              onChanged: (value) {
                ref
                    .read(filtersProvider.notifier)
                    .setFilter(Filter.vagetarian, value);
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
              value: isVegan!,
              onChanged: (value) {
                ref
                    .watch(filtersProvider.notifier)
                    .setFilter(Filter.vegan, value);
              },
            ),
          ],
        ),
      ),
    );
  }
}
