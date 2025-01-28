import 'package:flutter/material.dart';
import '../components/main_drawer.dart';
import '../models/configuration.dart';

class Settings extends StatefulWidget {
  final Function(Configuration) onSettingsChanged;
  final Configuration configs;

  const Settings(this.configs, this.onSettingsChanged, {super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late Configuration configuration;

  @override
  void initState(){
    super.initState();
    configuration = widget.configs;
  }

  Widget _createSwitch(
    String title,
    String subtitle,
    bool value,
    Function(bool) onChanged,
  ) {
    return SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: (value) {
        onChanged(value);
        widget.onSettingsChanged(configuration);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configurações'),
      ),
      drawer: MainDrawer(),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Filtros',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                _createSwitch(
                  'Sem Glúten',
                  'Exibir só alimentos sem glúten',
                  configuration.isGlutenFree,
                  (value) => setState(() => configuration.isGlutenFree = value),
                ),
                _createSwitch(
                  'Sem Lactose',
                  'Exibir só alimentos sem lactose',
                  configuration.isLactoseFree,
                  (value) => setState(() => configuration.isLactoseFree = value),
                ),
                _createSwitch(
                  'Somente Vegano',
                  'Exibir apenas alimentos veganos',
                  configuration.isVegan,
                  (value) => setState(() => configuration.isVegan = value),
                ),
                _createSwitch(
                  'Somente Vegetariano',
                  'Exibir apenas alimentos vegetarianos',
                  configuration.isVegetarian,
                  (value) => setState(() => configuration.isVegetarian = value),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
