import 'package:flutter/material.dart';
import 'package:smart_glove/core/providers/search_provider.dart';
import 'package:smart_glove/features/therapist/therapist_dashboard/widgets/segmented_button.dart';

import '../../therapist_dashboard/widgets/filter_dropdown.dart';
import '../../therapist_dashboard/widgets/patient_table.dart';

class AllPatientsScreen extends StatefulWidget {
  const AllPatientsScreen({super.key});

  @override
  State<AllPatientsScreen> createState() => _AllPatientsScreenState();
}

class _AllPatientsScreenState extends State<AllPatientsScreen> {

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);


    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1.Title
          Text(
            "All Patients",
            style: theme.textTheme.displayMedium?.copyWith(
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30),

          // ==========================================
          // 2. Search bar
          // ==========================================
         _buildSearchbar(context),
          const SizedBox(height: 30),

          // ==========================================
          // 3. Custom Table
          buildPatientsTable()
          // ==========================================
        ],
      ),
    );
  }

  Widget _buildSearchbar(BuildContext context) {
    final theme = Theme.of(context);
    final cardColor = theme.cardTheme.color ?? Colors.white;
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: TextField(
            onChanged: (value) => setState(() => SearchProvider().updateSearchQuery(value)),
            decoration: InputDecoration(
              hintText: "Search by name or ID...",
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: cardColor,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
       FilterSegmentedButton()// buildFilterDropdown("Status: All", cardColor),
      ],
    );
  }}


