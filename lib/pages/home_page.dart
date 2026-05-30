import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/school_data.dart';

class HomePage extends StatelessWidget {
  final void Function(int)? onNavigate;
  const HomePage({super.key, this.onNavigate});

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now().weekday;
    final todayCourses = MockData.getCoursesForDay(today);
    return Scaffold(
      appBar: AppBar(
        title: const Text('校园生活助手'),
        centerTitle: true,
        actions: [IconButton(icon: const Icon(Icons.notifications_outlined), onPressed: () {})],
      ),
      body: RefreshIndicator(
        onRefresh: () => Future.delayed(const Duration(seconds: 1)),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const _WeatherCard(),
            const SizedBox(height: 16),
            Text('今日课程', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            if (todayCourses.isEmpty)
              Card(child: Padding(padding: const EdgeInsets.all(24), child: Center(child: Text('今天没课', style: Theme.of(context).textTheme.bodyLarge))))
            else
              ...todayCourses.map((c) => _buildCourseCard(context, c)),
            const SizedBox(height: 20),
            Text('快捷入口', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildQuickActions(context),
          ]),
        ),
      ),
    );
  }

  Widget _buildCourseCard(BuildContext context, Course c) {
    return Card(child: ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.primaries[c.name.hashCode % Colors.primaries.length].withAlpha(200),
        child: Text(c.name[0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      ),
      title: Text(c.name, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text('${c.teacher} - ${c.classroom}'),
      trailing: Text('第${c.startSlot}节', style: const TextStyle(fontSize: 12, color: Colors.grey)),
    ));
  }

  Widget _buildQuickActions(BuildContext context) {
    final actions = <(String, String, VoidCallback)>[
      ('食堂', '食堂菜单', () => onNavigate?.call(2)),
      ('公告', '校园公告', () => onNavigate?.call(3)),
      ('地图', '校园地图', () => Navigator.pushNamed(context, '/map')),
      ('卡', '校园卡', () => Navigator.pushNamed(context, '/card')),
      ('成绩', '成绩查询', () => Navigator.pushNamed(context, '/grade')),
      ('日历', '校历', () => Navigator.pushNamed(context, '/calendar')),
    ];
    return Wrap(spacing: 12, runSpacing: 12,
      children: actions.map((a) => SizedBox(
        width: (MediaQuery.of(context).size.width - 16 * 2 - 12 * 2) / 3,
        child: Card(child: InkWell(borderRadius: BorderRadius.circular(12), onTap: a.$3,
          child: Padding(padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(children: [Text(a.$1, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.blue)),
              const SizedBox(height: 6), Text(a.$2, style: const TextStyle(fontSize: 12))]))),
        ),
      )).toList(),
    );
  }
}

class _WeatherCard extends StatefulWidget {
  const _WeatherCard();
  @override State<_WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<_WeatherCard> {
  String _temp = '--';
  String _weather = '加载中...';

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  Future<void> _fetchWeather() async {
    try {
      final url = Uri.parse('https://wttr.in/Jiaozuo?format=j1');
      final resp = await http.get(url).timeout(const Duration(seconds: 5));
      if (resp.statusCode == 200 && mounted) {
        final data = jsonDecode(resp.body);
        final current = data['current_condition'][0];
        setState(() { _temp = current['temp_C']; _weather = current['weatherDesc'][0]['value']; });
      }
    } catch (_) {
      if (mounted) setState(() { _temp = '28'; _weather = '晴'; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(child: Container(
      width: double.infinity, padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12),
        gradient: const LinearGradient(colors: [Color(0xFF4A90D9), Color(0xFF7B68EE)], begin: Alignment.topLeft, end: Alignment.bottomRight)),
      child: Row(children: [
        const Icon(Icons.wb_sunny, color: Colors.yellow, size: 48),
        const SizedBox(width: 16),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('$_temp\u00B0C', style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
          Text(_weather, style: TextStyle(color: Colors.white.withAlpha(230))),
        ]),
      ]),
    ));
  }
}
