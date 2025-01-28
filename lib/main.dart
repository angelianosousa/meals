import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/configuration.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/category_meals.dart';
import 'package:meals/screens/meal_details.dart';
import 'package:meals/screens/settings.dart';
import 'package:meals/screens/tabs_bottom.dart';
import 'utils/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Configuration configs = Configuration();

  List<Meal> _availableMeals = dummyMeals;
  List<Meal> _favoriteMeals = [];

  void _filterMeals(Configuration configs) {
    setState(() {
      this.configs = configs;

      _availableMeals = dummyMeals.where((meal) {
        final haveGluten = configs.isGlutenFree && !meal.isGlutenFree;
        final haveLactose = configs.isLactoseFree && !meal.isLactoseFree;
        final isVegan = configs.isVegan && !meal.isVegan;
        final isVegetarian = configs.isVegetarian && !meal.isVegetarian;

        return !haveGluten && !haveLactose && !isVegan && !isVegetarian;
      }).toList();
    });
  }

  void _toggleFavorite(Meal meal) {
    setState(() {
      _favoriteMeals.contains(meal)
          ? _favoriteMeals.remove(meal)
          : _favoriteMeals.add(meal);
    });
  }

  bool _isFavorite(Meal meal) {
    return _favoriteMeals.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primaryColor: Colors.deepOrange[700],
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.deepOrange[700],
          foregroundColor: Colors.white,
        ),
        fontFamily: 'Releway',
        canvasColor: Colors.amber[50],
        textTheme: ThemeData.light().textTheme.copyWith(
              titleMedium:
                  TextStyle(fontSize: 20, fontFamily: 'RobotoCondensed'),
            ),
      ),
      routes: {
        Routes.home: (ctx) => TabsBottom(_favoriteMeals),
        Routes.categoryMeals: (ctx) => CategoryMeals(_availableMeals),
        Routes.mealDetails: (ctx) => MealDetails(_isFavorite, _toggleFavorite),
        Routes.settings: (ctx) => Settings(configs, _filterMeals),
      },
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (_) {
          return Categories();
        });
      },
    );
  }
}
