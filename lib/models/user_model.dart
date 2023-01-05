class UserModel {
  int id;
  String name;
  String email;
  String gender;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        gender: json['gender']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'gender': gender,
    };
  }
}

class AllUsersModel {
  List<UserModel> users = [];

  AllUsersModel({required users});

  // factory AllUsersModel.fromJson(Map<String, dynamic> json) {
  //   return AllUsersModel(users: json['data']);
  // }

  AllUsersModel.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((element) {
      users.add(UserModel.fromJson(element));
    });
  }

  Map<String, dynamic> toJson() {
    final result = <String, dynamic>{};

    result.addAll({'data': users.map((x) => x.toJson()).toList()});

    return result;
  }
}
