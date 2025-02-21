import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ticktok_clone/constants/gaps.dart';
import 'package:ticktok_clone/constants/sizes.dart';

class InterestScreen2 extends StatefulWidget {
  const InterestScreen2({super.key});

  @override
  State<InterestScreen2> createState() => _InterestScreen2State();
}

class _InterestScreen2State extends State<InterestScreen2> {
  // 카테고리 데이터 구조 단순화
  final Map<String, List<String>> categories = {
    "Music": [
      "Rap", "R&B & soul", "Grammy Awards", "Pop",
      "K-pop", "Music industry", "EDM", "Music news",
      "Hip hop", "Reggae", "Hip Reggae", "Jazze", "Classic",
    ],
    "Entertainment": [
      "Anime", "Movies & TV", "Harry Potter",
      "Marvel Universe", "Movie news", "Naruto",
      "Movies", "Grammy Awards", "Entertainment",
    ],
  };

  // 선택된 항목 관리를 Set으로 단순화
  final Set<String> selectedItems = {};

  bool isNextBtnActive() => selectedItems.length >= 3;

  // 카테고리 섹션 위젯
  Widget _buildCategorySection(String title, List<String> items) {
    // 아이템들을 3개의 행으로 균등하게 분배
    final itemsPerRow = (items.length / 3).ceil();
    final rows = List.generate(3, (index) {
      final start = index * itemsPerRow;
      final end = (start + itemsPerRow).clamp(0, items.length);
      return items.sublist(start, end);
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gaps.v20,
        const Divider(color: Colors.grey, thickness: 1, height: 20),
        Gaps.v20,
        Text(
          title,
          style: const TextStyle(
            fontSize: Sizes.size32,
            fontWeight: FontWeight.w700,
          ),
        ),
        Gaps.v20,
        // 3개의 행을 for 루프로 생성
        for (final rowItems in rows)
          Container(
            height: 50,
            margin: const EdgeInsets.only(bottom: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // 각 행의 아이템들을 for 루프로 생성
                  for (final item in rowItems)
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: _buildInterestChip(item),
                    ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  // 관심사 칩 위젯
  Widget _buildInterestChip(String label) {
    final isSelected = selectedItems.contains(label);
    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedItems.remove(label);
          } else {
            selectedItems.add(label);
          }
        });
      },
      child: Chip(
        label: Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: isSelected ? Colors.white : Colors.black,
          ),
        ),
        backgroundColor: isSelected ? Colors.blue : Colors.white,
        side: BorderSide(color: Colors.grey.shade400),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: Sizes.size36),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: SvgPicture.asset('assets/images/twitter-logo.svg'),
                    ),
                  ],
                ),
                Gaps.v40,
                Text(
                  "What do you want to see on Twitter?",
                  style: TextStyle(
                    fontSize: Sizes.size32,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Gaps.v20,
                Text(
                  "Interests are used to personalize your experience and will be visible on your profile.",
                  style: TextStyle(
                    fontSize: Sizes.size24,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                
                for (var entry in categories.entries)
                  _buildCategorySection(entry.key, entry.value),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${selectedItems.length} of ${categories.values.expand((e) => e).length} selected',
                style: const TextStyle(fontSize: 16),
              ),
              ElevatedButton(
                onPressed: isNextBtnActive()
                    ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Container()),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(100.0, 48.0),
                  backgroundColor: isNextBtnActive() ? Colors.black : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 16,
                    color: isNextBtnActive() ? Colors.white : Colors.grey.shade200,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
