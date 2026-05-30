import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/school_data.dart';
import '../providers/favorites_provider.dart';

class NoticePage extends StatelessWidget {
  const NoticePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('校园公告')),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: MockData.notices.length,
        itemBuilder: (context, index) => _NoticeCard(notice: MockData.notices[index]),
      ),
    );
  }
}

class _NoticeCard extends StatelessWidget {
  final Notice notice;
  const _NoticeCard({required this.notice});
  @override
  Widget build(BuildContext context) {
    return Consumer<FavoritesProvider>(builder: (context, favs, _) {
      final isFav = favs.isNoticeFavorited(notice.title);
      return Card(margin: const EdgeInsets.only(bottom: 10),
        child: InkWell(borderRadius: BorderRadius.circular(12), onTap: () => _showDetail(context),
          child: Padding(padding: const EdgeInsets.all(14),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(color: Colors.blue.withAlpha(26), borderRadius: BorderRadius.circular(4)),
                  child: Text(notice.category, style: const TextStyle(color: Colors.blue, fontSize: 11))),
                const SizedBox(width: 8),
                Text(notice.date, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                const Spacer(),
                IconButton(constraints: const BoxConstraints(), padding: EdgeInsets.zero, iconSize: 20,
                  icon: Icon(isFav ? Icons.bookmark : Icons.bookmark_border, color: isFav ? Colors.blue : Colors.grey),
                  onPressed: () => favs.toggleNoticeFavorite(notice.title)),
              ]),
              const SizedBox(height: 8),
              Text(notice.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              Text(notice.content, maxLines: 2, overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600)),
            ]))),
        );
    });
  }

  void _showDetail(BuildContext context) {
    showModalBottomSheet(context: context, isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (_) => DraggableScrollableSheet(initialChildSize: 0.6, maxChildSize: 0.85, minChildSize: 0.4, expand: false,
        builder: (_, scrollController) => Padding(padding: const EdgeInsets.all(20),
          child: ListView(controller: scrollController, children: [
            Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2)))),
            const SizedBox(height: 16),
            Text(notice.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Row(children: [Text(notice.category, style: const TextStyle(color: Colors.blue)), const SizedBox(width: 12), Text(notice.date, style: const TextStyle(color: Colors.grey))]),
            const Divider(height: 24),
            Text(notice.content, style: const TextStyle(fontSize: 15, height: 1.7)),
          ]),
        ),
      ),
    );
  }
}
