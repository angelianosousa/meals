import 'package:flutter/material.dart';
import './categories.dart';
import './favorite_meals.dart';

class TabsTop extends StatelessWidget {
  const TabsTop({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Let's Cook!"),
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.category),
                text: 'Categorias',
                
              ),
              Tab(
                icon: Icon(Icons.favorite),
                text: 'Favoritos',
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          Categories(),
          // FavoriteMeals(),
        ]),
      ),
    );
  }
}
