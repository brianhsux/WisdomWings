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
  String userTitle = 'Beginner'; // Default user title
  int experience = 0; // User experience points
  int tickets = 3; // Number of tickets available
  int maxTickets = 5;

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
      body: Column(
        children: [
          Expanded(
            child: jsonData.isEmpty
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: jsonData['categories'].length,
                    itemBuilder: (context, index) {
                      final category = jsonData['categories'][index];
                      return ListTile(
                        title: Text(category['name']),
                        leading: Icon(Icons.category), // Add category icon
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
                    },
                  ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'User Information',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(height: 12),
                Row(
                  children: [
                    Icon(Icons.person, color: Colors.blue),
                    SizedBox(width: 8),
                    Text('English Title: $userTitle',
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.orange),
                    SizedBox(width: 8),
                    Text('Experience: $experience points',
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.confirmation_number, color: Colors.green),
                    SizedBox(width: 8),
                    Text('Tickets: $tickets/$maxTickets',
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
