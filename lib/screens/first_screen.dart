import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/config/routes/app_routes.dart';
import 'package:test_project/core/app_strings.dart';
import 'package:test_project/data_sources/local_data_source.dart';
import 'package:test_project/screens/second_screen.dart';
import 'package:test_project/models/user_model.dart';
import 'package:test_project/providers/user_provider.dart';
import 'package:http/http.dart' as http;

import '../data_sources/end_points.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  FirstScreenState createState() => FirstScreenState();
}

class FirstScreenState extends State<FirstScreen> {
  Future<List<UserModel>> fetchUsers() async {
    var response = await http.get(Uri.parse(EndPoints.apiUrl));
    log('APIAPI');
    return (json.decode(response.body)['data'] as List)
        .map((e) => UserModel.fromJson(e))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Screen'),
      ),
      body: Container(
        color: Colors.teal,
        padding: const EdgeInsets.all(8),
        child: FutureBuilder<AllUsersModel>(
          future: Provider.of<UserProvider>(context).getApiData(),
          // future: fetchUsers(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              // List<UserModel> users = snapshot.data as List<UserModel>;
              AllUsersModel usersListModel = snapshot.data as AllUsersModel;
              List<UserModel> users = usersListModel.users;

              return ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(8),
                      color: Colors.white,
                      child: Column(
                        children: [
                          Text(users[index].name),
                          Text(users[index].email),
                          Text(users[index].gender),
                        ],
                      ),
                    );
                  });
            }
            if (snapshot.hasError) {
              log(snapshot.error.toString());
              return const Center(child: Text('error'));
            }
            return const Center(
                child: CircularProgressIndicator(color: Colors.white));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          navigateAndFinish(context, const SecondScreen());
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
