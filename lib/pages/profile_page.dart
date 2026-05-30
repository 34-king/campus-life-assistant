import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('我的')),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Card(child: Padding(padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
          child: Row(children: [
            CircleAvatar(radius: 36, backgroundColor: Theme.of(context).colorScheme.primary.withAlpha(38),
              child: Icon(Icons.person, size: 40, color: Theme.of(context).colorScheme.primary)),
            const SizedBox(width: 16),
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('同学你好', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text('计算机科学与技术  2024级', style: TextStyle(color: Colors.grey.shade600)),
              Text('学号: 20241234', style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
            ]),
          ]))),
        const SizedBox(height: 16),
        Card(child: Column(children: [
          _MenuItem(icon: Icons.school, title: '成绩查询', subtitle: '查看各科成绩', onTap: () => Navigator.pushNamed(context, '/grade')),
          const Divider(height: 1, indent: 56),
          _MenuItem(icon: Icons.event_note, title: '考试安排', subtitle: '期末考试时间表', onTap: () {}),
          const Divider(height: 1, indent: 56),
          _MenuItem(icon: Icons.favorite, title: '我的收藏', subtitle: '收藏的菜品和公告', onTap: () => Navigator.pushNamed(context, '/favorites')),
          const Divider(height: 1, indent: 56),
          _MenuItem(icon: Icons.settings, title: '设置', subtitle: '主题、通知等', onTap: () => Navigator.pushNamed(context, '/settings')),
        ])),
        const SizedBox(height: 16),
        Card(child: Column(children: [
          _MenuItem(icon: Icons.info_outline, title: '关于', subtitle: 'v1.0.0', onTap: () {}),
          const Divider(height: 1, indent: 56),
          _MenuItem(icon: Icons.feedback_outlined, title: '意见反馈', subtitle: '告诉我们你的想法', onTap: () {}),
        ])),
      ]),
    );
  }
}

class _MenuItem extends StatelessWidget {
  final IconData icon; final String title; final String subtitle; final VoidCallback onTap;
  const _MenuItem({required this.icon, required this.title, required this.subtitle, required this.onTap});
  @override
  Widget build(BuildContext context) => ListTile(
    leading: Icon(icon, color: Theme.of(context).colorScheme.primary),
    title: Text(title), subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
    trailing: const Icon(Icons.chevron_right, color: Colors.grey), onTap: onTap,
  );
}
