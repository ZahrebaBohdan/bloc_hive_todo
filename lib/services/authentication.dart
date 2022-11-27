import 'package:hive/hive.dart';

import '../data/model/user.dart';

class AuthenticationService {
  late Box<User> _users;

  Future<void> init() async {
    Hive.registerAdapter(UserAdapter());
    _users = await Hive.openBox('usersBox');

    await _users.add(User('1', '1'));
    await _users.add(User('2', '2'));
  }

  Future<String?> authenticateUser(
      final String username, final String password) async {
    final success = _users.values.any(
        (value) => value.username == username && value.password == password);
    if (success) {
      return username;
    } else {
      return null;
    }
  }

  Future<UserCreationResult> createUser(
      final String username, final String password) async {
    final alreadyExists = _users.values.any(
      (element) => element.username.toLowerCase() == username.toLowerCase(),
    );

    if (alreadyExists) {
      return UserCreationResult.already_exists;
    }
    try {
      _users.add(User(username, password));
      return UserCreationResult.success;
    } on Exception {
      return UserCreationResult.failure;
    }
  }
}

enum UserCreationResult { success, failure, already_exists }
