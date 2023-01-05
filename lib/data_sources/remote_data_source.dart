import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/core/app_strings.dart';

import 'end_points.dart';
import '../models/user_model.dart';
import 'package:http/http.dart' as http;

import 'local_data_source.dart';

class RemoteDataSource {
  // Future<List<UserModel>> fetchUsers() async {
  //   var response = await http.get(Uri.parse(EndPoints.apiUrl));
  //   log('APIAPI');
  //   return (json.decode(response.body)['data'] as List)
  //       .map((e) => UserModel.fromJson(e))
  //       .toList();
  // }

  // Future<AllUsersModel> fetchUsers() async {
  //   log('RemoteDataSource');
  //   var response = await http.get(Uri.parse(EndPoints.apiUrl));
  //   log('RemoteDataSource2');
  //   log(response.statusCode.toString());
  //
  //   var result = (json.decode(response.body)['data'] as List)
  //       .map((e) => UserModel.fromJson(e))
  //       .toList();
  //
  //   log(result.toString());
  //   return AllUsersModel.fromJson({'data': result});
  // }

  Future<AllUsersModel> fetchUsers() async {
    // final SharedPreferences sharedPreferences =
    //     await SharedPreferences.getInstance();
    // LocalDataSource localDataSource =
    //     LocalDataSource(sharedPreferences: sharedPreferences);

    // final AllUsersModel? cacheChecker =
    //     localDataSource.getCacheData(key: AppStrings.userData);

    LocalDataSource localDataSource = LocalDataSource();
    final AllUsersModel? cacheChecker = localDataSource.getCacheData();

    if (cacheChecker != null) {
      log('=======GET DATA FROM Cache============');
      // AllUsersModel? allUsersModel = localDataSource.getCacheData();
      // AllUsersModel allUsersModel =
      //     localDataSource.getCacheData(key: AppStrings.userData)!;
      // log('=================');
      // log(allUsersModel.users.toString());
      return cacheChecker;
    } else {
      log('=======GET DATA FROM API============');
      var response = await http.get(Uri.parse(EndPoints.apiUrl));
      final result = (json.decode(response.body));

      log(name: 'result', result.toString());
      AllUsersModel allUsersModel = AllUsersModel.fromJson(result);

      // Save to cache
      await localDataSource.saveCacheData(usersModelList: allUsersModel);

      log('=================');
      log(allUsersModel.users.toString());
      return allUsersModel;
    }
  }
}
