// [AI-GEN] Favorites list (dishes + notices).
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('我的收藏')),
      body: Consumer<FavoritesProvider>(builder: (context, favs, _) {
        if (favs.totalFavorites == 0) {
          return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
            Icon(Icons.favorite_border, size: 80, color: Colors.grey.shade300),
            const SizedBox(height: 16),
            Text('还没有收藏', style: TextStyle(fontSize: 16, color: Colors.grey.shade500)),
            Text('去食堂或公告页面收藏吧', style: TextStyle(fontSize: 13, color: Colors.grey.shade400)),
          ]));
        }
        return ListView(padding: const EdgeInsets.all(12), children: [
          if (favs.favoriteDishes.isNotEmpty) ...[
            Padding(padding: const EdgeInsets.only(left: 4, bottom: 8),
              child: Text('菜品 (${favs.favoriteDishCount})', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
            ...favs.favoriteDishes.map((d) => Card(margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(leading: const Icon(Icons.restaurant, color: Colors.orange), title: Text(d.name),
                subtitle: Text('${d.canteen}'), trailing: IconButton(icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: () => favs.toggleDishFavorite(d.name))))),
          ],
          if (favs.favoriteNotices.isNotEmpty) ...[
            Padding(padding: const EdgeInsets.only(left: 4, bottom: 8),
              child: Text('公告 (${favs.favoriteNoticeCount})', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
            ...favs.favoriteNotices.map((n) => Card(margin: const EdgeInsets.only(bottom: 8),
              child: ListTile(leading: const Icon(Icons.article, color: Colors.blue), title: Text(n.title, maxLines: 1, overflow: TextOverflow.ellipsis),
                subtitle: Text(n.date), trailing: IconButton(icon: const Icon(Icons.close, color: Colors.grey),
                  onPressed: () => favs.toggleNoticeFavorite(n.title))))),
          ],
        ]);
      }),
    );
  }
}
