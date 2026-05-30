const fs = require('fs');
const bom = '\uFEFF';
const pages = 'C:\\Users\\HASEE\\Desktop\\xyshzsapp\\lib\\pages\\';
const w = (name, content) => { fs.writeFileSync(pages + name, bom + content.trimStart() + '\n', 'utf-8'); console.log(name); };

// ======================
// splash_page.dart
// ======================
w('splash_page.dart', `
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeIn;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 800));
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _scale = Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));
    _controller.forward();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  void dispose() { _controller.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity, height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1565C0), Color(0xFF42A5F5), Color(0xFF90CAF9)],
            begin: Alignment.topCenter, end: Alignment.bottomCenter,
          ),
        ),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Opacity(
              opacity: _fadeIn.value,
              child: Transform.scale(
                scale: _scale.value,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 90, height: 90,
                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(22),
                        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, 8))]),
                      child: const Icon(Icons.school, size: 52, color: Color(0xFF1565C0)),
                    ),
                    const SizedBox(height: 24),
                    const Text('\u6821\u56ED\u751F\u6D3B\u52A9\u624B', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: 2)),
                    const SizedBox(height: 8),
                    Text('\u6CB3\u5357\u7406\u5DE5\u5927\u5B66', style: TextStyle(color: Colors.white70, fontSize: 15, letterSpacing: 4)),
                    const SizedBox(height: 48),
                    SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2.5, valueColor: AlwaysStoppedAnimation<Color>(Colors.white70))),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
`);

// ======================
// home_page.dart
// ======================
w('home_page.dart', `
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
      appBar: AppBar(title: const Text('\u6821\u56ED\u751F\u6D3B\u52A9\u624B'), centerTitle: true,
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
            Text('\uD83D\uDCDA \u4ECA\u65E5\u8BFE\u7A0B', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            if (todayCourses.isEmpty)
              Card(child: Padding(padding: const EdgeInsets.all(24), child: Center(child: Text('\u4ECA\u5929\u6CA1\u8BFE \uD83C\uDF89', style: Theme.of(context).textTheme.bodyLarge))))
            else
              ...todayCourses.map((c) => _CourseCard(course: c)),
            const SizedBox(height: 20),
            Text('\u26A1 \u5FEB\u6377\u5165\u53E3', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            _buildQuickActions(context),
          ]),
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    final actions = <(String, String, VoidCallback)>[
      ('\uD83C\uDF7D', '\u98DF\u5802\u83DC\u5355', () => onNavigate?.call(2)),
      ('\uD83D\uDCF0', '\u6821\u56ED\u516C\u544A', () => onNavigate?.call(3)),
      ('\uD83D\uDCCD', '\u6821\u56ED\u5730\u56FE', () => Navigator.pushNamed(context, '/map')),
      ('\uD83D\uDCB3', '\u6821\u56ED\u5361', () => Navigator.pushNamed(context, '/card')),
      ('\uD83D\uDCCB', '\u6210\u7EE9\u67E5\u8BE2', () => Navigator.pushNamed(context, '/grade')),
      ('\uD83D\uDCC5', '\u6821\u5386', () => Navigator.pushNamed(context, '/calendar')),
    ];
    return Wrap(spacing: 12, runSpacing: 12,
      children: actions.map((a) => SizedBox(
        width: (MediaQuery.of(context).size.width - 16 * 2 - 12 * 2) / 3,
        child: Card(child: InkWell(borderRadius: BorderRadius.circular(12), onTap: a.$3,
          child: Padding(padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(children: [Text(a.$1, style: const TextStyle(fontSize: 28)), const SizedBox(height: 6), Text(a.$2, style: const TextStyle(fontSize: 12))]))),
        ),
      )).toList(),
    );
  }
}

class _CourseCard extends StatelessWidget {
  final Course course;
  const _CourseCard({required this.course});
  @override
  Widget build(BuildContext context) {
    return Card(child: ListTile(
      leading: CircleAvatar(backgroundColor: Colors.primaries[course.name.hashCode % Colors.primaries.length].withAlpha(200),
        child: Text(course.name[0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold))),
      title: Text(course.name, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text('${course.teacher} \u00B7 ${course.classroom} \u00B7 ${MockData.slotTime(course.startSlot)}'),
      trailing: Text('\u7B2C${course.startSlot}-${course.startSlot + course.duration - 1}\u8282', style: const TextStyle(fontSize: 12, color: Colors.grey)),
    ));
  }
}

class _WeatherCard extends StatefulWidget {
  const _WeatherCard();
  @override
  State<_WeatherCard> createState() => _WeatherCardState();
}

class _WeatherCardState extends State<_WeatherCard> with SingleTickerProviderStateMixin {
  String _temp = '--';
  String _weather = '\u52A0\u8F7D\u4E2D...';
  String _city = '\u7126\u4F5C';
  String _updateTime = '';
  late AnimationController _animCtrl;
  String _displayTemp = '';

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 600));
    _fetchWeather();
  }

  @override
  void dispose() { _animCtrl.dispose(); super.dispose(); }

  Future<void> _fetchWeather() async {
    try {
      final url = Uri.parse('https://wttr.in/Jiaozuo?format=j1');
      final resp = await http.get(url).timeout(const Duration(seconds: 5));
      if (resp.statusCode == 200 && mounted) {
        final data = jsonDecode(resp.body);
        final current = data['current_condition'][0];
        setState(() { _temp = current['temp_C']; _weather = current['weatherDesc'][0]['value']; _city = '\u7126\u4F5C';
          final now = DateTime.now(); _updateTime = '\u66F4\u65B0: ${now.hour.toString().padLeft(2, '0')}:${now.minute.toString().padLeft(2, '0')}'; _displayTemp = ''; });
        _animateTemperature(current['temp_C']);
      }
    } catch (_) {
      if (mounted) setState(() { _temp = '28'; _weather = '\u6674 \u00B7 \u7A7A\u6C14\u8D28\u91CF \u4F18'; _city = '\u7126\u4F5C'; _updateTime = '--'; _displayTemp = '28'; });
    }
  }

  void _animateTemperature(String target) {
    final targetVal = int.tryParse(target) ?? 28;
    int current = 0;
    Future.doWhile(() async {
      await Future.delayed(const Duration(milliseconds: 20));
      if (!mounted) return false;
      current += 1;
      setState(() => _displayTemp = '$current');
      return current < targetVal;
    });
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
          Text('\uFFFD${_displayTemp.isNotEmpty ? _displayTemp : _temp}\u00B0C', style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
          Text(_weather, style: TextStyle(color: Colors.white.withAlpha(230))),
          Row(children: [
            Text(_city, style: TextStyle(color: Colors.white.withAlpha(180), fontSize: 12)),
            if (_updateTime.isNotEmpty) ...[const SizedBox(width: 8), Text(_updateTime, style: TextStyle(color: Colors.white.withAlpha(130), fontSize: 10))],
          ]),
        ]),
        const Spacer(),
        Column(children: [
          Text('\uFFFD${DateTime.now().month}/${DateTime.now().day}', style: const TextStyle(color: Colors.white, fontSize: 16)),
          Text(MockData.weekdayName(DateTime.now().weekday), style: TextStyle(color: Colors.white.withAlpha(200))),
        ]),
      ]),
    ));
  }
}
`);

console.log('Done writing pages');
