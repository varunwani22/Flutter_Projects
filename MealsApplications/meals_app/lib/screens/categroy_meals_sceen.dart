import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/meals.dart';
import 'package:meals_app/widgets/meal_items.dart';

class CategorymealsScreen extends StatefulWidget {
  // final String categoryId;
  // final String categoryTitle;

  // CategorymealsScreen(this.categoryId, this.categoryTitle);
  static const routeName = '/category-meals';

  final List<Meal> availableMeals;

  CategorymealsScreen(this.availableMeals);

  @override
  _CategorymealsScreenState createState() => _CategorymealsScreenState();
}

class _CategorymealsScreenState extends State<CategorymealsScreen> {
  String categoryTitle;
  List<Meal> displayMeals;
  var _loadedInitData = false;

  @override
  void didChangeDependencies() {
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'].toString();
      final categoryId = routeArgs['id'];
      displayMeals = widget.availableMeals.where((meals) {
        return meals.categories.contains(categoryId);
      }).toList();
      _loadedInitData = true;
    }

    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayMeals.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return MealItems(
            id: displayMeals[index].id,
            title: displayMeals[index].title,
            imageUrl: displayMeals[index].imageUrl,
            duration: displayMeals[index].duration,
            complexity: displayMeals[index].complexity,
            affordability: displayMeals[index].affordability,
          );
        },
        itemCount: displayMeals.length,
      ),
    );
  }
}
