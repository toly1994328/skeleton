import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SwitchTabs extends StatelessWidget {
  final List<Map<String, String>> data;
  final String activeTab;
  final ValueChanged<String> onTabChanged;

  const SwitchTabs({
    Key? key,
    required this.data,
    required this.activeTab,
    required this.onTabChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoSegmentedControl<String>(
        groupValue: activeTab,
        onValueChanged: onTabChanged,
        padding: const EdgeInsets.only(top: 20),
        children: _buildMap(data));
  }

  Map<String, Widget> _buildMap(List<Map<String, String>> data) {
    Map<String, Widget> result = {};
    for (int i = 0; i < data.length; i++) {
      result[data[i]['file']!] = Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Text(data[i]['title']!),
      );
    }
    return result;
  }
}
