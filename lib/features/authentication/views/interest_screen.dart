import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ticktok_clone/constants/gaps.dart';
import 'package:ticktok_clone/constants/sizes.dart';
import 'package:ticktok_clone/features/authentication/views/interest_screen2.dart';

class InterestScreen extends StatefulWidget {
  const InterestScreen({super.key});

  @override
  State<InterestScreen> createState() => _InterestScreenState();
}

class _InterestScreenState extends State<InterestScreen> {
  final List<String> categories = [
    'Fashion & beauty',
    'Outdoors',
    'Arts & culture',
    'Animation & comics',
    'Business & finance',
    'Food',
    'Travel',
    'Entertainment',
    'Music',
    'Gaming',
    'Soccor',
    'Baseball',
    'Vallyball',
    'Baskitball',
  ];
  int selectedCnt = 0;
  late final List<bool> isSelecteds =
      List.generate(categories.length, (idx) => false);
  bool isNextBtnActive() {
    if (selectedCnt < 3) return false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Sizes.size36,
          ),
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
                "Select at least 3 interests to personalize your Twitter experience. They will be visible on your profile.",
                style: TextStyle(
                  fontSize: Sizes.size24,
                  fontWeight: FontWeight.w300,
                ),
              ),
              Gaps.v20,
              Divider(
                color: Colors.grey,
                thickness: 2,
                height: 20,
              ),
              Gaps.v20,
              Expanded(
                child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 한 줄에 2개의 아이템
                      crossAxisSpacing: 16.0,
                      mainAxisSpacing: 16.0,
                      childAspectRatio: 2.5, // 각 아이템의 가로세로 비율
                    ),
                    itemCount: categories.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            isSelecteds[index] = !isSelecteds[index];
                            selectedCnt = isSelecteds.where((e) => e).length;
                          });
                        },
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: isSelecteds[index]
                                  ? Colors.blue
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withValues(alpha: 0.3),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ]),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomLeft,
                                child: Text(
                                  categories[index],
                                  style: TextStyle(
                                      color: isSelecteds[index]
                                          ? Colors.white
                                          : Colors.black,
                                      fontSize: Sizes.size18,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                              if (isSelecteds[index])
                                Positioned(
                                  top: 8,
                                  right: 8,
                                  child: Icon(
                                    Icons.check_circle,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
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
                '$selectedCnt of ${isSelecteds.length} selected',
                style: TextStyle(fontSize: 16),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return InterestScreen2();
                  }));
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(100.0, 48.0),
                  backgroundColor:
                      isNextBtnActive() ? Colors.black : Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 16,
                    color:
                        isNextBtnActive() ? Colors.white : Colors.grey.shade200,
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
