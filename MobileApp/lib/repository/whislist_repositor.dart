import 'package:Watchlist/models/data.dart';
import '../providers/whislist_cache_provider.dart';

class WhislistRepository {
  final WhislistCacheProvider _cache = WhislistCacheProvider();

  addData(Data data) async {
    await _cache.insert(data);
  }

  Future<List<Data>> getAllData() async {
    return await _cache.getAll();
  }

  Future deleteAll() async{
    return await _cache.deleteAll();
  }

}