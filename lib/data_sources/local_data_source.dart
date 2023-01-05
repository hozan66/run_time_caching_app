import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

const String CACHE_USERS_KEY = "CACHE_USERS_KEY";
const int CACHE_USERS_INTERVAL = 60 * 1000; // 1 MINUTE IN MILLIS
Map<String, CachedItem> cacheMap = {};

class LocalDataSource {
  // run time cache

  // final SharedPreferences sharedPreferences;

  // LocalDataSource({required this.sharedPreferences});

  AllUsersModel? getCacheData() {
    CachedItem? cachedItem = cacheMap[CACHE_USERS_KEY];

    if (cachedItem != null && cachedItem.isValid(CACHE_USERS_INTERVAL)) {
      return cachedItem.data;
      // return the response from cache
    } else {
      // return error that cache is not valid
      // throw ErrorHandler.handle(DataSource.CACHE_ERROR);
      return null;
    }

    // final String? jsonString = sharedPreferences.getString(key);
    // if (jsonString != null) {
    //   final AllUsersModel cacheUserData =
    //       AllUsersModel.fromJson(json.decode(jsonString));
    //   return cacheUserData;
    // } else {
    //   log('Error Fetching Data');
    // }
    // return null;
  }

  Future<void> saveCacheData({required AllUsersModel usersModelList}) async {
    cacheMap[CACHE_USERS_KEY] = CachedItem(usersModelList);
    // return await sharedPreferences.setString(key, json.encode(usersModelList));
  }
  // ====================================

  // Clear all cache
  void clearCache() {
    cacheMap.clear();
  }

  void removeFromCache({required String key}) {
    cacheMap.remove(key);
  }
}

class CachedItem {
  // Save Dynamic Responses
  dynamic data;

  int cacheTime = DateTime.now().millisecondsSinceEpoch;

  CachedItem(this.data);
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTime) {
    // expirationTime is 60 secs
    int currentTimeInMillis =
        DateTime.now().millisecondsSinceEpoch; // time now is 1:00:00 pm

    bool isCacheValid = currentTimeInMillis - expirationTime <
        cacheTime; // cache time was in 12:59:30
    // false if current time > 1:00:30
    // true if current time <1:00:30
    return isCacheValid;
  }
}
