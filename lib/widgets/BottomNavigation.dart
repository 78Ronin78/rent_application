import 'package:flutter/material.dart';
import 'package:rent_application/widgets/tab_item.dart';

class BottomNavigation extends StatelessWidget {
  BottomNavigation(
      {required this.currentTab,
      required this.onSelectTab,
      required this.iconDataList});
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final List<IconData> iconDataList;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      type: BottomNavigationBarType.fixed,
      iconSize: 25,
      items: [
        // _buildItem(TabItem.rents),
        _buildItem(TabItem.notes, iconDataList[0]),
        _buildItem(TabItem.messages, iconDataList[1]),
        _buildItem(TabItem.guestform, iconDataList[2]),
        _buildItem(TabItem.accounting, iconDataList[3]),
        _buildItem(TabItem.archive, iconDataList[4]),
      ],
      onTap: (index) => onSelectTab(
        TabItem.values[index + 1],
      ),
    );
  }

  BottomNavigationBarItem _buildItem(TabItem tabItem, IconData iconItem) {
    return BottomNavigationBarItem(
        icon: Icon(
          iconItem,

          color: _colorTabMatching(tabItem),

          //size: 25,
        ),
        label: '' //tabName[tabItem],
        );
  }

  Color _colorTabMatching(TabItem item) {
    return currentTab == item ? Colors.blue : Colors.black;
  }
}
