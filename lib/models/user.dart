class User {
  String id;
  String fullname;
  String username;

  User({required this.fullname, required this.id, required this.username});
  factory User.fromJson(Map<String, dynamic> json) => User(
      id: json['_id'], fullname: json['fullName'], username: json['userName']);

  factory User.fromSocketJson(Map<String, dynamic> json) => User(
      id: json['userId'],
      fullname: json['fullname'],
      username: json['username']);
}
