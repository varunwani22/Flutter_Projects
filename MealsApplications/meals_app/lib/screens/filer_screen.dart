import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meals_app/models/filter_model.dart';
import 'package:meals_app/models/meals.dart';
import 'package:meals_app/services/shared_preference_service.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters';
  Meal meal;

  FilterScreen({required this.meal});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  List<Widget> arrFilterTiles = [];
  List<FilterModel> arrFilters = [];
  final FILTER_KEY = 'filters';

  fetchData() {
    FilterModel.fetchData().then((arrStoredFilters) {
      //getting filter model and and returning it into the filtertile
      arrFilterTiles.addAll(
        arrStoredFilters.map((filterModel) {
          return _buildSwitchTile(filterModel: filterModel);
        }),
      );
      arrFilters.addAll(arrStoredFilters);

      print('aasas${arrFilterTiles.length}');
      setState(() {
        print(arrFilterTiles.length);
      });
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Widget _buildSwitchTile({required FilterModel filterModel}) {
    return StatefulBuilder(
      builder: (BuildContext context, void Function(void Function()) setState) {
        return SwitchListTile(
          title: Text(filterModel.title),
          subtitle: Text(filterModel.description),
          value: filterModel.currentValue,
          onChanged: (newValue) {
            setState(() {
              filterModel.currentValue = newValue;
            });
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(),
      appBar: AppBar(
        title: Text('Filters'),
        actions: [
          IconButton(
            onPressed: () {
              var arrFilterJson = [];
              arrFilters.forEach((element) {
                arrFilterJson.add(element.toJson());
              });

              SharedPreferencesServices.saveData(
                data: json.encode(arrFilterJson),
                key: FILTER_KEY,
              );

              widget.meal.isGlutenFree = 
            },
            icon: Icon(Icons.save),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust meal selection!',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: arrFilterTiles.length,
              itemBuilder: (context, index) {
                return arrFilterTiles[index];
              },
            ),
          ),
        ],
      ),
    );
  }
}
