// [AI-GEN] Settings with theme toggle.
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/theme_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('\u8BBE\u7F6E')),
    body: Consumer<ThemeProvider>(builder: (context, tp, _) => Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
      const Text('\u4E3B\u9898\u8BBE\u7F6E'),
      RadioListTile<ThemeMode>(
        title: const Text('\u6DF1\u8272\u6A21\u5F0F'),
        value: ThemeMode.dark,
        groupValue: tp.themeMode,
        onChanged: (v) => tp.setThemeMode(v!),
      ),
      RadioListTile<ThemeMode>(
        title: const Text('\u6D45\u8272\u6A21\u5F0F'),
        value: ThemeMode.light,
        groupValue: tp.themeMode,
        onChanged: (v) => tp.setThemeMode(v!),
      ),
      RadioListTile<ThemeMode>(
        title: const Text('\u8DDF\u968F\u7CFB\u7EDF'),
        value: ThemeMode.system,
        groupValue: tp.themeMode,
        onChanged: (v) => tp.setThemeMode(v!),
      ),
    ]))),
  );
}
