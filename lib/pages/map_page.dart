import 'package:flutter/material.dart';

class _Building {
  final String name; final IconData icon; final String description; final String location;
  const _Building({required this.name, required this.icon, required this.description, required this.location});
}

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  static const List<_Building> _buildings = [
    _Building(name: '教学楼A', icon: Icons.school, description: '主教学楼', location: '校园中心'),
    _Building(name: '教学楼B', icon: Icons.account_balance, description: '文科教学楼', location: '校园东区'),
    _Building(name: '教学楼C', icon: Icons.menu_book, description: '理工科综合楼', location: '校园北区'),
    _Building(name: '实验楼', icon: Icons.biotech, description: '综合实验中心', location: '校园东北角'),
    _Building(name: '食堂', icon: Icons.restaurant, description: '五大餐厅', location: '生活区中心'),
    _Building(name: '图书馆', icon: Icons.local_library, description: '馆藏丰富', location: '校园中心'),
    _Building(name: '体育馆', icon: Icons.fitness_center, description: '综合体育场馆', location: '校园南区'),
    _Building(name: '行政楼', icon: Icons.business, description: '行政办公中心', location: '校园南门'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('校园地图'), centerTitle: true),
      body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(padding: const EdgeInsets.all(16), child: Text('主要建筑', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold))),
        Expanded(child: GridView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisSpacing: 12, crossAxisSpacing: 12, childAspectRatio: 0.95),
          itemCount: _buildings.length,
          itemBuilder: (context, index) {
            final b = _buildings[index];
            return Card(clipBehavior: Clip.antiAlias,
              child: InkWell(onTap: () => _showDetail(context, b),
                child: Padding(padding: const EdgeInsets.all(16),
                  child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Icon(b.icon, size: 44, color: theme.colorScheme.primary),
                    const SizedBox(height: 12),
                    Text(b.name, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 4),
                    Text(b.location, style: TextStyle(fontSize: 11, color: theme.colorScheme.onSurface.withAlpha(128)), textAlign: TextAlign.center, maxLines: 2, overflow: TextOverflow.ellipsis),
                  ]))),
            );
          },
        )),
      ]),
    );
  }

  void _showDetail(BuildContext context, _Building building) {
    showDialog(context: context, builder: (ctx) => AlertDialog(
      icon: Icon(building.icon, size: 40, color: Theme.of(context).colorScheme.primary),
      title: Text(building.name),
      content: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [const Icon(Icons.location_on, size: 16, color: Colors.grey), const SizedBox(width: 4), Expanded(child: Text(building.location, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)))]),
        const SizedBox(height: 12),
        Text(building.description, style: const TextStyle(fontSize: 14, height: 1.5)),
      ]),
      actions: [TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('关闭'))],
    ));
  }
}
