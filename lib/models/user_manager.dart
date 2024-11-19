class UserManager {
  static final UserManager _instance = UserManager._internal();
  int? id;
  String? email;
  String? role;
  String? name;

  factory UserManager() {
    return _instance;
  }

  UserManager._internal();

  static UserManager get instance => _instance;

  void setUser(int userId, String userEmail, String userRole, String userName) {
    id = userId;
    email = userEmail;
    role = userRole;
    name = userName;
  }
}
