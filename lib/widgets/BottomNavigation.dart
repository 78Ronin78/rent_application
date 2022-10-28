import 'package:flutter/material.dart';
import 'package:rent_application/widgets/tab_item.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation({required this.currentTab, required this.onSelectTab});
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        // _buildItem(TabItem.rents),
        _buildItem(TabItem.notes),
        _buildItem(TabItem.messages),
        _buildItem(TabItem.guestform),
        _buildItem(TabItem.accounting),
        _buildItem(TabItem.archive),
      ],
      onTap: (index) => onSelectTab(
        TabItem.values[index + 1],
      ),
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem) {
    return BottomNavigationBarItem(
      icon: Icon(
        Icons.layers,
        color: _colorTabMatching(tabItem),
      ),
      label: tabName[tabItem],
    );
  }

  Color _colorTabMatching(TabItem item) {
    return currentTab == item ? Colors.blue : Colors.grey;
  }
}
