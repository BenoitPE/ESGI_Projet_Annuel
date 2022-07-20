

import 'package:Watchlist/models/data.dart';
import '../providers/data_cache_provider.dart';

class DataRepository {
  final DataCacheProvider _cache = DataCacheProvider();

  addData(Data data) async {
    await _cache.insert(data);
  }

  Future<List<Data>> getAllDatas() async {
    return await _cache.getAll();
  }

  void delete() async {
    await _cache.delete();
  }
}