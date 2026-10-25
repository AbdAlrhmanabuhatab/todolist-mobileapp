import 'package:flutter_test/flutter_test.dart';
import 'package:todolist/features/auth/data/models/user_model.dart';
import 'package:todolist/features/auth/presentation/providers/auth_provider.dart';

void main() {
  group('UserModel', () {
    test('creates valid instance and serializes/deserializes correctly', () {
      const user = UserModel(
        name: 'John Doe',
        email: 'john@example.com',
        avatarPath: 'images/abed.jpg',
      );

      expect(user.name, 'John Doe');
      expect(user.email, 'john@example.com');
      expect(user.avatarPath, 'images/abed.jpg');

      final json = user.toJson();
      final fromJson = UserModel.fromJson(json);

      expect(fromJson, equals(user));
      expect(fromJson.hashCode, equals(user.hashCode));
    });

    test('copyWith works as expected', () {
      const user = UserModel(
        name: 'John Doe',
        email: 'john@example.com',
      );

      final updated = user.copyWith(name: 'Jane Doe');
      expect(updated.name, 'Jane Doe');
      expect(updated.email, 'john@example.com');
    });
  });

  group('AuthProvider', () {
    late AuthProvider authProvider;

    setUp(() {
      authProvider = AuthProvider();
    });

    test('initial state is unauthenticated', () {
      expect(authProvider.isAuthenticated, isFalse);
      expect(authProvider.currentUser, isNull);
      expect(authProvider.isLoading, isFalse);
    });

    test('login succeeds with valid credentials', () async {
      final result = await authProvider.login('alex.smith@example.com', 'password123');

      expect(result, isTrue);
      expect(authProvider.isAuthenticated, isTrue);
      expect(authProvider.currentUser?.email, 'alex.smith@example.com');
      expect(authProvider.currentUser?.name, 'Alex Smith');
    });

    test('login fails with empty credentials', () async {
      final result = await authProvider.login('', '');

      expect(result, isFalse);
      expect(authProvider.isAuthenticated, isFalse);
    });

    test('register creates user and signs in', () async {
      final result = await authProvider.register(
        'Sara Connor',
        'sara@example.com',
        'securePass123',
      );

      expect(result, isTrue);
      expect(authProvider.isAuthenticated, isTrue);
      expect(authProvider.currentUser?.name, 'Sara Connor');
    });

    test('logout resets user state', () async {
      await authProvider.login('test@example.com', '123456');
      expect(authProvider.isAuthenticated, isTrue);

      authProvider.logout();
      expect(authProvider.isAuthenticated, isFalse);
      expect(authProvider.currentUser, isNull);
    });
  });
}
