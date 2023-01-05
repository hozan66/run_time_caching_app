import 'package:flutter/material.dart';
import 'package:test_project/models/user_model.dart';

import '../data_sources/remote_data_source.dart';

class UserProvider extends ChangeNotifier {
  RemoteDataSource remoteDataSource = RemoteDataSource();

  Future<AllUsersModel> getApiData() async {
    final usersList = await remoteDataSource.fetchUsers();

    return usersList;
    // notifyListeners();
  }
}
