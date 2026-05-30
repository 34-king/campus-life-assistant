// 🤖 AI Generated — 主入口文件（Trae AI 根据需求生成）
// ✏️ Human Modified — 添加了 MultiProvider、路由配置、主题消费者

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/favorites_provider.dart';
import 'providers/theme_provider.dart';
import 'pages/splash_page.dart';
import 'pages/home_page.dart';
import 'pages/schedule_page.dart';
import 'pages/canteen_page.dart';
import 'pages/notice_page.dart';
import 'pages/favorites_page.dart';
import 'pages/profile_page.dart';
import 'pages/map_page.dart';
import 'pages/settings_page.dart';
import 'pages/card_page.dart';
import 'pages/grade_page.dart';
import 'pages/calendar_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final favProvider = FavoritesProvider();
  await favProvider.init();
  final themeProvider = ThemeProvider();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: favProvider),
        ChangeNotifierProvider.value(value: themeProvider),
      ],
      child: const CampusLifeApp(),
    ),
  );
}

class CampusLifeApp extends StatelessWidget {
  const CampusLifeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, _) {
        return MaterialApp(
          title: '校园生活助手',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorSchemeSeed: const Color(0xFF4CAF50),
            useMaterial3: true,
            brightness: Brightness.light,
          ),
          darkTheme: ThemeData(
            colorSchemeSeed: const Color(0xFF4CAF50),
            useMaterial3: true,
            brightness: Brightness.dark,
          ),
          themeMode: themeProvider.themeMode,
          initialRoute: '/splash',
          routes: {
            '/splash': (_) => const SplashPage(),
            '/home': (_) => const MainScreen(),
            '/favorites': (_) => const FavoritesPage(),
            '/map': (_) => const MapPage(),
            '/settings': (_) => const SettingsPage(),
            '/card': (_) => const CardPage(),
            '/grade': (_) => const GradePage(),
            '/calendar': (_) => const CalendarPage(),
          },
        );
      },
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(onNavigate: (i) => setState(() => _currentIndex = i)),
      const SchedulePage(),
      const CanteenPage(),
      const NoticePage(),
      const ProfilePage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (i) => setState(() => _currentIndex = i),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: '首页',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month),
            label: '课程',
          ),
          NavigationDestination(
            icon: Icon(Icons.restaurant_outlined),
            selectedIcon: Icon(Icons.restaurant),
            label: '食堂',
          ),
          NavigationDestination(
            icon: Icon(Icons.article_outlined),
            selectedIcon: Icon(Icons.article),
            label: '公告',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outlined),
            selectedIcon: Icon(Icons.person),
            label: '我的',
          ),
        ],
      ),
    );
  }
}
