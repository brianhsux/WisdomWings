import 'package:flutter/material.dart';
import 'challenge.dart';
import 'local_storage_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class CategoryPage extends StatefulWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  Map<String, dynamic> jsonData = {};

  Future<void> _loadJsonData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? jsonString = prefs.getString('default_data_json_key');

    if (jsonString != null) {
      setState(() {
        jsonData = json.decode(jsonString);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: jsonData.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: jsonData['categories'].length,
              itemBuilder: (context, index) {
                if (index < jsonData['categories'].length) {
                  final category = jsonData['categories'][index];
                  return ListTile(
                    title: Text(category['name']),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChallengePage(
                            categoryName: category['name'],
                            jsonData: jsonData,
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return const SizedBox();
                }
              },
            ),
    );
  }
}
