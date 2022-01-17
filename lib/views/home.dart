import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ptsganjil202112rpl2kinan14/models/recipe.dart';
import 'package:ptsganjil202112rpl2kinan14/views/widgets/recipe_card.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Recipe> _recipes = [];
  late List<dynamic> data;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    getRecipes();
  }

  void getRecipes() async{
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list', {"start": "0",
      "limit": "18",
      "tag": "list.recipe.popular"});
    final response = await http.get(uri, headers: {
      "x-rapidapi-host": "yummly2.p.rapidapi.com",
      "x-rapidapi-key": "c3e8a89977mshf42f6aec1244df0p141693jsne82ae5c1a42e",
      "useQueryString": "true"
    });
    if (response.statusCode == 200) {
      var res = jsonDecode(response.body);
      data = res['feed'];
      for (int i = 0; i < data.length; i++) {
        var details = data[i]['content']['details'];
        String name = details['name'];
        String desc = '';
        try {
          desc = data[i]['content']['description']['text'] ?? 'Currently, there\'s no description for this recipe';
        } catch (e) {
          print(e.toString());
          desc = 'Currently there\'s no description for this recipe';
        }
        if (desc == '') {
          desc = 'Currently there\'s no description for this recipe';
        }
        print('desc $desc');
        String image = details['images'][0]["resizableImageUrl"];
        String rating = details['rating'].toString();
        String totalTime = details['totalTime'];

        _recipes.add(Recipe(name, desc, image, rating, totalTime));
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Icon(Icons.restaurant_menu),
          SizedBox(width: 10),
          Text('Food Recipe')
        ],),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _recipes.length,
              itemBuilder: (context, index){
                return RecipeCard(recipe: _recipes[index]);
              },
            ) );
  }
}
