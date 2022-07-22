import 'package:Watchlist/models/data.dart';
import '../providers/data_cache_provider.dart';

class DataRepository {
  final DataCacheProvider _cache = DataCacheProvider();

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