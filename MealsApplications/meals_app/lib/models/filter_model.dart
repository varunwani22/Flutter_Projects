import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meals_app/services/shared_preference_service.dart';

FilterModel filterModelFromJson(String str) =>
    FilterModel.fromJson(json.decode(str));

String filterModelToJson(FilterModel data) => json.encode(data.toJson());

class FilterModel {
  FilterModel({
    required this.title,
    required this.description,
    required this.currentValue,
  });

  String title;
  String description;
  bool currentValue;

  factory FilterModel.fromJson(Map<String, dynamic> json) => FilterModel(
        title: json["title"],
        description: json["description"],
        currentValue: json["currentValue"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "currentValue": currentValue,
      };

  static Future<List<FilterModel>> fetchData() async {
    // List<Widget> arrFilterTiles = [];
    List<FilterModel> arrFilters = [];
    final FILTER_KEY = 'filters';
    var storedFilterData =
        await SharedPreferencesServices.getData(key: FILTER_KEY);

    if (storedFilterData != null) {
      //retriving  the filtered data
      List storedFilterList = json.decode(storedFilterData);
      storedFilterList.forEach((element) {
        arrFilters.add(FilterModel.fromJson(element));
      });
    } else {
      arrFilters.add(FilterModel(
        title: 'Glutten-free',
        description: 'Only include glutten-free meals.',
        currentValue: false,
      ));
      arrFilters.add(FilterModel(
        title: 'Lactose-free',
        description: 'Only include lactose-free meals.',
        currentValue: false,
      ));

      arrFilters.add(FilterModel(
        title: 'Vegetarian',
        description: 'Only include vegetarian meals.',
        currentValue: false,
      ));
      arrFilters.add(FilterModel(
        title: 'Vegan',
        description: 'Only include vegan meals.',
        currentValue: false,
      ));
    }
    return arrFilters;
  }
}
