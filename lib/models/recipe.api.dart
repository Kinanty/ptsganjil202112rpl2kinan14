import 'dart:convert';
import 'package:ptsganjil202112rpl2kinan14/models/recipe.dart';
import 'package:http/http.dart' as http;

class RecipeApi{
  static Future<List<Recipe>> getRecipe() async{
    var uri = Uri.https('yummly2.p.rapidapi.com', '/feeds/list', {"start": "0",
      "limit": "18",
      "tag": "list.recipe.popular"});
    final response = await http.get(uri, headers: {
      "x-rapidapi-host": "yummly2.p.rapidapi.com",
      "x-rapidapi-key": "c3e8a89977mshf42f6aec1244df0p141693jsne82ae5c1a42e",
      "useQueryString": "true"
    });

    Map data = jsonDecode(response.body);
    List temp = [];

    for (var i in data['feed']){
      temp.add(i['content']['details']);
    }
    return Recipe.recipesFromSnapshot(temp);
  }

}