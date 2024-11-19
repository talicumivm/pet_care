class UserManager {
  static final UserManager _instance = UserManager._internal();
  String? email;
  String? role;

  factory UserManager() {
    return _instance;
  }

  UserManager._internal();

  static UserManager get instance => _instance;

  void setUser(String userEmail, String userRole) {
    email = userEmail;
    role = userRole;
  }
}
