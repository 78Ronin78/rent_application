import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rent_application/widgets/BottomNavigation.dart';
import 'package:rent_application/widgets/tab_item.dart';
import 'package:rent_application/widgets/tab_navigator.dart';

class TabNavigatorScreen extends StatefulWidget {
  const TabNavigatorScreen({super.key});

  @override
  State<TabNavigatorScreen> createState() => _TabNavigatorScreenState();
}

class _TabNavigatorScreenState extends State<TabNavigatorScreen> {
  var _currentTab = TabItem.rents;
  final _navigatorKeys = {
    TabItem.rents: GlobalKey<NavigatorState>(),
    TabItem.notes: GlobalKey<NavigatorState>(),
    TabItem.messages: GlobalKey<NavigatorState>(),
    TabItem.guestform: GlobalKey<NavigatorState>(),
    TabItem.accounting: GlobalKey<NavigatorState>(),
    TabItem.archive: GlobalKey<NavigatorState>(),
  };

  List<IconData> _iconDataList = [
    CupertinoIcons.doc_plaintext,
    Icons.mail_outline,
    Icons.add_circle_outline,
    Icons.calculate_outlined,
    Icons.search
  ];

  void _selectTab(TabItem tabItem) {
    if (tabItem == _currentTab) {
      // pop to first route
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
            !await _navigatorKeys[_currentTab]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (_currentTab != TabItem.rents) {
            // select 'main' tab
            _selectTab(TabItem.rents);
            // back button handled by app
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
          body: Stack(children: <Widget>[
            _buildOffstageNavigator(TabItem.rents),
            _buildOffstageNavigator(TabItem.notes),
            _buildOffstageNavigator(TabItem.messages),
            _buildOffstageNavigator(TabItem.guestform),
            _buildOffstageNavigator(TabItem.accounting),
            _buildOffstageNavigator(TabItem.archive),
          ]),
          bottomNavigationBar: BottomNavigation(
            currentTab: _currentTab,
            onSelectTab: _selectTab,
            iconDataList: _iconDataList,
          )),
    );
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem]!,
        tabItem: tabItem,
      ),
    );
  }
}
