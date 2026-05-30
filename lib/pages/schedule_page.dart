import 'package:flutter/material.dart';
import '../models/school_data.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('课程表'), centerTitle: true),
      body: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: Padding(padding: const EdgeInsets.all(8),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _buildHeader(theme), _buildGrid(theme),
            ]),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(ThemeData theme) {
    const weekdays = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
    return Row(children: [
      const SizedBox(width: 52, child: Center(child: Text('节次', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)))),
      ...weekdays.map((d) => SizedBox(width: 90, child: Center(child: Text(d, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold))))),
    ]);
  }

  Widget _buildGrid(ThemeData theme) {
    final allCourses = MockData.courses;
    return Column(children: List.generate(10, (slotIndex) {
      final slot = slotIndex + 1;
      return Container(height: 48,
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: theme.dividerColor.withAlpha(77)))),
        child: Row(children: [
          SizedBox(width: 52, child: Center(child: Text('$slot', style: TextStyle(fontSize: 11, color: theme.colorScheme.onSurface.withAlpha(128))))),
          ...List.generate(7, (dayIndex) {
            final day = dayIndex + 1;
            final courses = allCourses.where((c) => c.dayOfWeek == day && slot >= c.startSlot && slot < c.startSlot + c.duration).toList();
            if (courses.isEmpty) {
              return SizedBox(width: 90, child: Container(margin: const EdgeInsets.all(1),
                decoration: BoxDecoration(color: theme.colorScheme.surfaceContainerHighest.withAlpha(77), borderRadius: BorderRadius.circular(4))));
            }
            final c = courses.first;
            if (slot != c.startSlot) return const SizedBox(width: 90);
            final color = Colors.primaries[c.name.hashCode % Colors.primaries.length];
            return SizedBox(width: 90, child: Container(margin: const EdgeInsets.all(1), padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 1),
              decoration: BoxDecoration(color: color.withAlpha(217), borderRadius: BorderRadius.circular(4)),
              child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(c.name, style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold), maxLines: 1, overflow: TextOverflow.ellipsis),
                Text(c.classroom, style: TextStyle(color: Colors.white.withAlpha(200), fontSize: 8), maxLines: 1, overflow: TextOverflow.ellipsis),
              ])));
          }),
        ]));
    }));
  }
}
