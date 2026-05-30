import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/school_data.dart';
import '../providers/favorites_provider.dart';

class CanteenPage extends StatefulWidget {
  const CanteenPage({super.key});
  @override State<CanteenPage> createState() => _CanteenPageState();
}

class _CanteenPageState extends State<CanteenPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _canteens = ['全部', ...MockData.canteens];

  @override
  void initState() { super.initState(); _tabController = TabController(length: _canteens.length, vsync: this); }
  @override void dispose() { _tabController.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('食堂菜单'),
        bottom: TabBar(controller: _tabController, isScrollable: true,
          tabs: _canteens.map((name) => Tab(text: name)).toList()),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _canteens.map((canteen) {
          final dishes = canteen == '全部' ? MockData.dishes : MockData.getDishesByCanteen(canteen);
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: dishes.length,
            itemBuilder: (context, index) => _DishCard(dish: dishes[index]),
          );
        }).toList(),
      ),
    );
  }
}

class _DishCard extends StatelessWidget {
  final Dish dish;
  const _DishCard({required this.dish});
  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(builder: (context, favs, _) {
      final isFav = favs.isDishFavorited(dish.name);
      return Card(margin: const EdgeInsets.only(bottom: 8),
        child: Padding(padding: const EdgeInsets.all(12),
          child: Row(children: [
            Container(width: 64, height: 64,
              decoration: BoxDecoration(color: Colors.orange.withAlpha(26), borderRadius: BorderRadius.circular(8)),
              child: Icon(Icons.restaurant, color: Colors.orange.shade400, size: 32)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(dish.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 4),
              Text(dish.description, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              const SizedBox(height: 4),
              Row(children: [
                Text('${dish.price.toStringAsFixed(1)}', style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(width: 8),
                Icon(Icons.star, size: 14, color: Colors.amber.shade600),
                Text(dish.rating.toString(), style: const TextStyle(fontSize: 12)),
              ]),
            ])),
            IconButton(icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: isFav ? Colors.red : Colors.grey),
              onPressed: () => favs.toggleDishFavorite(dish.name)),
          ])),
        );
    });
  }
}
