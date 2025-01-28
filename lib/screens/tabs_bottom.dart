import 'package:flutter/material.dart';
import 'package:meals/components/main_drawer.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/favorite_meals.dart';

class TabsBottom extends StatefulWidget {
  final List<Meal> favoriteMeals;

  const TabsBottom(this.favoriteMeals, {super.key});

  @override
  State<TabsBottom> createState() => _TabsBottomState();
}

class _TabsBottomState extends State<TabsBottom> {
  int _selectedTabIndex = 0;

  late List<Map<String, Object>> _tabs;

  @override
  void initState() {
    super.initState();
    _tabs = [
      {'title': 'Lista de Categorias', 'screen': Categories()},
      {'title': 'Meus Favoritos', 'screen': FavoriteMeals(widget.favoriteMeals)},
    ];
  }

  _selectTab(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_tabs[_selectedTabIndex]['title'] as String),
        centerTitle: true,
      ),
      drawer: MainDrawer(),
      body: _tabs[_selectedTabIndex]['screen'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white60,
        currentIndex: _selectedTabIndex,
        onTap: _selectTab,
        backgroundColor: Theme.of(context).primaryColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categorias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favoritos',
          ),
        ],
      ),
    );
  }
}
