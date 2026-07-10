import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';

// 简单的内存缓存管理器
class DioCacheManager {
  static final DioCacheManager _instance = DioCacheManager._internal();

  // 缓存数据，使用LinkedHashMap保持插入顺序并便于进行LRU缓存
  final LinkedHashMap<String, _CacheItem> _cache = LinkedHashMap<String, _CacheItem>();

  // 缓存大小上限（默认100条）
  int _maxSize = 100;

  factory DioCacheManager() {
    return _instance;
  }

  DioCacheManager._internal();

  /// 设置缓存大小上限
  void setMaxSize(int size) {
    _maxSize = size;
    _evictIfNeeded();
  }

  /// 获取缓存数据
  Response<T>? getCache<T>(String key, {Duration? maxAge}) {
    final _CacheItem? cacheItem = _cache[key];

    if (cacheItem == null) {
      return null;
    }

    // 如果设置了最大缓存时间，检查是否过期
    if (maxAge != null) {
      final DateTime now = DateTime.now();
      if (now.difference(cacheItem.timestamp) > maxAge) {
        // 缓存过期，移除
        _cache.remove(key);
        return null;
      }
    }

    // 更新访问时间（用于LRU缓存策略）
    cacheItem.lastAccessed = DateTime.now();

    // 解析并返回缓存的响应
    try {
      // 直接返回已缓存的Response对象
      return cacheItem.response as Response<T>;
    } catch (e) {
      // 解析失败，移除缓存
      _cache.remove(key);
      return null;
    }
  }

  /// 缓存响应数据
  void setCache(String key, Response response) {
    _cache[key] = _CacheItem(
      response: response,
      timestamp: DateTime.now(),
      lastAccessed: DateTime.now(),
    );

    _evictIfNeeded();
  }

  /// 清除所有缓存
  void clearCache() {
    _cache.clear();
  }

  /// 清除指定缓存
  void removeCache(String key) {
    _cache.remove(key);
  }

  /// 如果缓存超出大小限制，移除最久未使用的缓存项
  void _evictIfNeeded() {
    if (_cache.length > _maxSize) {
      // 按最后访问时间排序
      final List<MapEntry<String, _CacheItem>> entries = _cache.entries.toList()
        ..sort((a, b) => a.value.lastAccessed.compareTo(b.value.lastAccessed));

      // 移除最早访问的条目，直到缓存大小符合要求
      for (int i = 0; i < entries.length - _maxSize; i++) {
        _cache.remove(entries[i].key);
      }
    }
  }

  /// 生成缓存键
  static String generateCacheKey(RequestOptions options) {
    final StringBuffer buffer = StringBuffer();
    buffer.write(options.method);
    buffer.write('-');
    buffer.write(options.uri.toString());

    if (options.data != null) {
      String dataStr;
      try {
        if (options.data is Map || options.data is List) {
          dataStr = jsonEncode(options.data);
        } else {
          dataStr = options.data.toString();
        }
        buffer.write('-');
        buffer.write(dataStr);
      } catch (_) {
        // 数据无法序列化，忽略
      }
    }

    return buffer.toString();
  }
}

/// 缓存项，包含响应数据和时间戳
class _CacheItem {
  final Response response;
  final DateTime timestamp;
  DateTime lastAccessed;

  _CacheItem({
    required this.response,
    required this.timestamp,
    required this.lastAccessed,
  });
}
