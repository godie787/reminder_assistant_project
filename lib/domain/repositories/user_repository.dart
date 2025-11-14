abstract class UserRepository {
  Future<String> getUserId();
  Future<void> saveUserId(String userId);
}
