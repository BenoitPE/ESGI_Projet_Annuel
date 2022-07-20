import 'package:Watchlist/models/data.dart';
import '../providers/user_cache_provider.dart';

class UserRepository {
  final UserCacheProvider _cache = UserCacheProvider();

  addUser(User user) async {
    await _cache.insert(user);
  }

  Future<List<User>> getAllUser() async {
    return await _cache.getAll();
  }

  void deleteUser(User user) async {
    await _cache.delete(user);
  }
}