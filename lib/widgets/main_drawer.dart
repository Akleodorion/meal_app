import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        DrawerHeader(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.5),
                Theme.of(context).colorScheme.primaryContainer.withOpacity(0.9),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.fastfood,
                size: 40,
                color: Theme.of(context).colorScheme.onPrimaryContainer,
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                'Cooking Up!',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer),
              ),
            ],
          ),
        ),
        ListTile(
          onTap: () {},
          leading: Icon(
            Icons.restaurant,
            size: 24,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          title: Text(
            'Meals',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
        ),
        ListTile(
          onTap: () {},
          leading: Icon(
            Icons.settings,
            size: 24,
            color: Theme.of(context).colorScheme.onBackground,
          ),
          title: Text(
            'Settings',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.onBackground),
          ),
        )
      ],
    ));
  }
}
