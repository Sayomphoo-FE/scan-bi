import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

/// A simple icon picker with two tabs: emoji and Material Icons
class IconPickerWidget extends StatefulWidget {
  final String iconType;
  final String iconValue;
  final void Function(String type, String value) onChanged;

  const IconPickerWidget({
    super.key,
    required this.iconType,
    required this.iconValue,
    required this.onChanged,
  });

  @override
  State<IconPickerWidget> createState() => _IconPickerWidgetState();
}

class _IconPickerWidgetState extends State<IconPickerWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  static const _emojis = [
    '💰', '🛒', '🍽️', '🚗', '🏠', '🏥', '📚', '✈️',
    '🎮', '💼', '🎁', '💳', '🔧', '💊', '🎵', '📱',
    '🧴', '🥩', '🥦', '🧀', '🍺', '☕', '⚽', '🎂',
  ];

  static const _materialIcons = <String, IconData>{
    'shopping_cart': Icons.shopping_cart,
    'restaurant': Icons.restaurant,
    'directions_car': Icons.directions_car,
    'home': Icons.home,
    'local_hospital': Icons.local_hospital,
    'school': Icons.school,
    'flight': Icons.flight,
    'sports_esports': Icons.sports_esports,
    'work': Icons.work,
    'attach_money': Icons.attach_money,
    'card_giftcard': Icons.card_giftcard,
    'credit_card': Icons.credit_card,
    'build': Icons.build,
    'local_pharmacy': Icons.local_pharmacy,
    'music_note': Icons.music_note,
    'smartphone': Icons.smartphone,
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    if (widget.iconType == 'material') {
      _tabController.index = 1;
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: Row(
              children: [
                const Text('Icon  '),
                // Preview current icon
                if (widget.iconType == 'emoji')
                  Text(widget.iconValue,
                      style: const TextStyle(fontSize: 24))
                else
                  Icon(
                    _materialIcons[widget.iconValue] ?? Icons.receipt,
                    size: 24,
                  ),
              ],
            ),
          ),
          TabBar(
            controller: _tabController,
            tabs: [
              Tab(text: AppLocalizations.of(context)!.emoji),
              Tab(text: AppLocalizations.of(context)!.material),
            ],
          ),
          SizedBox(
            height: 120,
            child: TabBarView(
              controller: _tabController,
              children: [
                // Emoji grid
                GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 8,
                    childAspectRatio: 1,
                  ),
                  itemCount: _emojis.length,
                  itemBuilder: (ctx, i) {
                    final emoji = _emojis[i];
                    final isSelected =
                        widget.iconType == 'emoji' &&
                        widget.iconValue == emoji;
                    return GestureDetector(
                      onTap: () => widget.onChanged('emoji', emoji),
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? theme.colorScheme.primaryContainer
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: Text(emoji,
                              style: const TextStyle(fontSize: 20)),
                        ),
                      ),
                    );
                  },
                ),
                // Material icons grid
                GridView.builder(
                  padding: const EdgeInsets.all(8),
                  gridDelegate:
                      const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 8,
                    childAspectRatio: 1,
                  ),
                  itemCount: _materialIcons.length,
                  itemBuilder: (ctx, i) {
                    final entry = _materialIcons.entries.elementAt(i);
                    final isSelected =
                        widget.iconType == 'material' &&
                        widget.iconValue == entry.key;
                    return GestureDetector(
                      onTap: () =>
                          widget.onChanged('material', entry.key),
                      child: Container(
                        margin: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? theme.colorScheme.primaryContainer
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Center(
                          child: Icon(entry.value, size: 20),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
