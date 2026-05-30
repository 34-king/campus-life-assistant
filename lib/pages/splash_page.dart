import 'package:flutter/material.dart';
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
      SizedBox(height: 16), Text('校园生活助手', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
    ]))));
}
