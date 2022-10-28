import 'package:flutter/material.dart';

enum TabItem { rents, notes, messages, guestform, accounting, archive }

const Map<TabItem, String> tabName = {
  TabItem.rents: 'rents',
  TabItem.notes: 'notes',
  TabItem.messages: 'messages',
  TabItem.guestform: 'guestform',
  TabItem.accounting: 'accounting',
  TabItem.archive: 'archive'
};
