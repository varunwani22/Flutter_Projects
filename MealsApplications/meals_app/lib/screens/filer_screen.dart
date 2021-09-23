import 'package:flutter/material.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filters';
  final Function saveFilters;
  final Map<String, bool> currentFilters;

  FilterScreen({@required this.saveFilters, @required this.currentFilters});

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _glutenFree = false;
  bool _vegetarian = false;
  bool _vegan = false;
  bool _lactoseFree = false;

  // fetchData() {
  //   FilterModel.fetchData().then((arrStoredFilters) {
  //     //getting filter model and and returning it into the filtertile
  //     arrFilterTiles.addAll(
  //       arrStoredFilters.map((filterModel) {
  //         return _buildSwitchTile(filterModel: filterModel);
  //       }),
  //     );
  //     arrFilters.addAll(arrStoredFilters);

  //     print('aasas${arrFilterTiles.length}');
  //     setState(() {
  //       print(arrFilterTiles.length);
  //     });
  //   });
  // }

  @override
  void initState() {
    _glutenFree = widget.currentFilters['gluten'];
    _lactoseFree = widget.currentFilters['lactose'];
    _vegetarian = widget.currentFilters['vegetarian'];
    _vegan = widget.currentFilters['vegan'];
    super.initState();
    // fetchData();
  }

  Widget _buildSwitchListTile(
    String title,
    String description,
    bool currentValue,
    Function updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(
        description,
      ),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Filters'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.save),
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarian,
              };
              widget.saveFilters(selectedFilters);
            },
          )
        ],
      ),
      drawer: MainDrawer(),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection.',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          Expanded(
            child: ListView(
              children: <Widget>[
                _buildSwitchListTile(
                  'Gluten-free',
                  'Only include gluten-free meals.',
                  _glutenFree,
                  (newValue) {
                    setState(
                      () {
                        _glutenFree = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Lactose-free',
                  'Only include lactose-free meals.',
                  _lactoseFree,
                  (newValue) {
                    setState(
                      () {
                        _lactoseFree = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Vegetarian',
                  'Only include vegetarian meals.',
                  _vegetarian,
                  (newValue) {
                    setState(
                      () {
                        _vegetarian = newValue;
                      },
                    );
                  },
                ),
                _buildSwitchListTile(
                  'Vegan',
                  'Only include vegan meals.',
                  _vegan,
                  (newValue) {
                    setState(
                      () {
                        _vegan = newValue;
                      },
                    );
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );

    // Widget _buildSwitchTile({
    //   String title,
    //   String description,
    //   bool currentValue,
    //   Function updateValue,
    //   }) {
    //   return StatefulBuilder(
    //     builder: (BuildContext context, void Function(void Function()) setState) {
    //       return SwitchListTile(
    //         title: Text(filterModel.title),
    //         subtitle: Text(filterModel.description),
    //         value: filterModel.currentValue,
    //         onChanged: (newValue) {
    //           setState(() {
    //             filterModel.currentValue = newValue;
    //           });
    //         },
    //       );
    //     },
    //   );
    // }

    // @override
    // Widget build(BuildContext context) {
    //   return Scaffold(
    //     drawer: MainDrawer(),
    //     appBar: AppBar(
    //       title: const Text('Filters'),
    //       actions: [
    //         IconButton(
    //           onPressed: () {
    //             final selectedFilters = {
    //               'gluten': _glutenFree,
    //               'lactose': _lactoseFree,
    //               'vegan': _vegan,
    //               'vegetarian': _vegetarian,
    //             };
    //             widget.saveFilters(selectedFilters);
    //           },
    //           icon: Icon(Icons.save),
    //         )
    //       ],
    //     ),
    //     body: Column(
    //       children: [
    //         Container(
    //           padding: EdgeInsets.all(20),
    //           child: Text(
    //             'Adjust meal selection!',
    //             style: Theme.of(context).textTheme.title,
    //           ),
    //         ),
    //         Expanded(
    //           child: ListView.builder(
    //             itemCount: arrFilterTiles.length,
    //             itemBuilder: (context, index) {
    //               return arrFilterTiles[index];
    //             },
    //           ),
    //         ),
    //       ],
    //     ),
    //   );
  }
}
