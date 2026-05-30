// [AI-GEN] Grade query with GPA calculation.
import 'package:flutter/material.dart';
import '../models/school_data.dart';

class GradePage extends StatefulWidget {
  const GradePage({super.key});
  @override State<GradePage> createState() => _GradePageState();
}

class _GradePageState extends State<GradePage> {
  late String _selectedSemester;
  @override
  void initState() { super.initState(); _selectedSemester = MockData.semesters.last; }

  @override
  Widget build(BuildContext context) {
    final records = MockData.getGradesBySemester(_selectedSemester);
    final gpa = MockData.calculateGPA(records);
    final totalCredits = records.fold<double>(0, (s, r) => s + r.credit);
    final avgScore = records.isEmpty ? 0.0 : records.fold<double>(0, (s, r) => s + r.score) / records.length;

    return Scaffold(
      appBar: AppBar(title: const Text('成绩查询'), centerTitle: true,
        actions: [PopupMenuButton<String>(icon: const Icon(Icons.calendar_view_week),
          onSelected: (s) => setState(() => _selectedSemester = s),
          itemBuilder: (_) => MockData.semesters.map((s) => PopupMenuItem(value: s, child: Text(s == _selectedSemester ? '  $s' : s))).toList())]),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        Card(child: Padding(padding: const EdgeInsets.all(20), child: Column(children: [
          Text(_selectedSemester, style: TextStyle(color: Colors.grey.shade600, fontSize: 13)),
          const SizedBox(height: 16),
          Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            _StatItem(label: 'GPA', value: gpa.toStringAsFixed(2), color: Colors.blue),
            _StatItem(label: '平均分', value: avgScore.toStringAsFixed(1), color: Colors.green),
            _StatItem(label: '总学分', value: totalCredits.toStringAsFixed(1), color: Colors.orange),
            _StatItem(label: '课程数', value: '${records.length}', color: Colors.purple),
          ]),
        ]))),
        const SizedBox(height: 16),
        ...List.generate(records.length, (i) {
          final r = records[i];
          return Card(margin: const EdgeInsets.only(bottom: 8),
            child: Padding(padding: const EdgeInsets.all(14),
              child: Row(children: [
                SizedBox(width: 48, height: 48, child: Stack(alignment: Alignment.center, children: [
                  CircularProgressIndicator(value: r.score / 100, strokeWidth: 3,
                    backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
                    valueColor: AlwaysStoppedAnimation<Color>(_scoreColor(r.score))),
                  Text('${r.score.toInt()}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: _scoreColor(r.score))),
                ])),
                const SizedBox(width: 14),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text(r.courseName, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
                  Text('${r.credit}学分', style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
                ])),
                Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: _scoreColor(r.score).withAlpha(26), borderRadius: BorderRadius.circular(6)),
                  child: Text(_gradeLabel(r.score), style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: _scoreColor(r.score)))),
              ])),
            );
        }),
      ]),
    );
  }

  Color _scoreColor(double s) { if (s >= 90) return Colors.green; if (s >= 80) return Colors.blue; if (s >= 70) return Colors.orange; if (s >= 60) return Colors.red.shade400; return Colors.red; }
  String _gradeLabel(double s) { if (s >= 90) return '优秀'; if (s >= 80) return '良好'; if (s >= 70) return '中等'; if (s >= 60) return '及格'; return '不及格'; }
}

class _StatItem extends StatelessWidget {
  final String label, value; final Color color;
  const _StatItem({required this.label, required this.value, required this.color});
  @override
  Widget build(BuildContext context) => Column(children: [
    Text(value, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: color)),
    const SizedBox(height: 2),
    Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
  ]);
}
