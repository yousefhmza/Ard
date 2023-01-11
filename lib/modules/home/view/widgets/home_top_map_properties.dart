import 'package:ared/core/view/widgets/custom_chip.dart';
import 'package:flutter/material.dart';

class HomeTopMapTaps extends StatefulWidget {
  const HomeTopMapTaps({super.key});

  @override
  State<HomeTopMapTaps> createState() => _HomeTopMapTapsState();
}

class _HomeTopMapTapsState extends State<HomeTopMapTaps> {
  String selectedCategory = "الكل";
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...["الكل", "سكنى", "تجارى", "زراعى", "صناعى"].map((e) {
              return Container(
                margin: EdgeInsets.symmetric(horizontal: 8),
                child: CustomChip(
                  label: e,
                  isSelected: selectedCategory == e,
                  backgroundColor: Color(0xffF3F3F3),
                  borderColor: Color(0xffF3F3F3),
                  onSelected: () {
                    selectedCategory = e;
                    setState(() {});
                  },
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}
