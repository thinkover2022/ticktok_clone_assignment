import 'package:flutter/material.dart';
import 'package:ticktok_clone/constants/gaps.dart';
import 'package:ticktok_clone/features/main_navigation/views/report_sheet_screen.dart';

class BottomSheetScreen extends StatelessWidget {
  const BottomSheetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(56.0),
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: AppBar(
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Container(
              width: 60,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            BottomSheetButton(
              upText: "Unfollow",
              downText: "Mute",
              upOnTap: () {},
              downOnTap: () {},
            ),
            Gaps.v20,
            BottomSheetButton(
              upText: "Hide",
              downText: "Report",
              upOnTap: () {},
              downOnTap: () {
                showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return ReportSheetScreen();
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}

class BottomSheetButton extends StatefulWidget {
  const BottomSheetButton({
    super.key,
    required this.upText,
    required this.downText,
    required this.upOnTap,
    required this.downOnTap,
  });
  final String upText;
  final String downText;
  final void Function() upOnTap;
  final void Function() downOnTap;

  @override
  State<BottomSheetButton> createState() => _BottomSheetButtonState();
}

class _BottomSheetButtonState extends State<BottomSheetButton> {
  bool _isUpSelected = false;
  bool _isDownSelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    widget.upOnTap();
                    _isUpSelected = !_isUpSelected;
                    setState(() {});
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Text(
                      widget.upText,
                      style: TextStyle(
                        color: _isUpSelected ? Colors.red : Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                Container(
                  color: Colors.grey.shade500,
                  height: 1,
                ),
                GestureDetector(
                  onTap: () {
                    widget.downOnTap();
                    _isDownSelected = !_isDownSelected;
                    setState(() {});
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 20,
                    ),
                    child: Text(
                      widget.downText,
                      style: TextStyle(
                        color: _isDownSelected ? Colors.red : Colors.black,
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
