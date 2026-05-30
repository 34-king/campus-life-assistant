import 'package:flutter/material.dart';
import '../models/school_data.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});
  @override State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  late int _year, _month, _selectedDay;
  @override
  void initState() { super.initState(); final n = DateTime.now(); _year = n.year; _month = n.month; _selectedDay = n.day; }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final monthEvents = MockData.getEventsForMonth(_year, _month);
    final selDate = '$_year-${_month.toString().padLeft(2, '0')}-${_selectedDay.toString().padLeft(2, '0')}';
    final dayEvents = MockData.getEventsForDate(selDate);

    return Scaffold(
      appBar: AppBar(title: const Text('校历'), centerTitle: true,
        actions: [IconButton(icon: const Icon(Icons.today), onPressed: () { final n = DateTime.now(); setState(() { _year = n.year; _month = n.month; _selectedDay = n.day; }); })],
      ),
      body: Column(children: [
        Padding(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            IconButton(onPressed: () => setState(() { if (_month == 1) { _year--; _month = 12; } else { _month--; } _selectedDay = 1; }), icon: const Icon(Icons.chevron_left)),
            Text('$_year 年 $_month 月', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            IconButton(onPressed: () => setState(() { if (_month == 12) { _year++; _month = 1; } else { _month++; } _selectedDay = 1; }), icon: const Icon(Icons.chevron_right)),
          ]),
        ),
        Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(children: ['一','二','三','四','五','六','日'].map((d) =>
            Expanded(child: Center(child: Text(d, style: TextStyle(fontSize: 13, color: Colors.grey.shade600, fontWeight: FontWeight.w500))))).toList())),
        const SizedBox(height: 4),
        _buildGrid(theme, monthEvents),
        const SizedBox(height: 8),
        Expanded(child: Container(
          width: double.infinity,
          decoration: BoxDecoration(color: theme.colorScheme.surfaceContainerLow, borderRadius: const BorderRadius.vertical(top: Radius.circular(16))),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Padding(padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: Row(children: [
                Text('$_month月$_selectedDay日', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(width: 8),
                Text(_weekdayName(DateTime(_year, _month, _selectedDay).weekday), style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
              ])),
            if (dayEvents.isEmpty)
              Padding(padding: const EdgeInsets.all(16), child: Center(child: Column(children: [
                Icon(Icons.event_busy, size: 40, color: Colors.grey.shade300),
                const SizedBox(height: 8), Text('今天没有安排', style: TextStyle(color: Colors.grey.shade400, fontSize: 14)),
              ])))
            else
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  children: dayEvents.map(_buildEventCard).toList(),
                ),
              ),
          ]),
        )),
      ]),
    );
  }

  Widget _buildGrid(ThemeData theme, List<CalendarEvent> monthEvents) {
    final firstDay = DateTime(_year, _month, 1);
    final startWeekday = firstDay.weekday;
    final daysInMonth = DateTime(_year, _month + 1, 0).day;
    final today = DateTime.now();
    final eventDays = monthEvents.map((e) => int.tryParse(e.date.split('-').last) ?? 0).toSet();
    final cells = <Widget>[];
    for (int i = 1; i < startWeekday; i++) cells.add(const SizedBox());
    for (int day = 1; day <= daysInMonth; day++) {
      final isToday = today.year == _year && today.month == _month && today.day == day;
      final isSel = day == _selectedDay;
      final hasEvent = eventDays.contains(day);
      cells.add(GestureDetector(onTap: () => setState(() => _selectedDay = day),
        child: Container(margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(color: isSel ? theme.colorScheme.primary : isToday ? theme.colorScheme.primary.withAlpha(26) : null, borderRadius: BorderRadius.circular(8)),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text('$day', style: TextStyle(fontSize: 14, fontWeight: isToday ? FontWeight.bold : FontWeight.normal, color: isSel ? Colors.white : isToday ? theme.colorScheme.primary : null)),
            if (hasEvent) Container(width: 5, height: 5, decoration: BoxDecoration(color: isSel ? Colors.white : theme.colorScheme.primary, shape: BoxShape.circle)),
          ]))));
    }
    return Padding(padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GridView.count(crossAxisCount: 7, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), childAspectRatio: 1.1, children: cells));
  }

  String _weekdayName(int d) { const n = ['', '周一', '周二', '周三', '周四', '周五', '周六', '周日']; return n[d]; }
  IconData _eventIcon(String t) { switch (t) { case 'holiday': return Icons.celebration; case 'exam': return Icons.assignment; case 'activity': return Icons.stars; default: return Icons.school; } }
  Color _eventColor(String t) { switch (t) { case 'holiday': return Colors.green; case 'exam': return Colors.red; case 'activity': return Colors.orange; default: return Colors.blue; } }
  String _eventLabel(String t) { switch (t) { case 'holiday': return '假期'; case 'exam': return '考试'; case 'activity': return '活动'; default: return '教务'; } }

  Widget _buildEventCard(CalendarEvent e) {
    return Card(margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: Icon(_eventIcon(e.type), color: _eventColor(e.type)),
        title: Text(e.title),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(color: _eventColor(e.type).withAlpha(26), borderRadius: BorderRadius.circular(6)),
          child: Text(_eventLabel(e.type), style: TextStyle(fontSize: 11, color: _eventColor(e.type), fontWeight: FontWeight.w500)),
        ),
      ),
    );
  }
}
