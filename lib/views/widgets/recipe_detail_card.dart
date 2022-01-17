import 'package:flutter/material.dart';
import 'package:ptsganjil202112rpl2kinan14/models/recipe.dart';

class DetailScreen extends StatelessWidget {

  final Recipe recipe;

  const DetailScreen({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('BACK'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(recipe.images),
                  ),
                  SizedBox(height: 20),
                  Text('Deskripsi', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.black)),
                  SizedBox(height: 10),
                  Text(recipe.description, style: TextStyle(color: Colors.black, fontSize: 16), textAlign: TextAlign.center)
                ],
              ),
            ),
          ),
        )
      ),
    );
  }

}