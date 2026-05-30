const fs = require('fs');
const pages = 'C:\\Users\\HASEE\\Desktop\\xyshzsapp\\lib\\pages\\';
const bom = '\uFEFF';
const w = (name, content) => fs.writeFileSync(pages + name, bom + content.trimStart() + '\n', 'utf-8');

// Generate all 12 page stubs  
const stubs = {
  'home_page.dart': `import 'package:flutter/material.dart';
class HomePage extends StatelessWidget {
  final void Function(int)? onNavigate;
  const HomePage({super.key, this.onNavigate});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('\u6821\u56ED\u751F\u6D3B\u52A9\u624B')), body: const Center(child: Text('\u9996\u9875')));
}`,

  'schedule_page.dart': `import 'package:flutter/material.dart';
class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('\u8BFE\u7A0B\u8868')), body: const Center(child: Text('\u8BFE\u7A0B\u8868')));
}`,

  'canteen_page.dart': `import 'package:flutter/material.dart';
class CanteenPage extends StatelessWidget {
  const CanteenPage({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('\u98DF\u5802\u83DC\u5355')), body: const Center(child: Text('\u98DF\u5802\u83DC\u5355')));
}`,

  'notice_page.dart': `import 'package:flutter/material.dart';
class NoticePage extends StatelessWidget {
  const NoticePage({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('\u6821\u56ED\u516C\u544A')), body: const Center(child: Text('\u6821\u56ED\u516C\u544A')));
}`,

  'profile_page.dart': `import 'package:flutter/material.dart';
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('\u6211\u7684')), body: const Center(child: Text('\u6211\u7684')));
}`,

  'favorites_page.dart': `import 'package:flutter/material.dart';
class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('\u6211\u7684\u6536\u85CF')), body: const Center(child: Text('\u6536\u85CF')));
}`,

  'card_page.dart': `import 'package:flutter/material.dart';
class CardPage extends StatelessWidget {
  const CardPage({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('\u6821\u56ED\u5361')), body: const Center(child: Text('\u6821\u56ED\u5361')));
}`,

  'grade_page.dart': `import 'package:flutter/material.dart';
class GradePage extends StatelessWidget {
  const GradePage({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('\u6210\u7EE9\u67E5\u8BE2')), body: const Center(child: Text('\u6210\u7EE9')));
}`,

  'calendar_page.dart': `import 'package:flutter/material.dart';
class CalendarPage extends StatelessWidget {
  const CalendarPage({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('\u6821\u5386')), body: const Center(child: Text('\u6821\u5386')));
}`,

  'map_page.dart': `import 'package:flutter/material.dart';
class MapPage extends StatelessWidget {
  const MapPage({super.key});
  @override Widget build(BuildContext context) => Scaffold(appBar: AppBar(title: const Text('\u6821\u56ED\u5730\u56FE')), body: const Center(child: Text('\u5730\u56FE')));
}`,

  'settings_page.dart': `import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('\u8BBE\u7F6E')),
    body: Consumer<ThemeProvider>(builder: (context, tp, _) => Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      const Text('\u4E3B\u9898\u8BBE\u7F6E'),
      SwitchListTile(title: const Text('\u6DF1\u8272\u6A21\u5F0F'), value: tp.isDark, onChanged: (v) => tp.toggleTheme()),
    ]))),
  );
}`,

'splash_page.dart': `import 'package:flutter/material.dart';
class SplashPage extends StatefulWidget {
  const SplashPage({super.key});
  @override State<SplashPage> createState() => _SplashPageState();
}
class _SplashPageState extends State<SplashPage> {
  @override void initState() { super.initState(); Future.delayed(const Duration(seconds: 2), () { if (mounted) Navigator.pushReplacementNamed(context, '/home'); }); }
  @override Widget build(BuildContext context) => Scaffold(body: Container(width: double.infinity, height: double.infinity,
    decoration: const BoxDecoration(gradient: LinearGradient(colors: [Color(0xFF1565C0), Color(0xFF42A5F5)], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
    child: const Center(child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Icon(Icons.school, size: 64, color: Colors.white),
      SizedBox(height: 16), Text('\u6821\u56ED\u751F\u6D3B\u52A9\u624B', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
    ]))));
}`,
};

for (const [name, content] of Object.entries(stubs)) {
  w(name, content);
}
console.log(Object.keys(stubs).length + ' page stubs generated');
