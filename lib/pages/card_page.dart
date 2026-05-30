import 'package:flutter/material.dart';
import '../models/school_data.dart';

class CardPage extends StatelessWidget {
  const CardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('校园卡'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _CardFace(),
          const SizedBox(height: 20),
          Row(children: [
            _ActionBtn(icon: Icons.add_card, label: '充值', color: Colors.green),
            const SizedBox(width: 12),
            _ActionBtn(icon: Icons.lock_outline, label: '挂失', color: Colors.red),
            const SizedBox(width: 12),
            _ActionBtn(icon: Icons.history, label: '流水', color: Colors.blue),
            const SizedBox(width: 12),
            _ActionBtn(icon: Icons.qr_code, label: '付款码', color: Colors.orange),
          ]),
          const SizedBox(height: 20),
          Card(child: Padding(padding: const EdgeInsets.all(16), child: Row(children: [
            const Icon(Icons.today, color: Colors.blue), const SizedBox(width: 12), const Text('今日消费'), const Spacer(),
            Text('23.50', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red)),
          ]))),
          const SizedBox(height: 16),
          Text('最近交易', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
          ...MockData.cardTransactions.take(6).map((t) => Card(margin: const EdgeInsets.only(bottom: 6),
            child: ListTile(dense: true,
              leading: CircleAvatar(radius: 18, backgroundColor: (t.isIncome ? Colors.green : Colors.orange).withAlpha(26),
                child: Icon(t.isIncome ? Icons.add_card : Icons.shopping_cart_checkout, size: 18, color: t.isIncome ? Colors.green : Colors.orange)),
              title: Text(t.location, style: const TextStyle(fontSize: 14)),
              subtitle: Text(t.time, style: const TextStyle(fontSize: 11)),
              trailing: Text('${t.isIncome ? '+' : '-'}${t.amount.toStringAsFixed(1)}',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: t.isIncome ? Colors.green : Colors.red.shade600))))),
        ],
      ),
    );
  }
}

class _CardFace extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(colors: [Color(0xFF1A237E), Color(0xFF283593), Color(0xFF3949AB)],
          begin: Alignment.topLeft, end: Alignment.bottomRight),
        boxShadow: [BoxShadow(color: Colors.blue.withAlpha(77), blurRadius: 20, offset: Offset(0, 8))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const Icon(Icons.credit_card, color: Colors.white70, size: 28), const Spacer(),
          Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: Colors.white.withAlpha(51), borderRadius: BorderRadius.circular(12)),
            child: const Text('学生卡', style: TextStyle(color: Colors.white, fontSize: 12))),
        ]),
        const SizedBox(height: 24),
        const Text('余额', style: TextStyle(color: Colors.white70, fontSize: 13)),
        const SizedBox(height: 4),
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          const Text('186.50', style: TextStyle(color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold)),
          const SizedBox(width: 8),
          const Padding(padding: EdgeInsets.only(bottom: 6), child: Text('元', style: TextStyle(color: Colors.white70, fontSize: 14))),
        ]),
        const SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          _infoRow('姓名', '张同学'), _infoRow('学号', '20241234'), _infoRow('院系', '计算机'),
        ]),
      ]),
    );
  }
  Widget _infoRow(String label, String value) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(label, style: const TextStyle(color: Colors.white54, fontSize: 11)),
    const SizedBox(height: 2),
    Text(value, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500)),
  ]);
}

class _ActionBtn extends StatelessWidget {
  final IconData icon; final String label; final Color color;
  const _ActionBtn({required this.icon, required this.label, required this.color});
  @override
  Widget build(BuildContext context) => Expanded(
    child: Card(child: InkWell(borderRadius: BorderRadius.circular(12), onTap: () {},
      child: Padding(padding: const EdgeInsets.symmetric(vertical: 14),
        child: Column(children: [Icon(icon, color: color, size: 28), const SizedBox(height: 6),
          Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade700))])))));
}
