import 'package:flutter/material.dart';

enum FilterStatus { all, active, completed }

class FilterSegmentedButton extends StatefulWidget {
  const FilterSegmentedButton({super.key});

  @override
  State<FilterSegmentedButton> createState() => _FilterSegmentedButtonState();
}

class _FilterSegmentedButtonState extends State<FilterSegmentedButton> {
  FilterStatus selectedFilter = FilterStatus.all;

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<FilterStatus>(
      segments: const <ButtonSegment<FilterStatus>>[
        ButtonSegment<FilterStatus>(
          value: FilterStatus.all,
          label: Text('All'),
          icon: Icon(Icons.list),
        ),
        ButtonSegment<FilterStatus>(
          value: FilterStatus.active,
          label: Text('Active'),
          icon: Icon(Icons.bolt),
        ),
        ButtonSegment<FilterStatus>(
          value: FilterStatus.completed,
          label: Text('Completed'),
          icon: Icon(Icons.check_circle),
        ),
      ],
      selected: <FilterStatus>{selectedFilter},
      onSelectionChanged: (Set<FilterStatus> newSelection) {
        setState(() {
          selectedFilter = newSelection.first;
          // هنا تضعين دالة الفلترة الخاصة بكِ
        });
      },
      style: SegmentedButton.styleFrom(
        selectedBackgroundColor: Theme.of(context).primaryColor,
        selectedForegroundColor: Colors.white,
      ),
    );
  }
}