class User {
  final int age;
  final String username;
  final int roleId;
  final String? info;
  final double? height;

  User({
    required this.age,
    required this.username,
    required this.roleId,
    required this.info,
     this.height,
  });

  User copyWith({
    int? age,
    String? username,
    int? roleId,
    String? info,
    double? height,
  }) =>
      User(
        age: age ?? this.age,
        username: username ?? this.username,
        roleId: roleId ?? this.roleId,
        info: info ?? this.info,
        height: height ?? this.height,
      );
      
      static User fromJson(Map<String, dynamic> map) => User(
        age: map["age"] ,
        username: map["username"] ,
        roleId: map["roleId"] ,
        info: map["info"] ,
        height: map["height"] ,
      );

  Map<String,dynamic> toJson()=>{
        "age": age,
        "username": username,
        "roleId": roleId,
        "info": info,
        "height": height,
  };
}
