import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../db/app_db.dart';
import '../models/enums.dart';
import '../providers/providers.dart';
import '../widgets/common.dart';

final _searchProvider = StateProvider<String>((ref) => '');
final _typeFilterProvider = StateProvider<String?>((ref) => null);
final _favOnlyProvider = StateProvider<bool>((ref) => false);

class CardsPage extends ConsumerWidget {
  const CardsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cards =
        ref.watch(cardsProvider).valueOrNull ?? const <KnowledgeCard>[];
    final query = ref.watch(_searchProvider);
    final typeFilter = ref.watch(_typeFilterProvider);
    final favOnly = ref.watch(_favOnlyProvider);

    final q = query.trim().toLowerCase();
    final filtered = cards.where((c) {
      if (typeFilter != null && c.cardType != typeFilter) return false;
      if (favOnly && !c.favorite) return false;
      if (q.isNotEmpty) {
        final hit = c.title.toLowerCase().contains(q) ||
            c.content.toLowerCase().contains(q) ||
            c.tags.toLowerCase().contains(q);
        if (!hit) return false;
      }
      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('知识卡片'),
        actions: [
          IconButton(
            tooltip: '只看收藏',
            icon: Icon(favOnly ? Icons.star : Icons.star_border),
            onPressed: () =>
                ref.read(_favOnlyProvider.notifier).state = !favOnly,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push('/cards/new'),
        icon: const Icon(Icons.add),
        label: const Text('记卡片'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: TextField(
              onChanged: (v) => ref.read(_searchProvider.notifier).state = v,
              decoration: const InputDecoration(
                isDense: true,
                prefixIcon: Icon(Icons.search),
                hintText: '搜索标题 / 内容 / 标签',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: const Text('全部'),
                    selected: typeFilter == null,
                    visualDensity: VisualDensity.compact,
                    onSelected: (_) =>
                        ref.read(_typeFilterProvider.notifier).state = null,
                  ),
                ),
                for (final t in cardTypes)
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(t),
                      selected: typeFilter == t,
                      visualDensity: VisualDensity.compact,
                      onSelected: (_) =>
                          ref.read(_typeFilterProvider.notifier).state = t,
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            child: filtered.isEmpty
                ? const EmptyHint('还没有知识卡片。\n把行测公式、申论素材、面试题沉淀下来，考前翻一遍。')
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(12, 8, 12, 88),
                    itemCount: filtered.length,
                    itemBuilder: (context, i) {
                      final c = filtered[i];
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        child: ListTile(
                          leading: Icon(
                            switch (c.cardType) {
                              '行测公式' => Icons.calculate_outlined,
                              '申论素材' => Icons.article_outlined,
                              '面试题' => Icons.record_voice_over_outlined,
                              _ => Icons.lightbulb_outline,
                            },
                          ),
                          title: Text(c.title, maxLines: 1,
                              overflow: TextOverflow.ellipsis),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (c.content.isNotEmpty)
                                Text(c.content,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis),
                              const SizedBox(height: 4),
                              Text(
                                [
                                  c.cardType,
                                  ...c.tags
                                      .split(',')
                                      .map((t) => t.trim())
                                      .where((t) => t.isNotEmpty)
                                      .map((t) => '#$t'),
                                ].join('  '),
                                style: TextStyle(
                                    fontSize: 11,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: Icon(
                              c.favorite ? Icons.star : Icons.star_border,
                              color: c.favorite ? Colors.amber : null,
                            ),
                            onPressed: () async {
                              final db = ref.read(dbProvider);
                              await (db.update(db.knowledgeCards)
                                    ..where((k) => k.id.equals(c.id)))
                                  .write(KnowledgeCardsCompanion(
                                favorite: Value(!c.favorite),
                              ));
                            },
                          ),
                          onTap: () => context.push('/cards/${c.id}/edit'),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
