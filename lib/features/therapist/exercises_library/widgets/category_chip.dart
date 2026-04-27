import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_glove/features/therapist/logic/category_provider.dart';

class buildCategoryChip extends StatefulWidget {
  final String label;

  buildCategoryChip({super.key, required this.label});

  @override
  State<buildCategoryChip> createState() => _buildCategoryChipState();
}

class _buildCategoryChipState extends State<buildCategoryChip> {
  @override
  Widget build(BuildContext context) {
    String selectedCategory = context.watch<CategoryProvider>().selectCategory;
    bool isSelected = selectedCategory == widget.label;
    final theme = Theme.of(context);
    return ChoiceChip(
      label: Text(
        widget.label,
        style: TextStyle(
          color: isSelected ? Colors.white : theme.textTheme.bodyMedium?.color,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedColor: theme.primaryColor,
      backgroundColor: theme.cardTheme.color,
      side: BorderSide(
        color: isSelected ? theme.primaryColor : Colors.grey.withOpacity(0.2),
      ),
      onSelected: (bool selected) => setState(
        () {
          context.read<CategoryProvider>().updateSelectedCategory(widget.label);
          context.read<CategoryProvider>().updateFilteredExercises();
        }
      ),
    );
  }
}
