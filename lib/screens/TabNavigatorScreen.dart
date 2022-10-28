import 'package:flutter/material.dart';
import 'package:rent_application/widgets/BottomNavigation.dart';
import 'package:rent_application/widgets/tab_item.dart';

class TabNavigatorScreen extends StatefulWidget {
  const TabNavigatorScreen({super.key});

  @override
  State<TabNavigatorScreen> createState() => _TabNavigatorScreenState();
}

class _TabNavigatorScreenState extends State<TabNavigatorScreen> {
  var _currentTab = TabItem.rents;

  void _selectTab(TabItem tabItem) {
    setState(() => _currentTab = tabItem);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: BottomNavigation(
        currentTab: _currentTab,
        onSelectTab: _selectTab,
      ),
    );
  }

  Widget _buildBody() {
    return Container();
  }
}
