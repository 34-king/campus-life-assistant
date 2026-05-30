// [AI-GEN] Favorites state management. [HUMAN] Added SharedPreferences persistence.
// 🤖 AI Generated — Provider 状态管理（收藏 + 持久化）
// ✏️ Human Modified — 添加了 SharedPreferences 持久化

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/school_data.dart';

class FavoritesProvider extends ChangeNotifier {
  final Set<String> _favoriteDishNames = {};
  final Set<String> _favoriteNoticeTitles = {};
  bool _initialized = false;

  bool get initialized => _initialized;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    final dishNames = prefs.getStringList('favorite_dishes') ?? [];
    final noticeTitles = prefs.getStringList('favorite_notices') ?? [];
    _favoriteDishNames.addAll(dishNames);
    _favoriteNoticeTitles.addAll(noticeTitles);
    _initialized = true;
    notifyListeners();
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorite_dishes', _favoriteDishNames.toList());
    await prefs.setStringList('favorite_notices', _favoriteNoticeTitles.toList());
  }

  bool isDishFavorited(String name) => _favoriteDishNames.contains(name);

  void toggleDishFavorite(String name) {
    if (_favoriteDishNames.contains(name)) {
      _favoriteDishNames.remove(name);
    } else {
      _favoriteDishNames.add(name);
    }
    _save();
    notifyListeners();
  }

  List<Dish> get favoriteDishes =>
      MockData.dishes.where((d) => _favoriteDishNames.contains(d.name)).toList();

  int get favoriteDishCount => _favoriteDishNames.length;

  bool isNoticeFavorited(String title) => _favoriteNoticeTitles.contains(title);

  void toggleNoticeFavorite(String title) {
    if (_favoriteNoticeTitles.contains(title)) {
      _favoriteNoticeTitles.remove(title);
    } else {
      _favoriteNoticeTitles.add(title);
    }
    _save();
    notifyListeners();
  }

  List<Notice> get favoriteNotices =>
      MockData.notices.where((n) => _favoriteNoticeTitles.contains(n.title)).toList();

  int get favoriteNoticeCount => _favoriteNoticeTitles.length;

  int get totalFavorites => favoriteDishCount + favoriteNoticeCount;
}
