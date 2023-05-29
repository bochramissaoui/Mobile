import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectedItemsRow extends StatefulWidget {
  final List<String> selectedCategories;
  final List<String> selectedSubcategories;
  final Function(List<String>, List<String>) onApplyFilter;

  SelectedItemsRow({
    required this.selectedCategories,
    required this.selectedSubcategories,
    required this.onApplyFilter,
  });

  @override
  _SelectedItemsRowState createState() => _SelectedItemsRowState();
}

class _SelectedItemsRowState extends State<SelectedItemsRow> {
  void _removeCategory(String category) {
    setState(() {
      widget.selectedCategories.remove(category);
      widget.selectedSubcategories.removeWhere((subcategory) =>
      subcategory.startsWith('${category}_') ||
          subcategory == category);
      widget.onApplyFilter(
          widget.selectedCategories, widget.selectedSubcategories);
    });
  }

  void _removeSubcategory(String subcategory) {
    setState(() {
      widget.selectedSubcategories.remove(subcategory);
      widget.onApplyFilter(
          widget.selectedCategories, widget.selectedSubcategories);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Row(
          children: [
            for (String category in widget.selectedCategories)
              SelectedItem(
                text: category,
                onDelete: () => _removeCategory(category),
              ),
            for (String subcategory in widget.selectedSubcategories)
              SelectedItem(
                text: subcategory,
                onDelete: () => _removeSubcategory(subcategory),
              ),
          ],
        ),
      ),
    );
  }
}

class SelectedItem extends StatelessWidget {
  final String text;
  final VoidCallback onDelete;

  SelectedItem({required this.text, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10),
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: Colors.white,
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          const Icon(Icons.coffee),
          const SizedBox(width: 10),
          Center(
            child: Text(
              text,
              style: GoogleFonts.montserrat(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: onDelete,
          ),
          const SizedBox(width: 10),
        ],
      ),
    );
  }
}
