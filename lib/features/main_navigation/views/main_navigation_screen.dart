import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:ticktok_clone/constants/gaps.dart';
import 'package:ticktok_clone/features/main_navigation/widgets/nav_tab.dart';

class MainNavigationScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  final Widget child;
  const MainNavigationScreen(
      {super.key, required this.cameras, required this.child});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  final List<bool> _isMenuSelected = [false, false, false, false];
  String _query = "";
  String _titleAppBar = "";
  bool _isAppBarVisible = true;
  int _selectedIndex = 0;
  void _toggleAppBar(bool isVisible) {
    if (_isAppBarVisible != isVisible) {
      setState(() {
        _isAppBarVisible = isVisible;
      });
    }
  }

  void _onTap(int index) {
    switch (index) {
      case 0:
        context.go('/', extra: _toggleAppBar);
        break;
      case 1:
        _titleAppBar = "Search";
        context.go('/search', extra: _query);
        break;
      case 2:
        _titleAppBar = "New thread";
        context.go('/write');
        break;
      case 3:
        _titleAppBar = "Activity";
        context.go('/activity');
        break;
      case 4:
        context.go('/profile');
        break;
    }
    setState(() {
      _selectedIndex = index;
    });
  }

  AppBar _getAppBar(BuildContext context) {
    if (_selectedIndex == 1) {
      return AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Search",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gaps.v10,
              CupertinoSearchTextField(
                placeholder: "Search",
                onChanged: (value) {
                  setState(() {
                    _query = value;
                  });
                },
                backgroundColor: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(10),
              ),
            ],
          ),
        ),
      );
    } else if (_selectedIndex == 2) {
      return AppBar(
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(1.0),
            child: Container(
              color: Colors.grey.shade300,
              height: 1.0,
            )),
        leadingWidth: 100,
        leading: Center(
          child: TextButton(
            onPressed: () => _onTap(0),
            child: Text(
              "Cancel",
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
        centerTitle: true,
        title: Text(
          _titleAppBar,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      );
    } else if (_selectedIndex == 3) {
      List<String> menus = ["All", "Replies", "Mentions", "Likes"];
      return AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        flexibleSpace: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Activity",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gaps.v10,
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: menus.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _isMenuSelected[index] = !_isMenuSelected[index];
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5, vertical: 5),
                            width: 100,
                            decoration: BoxDecoration(
                                color: _isMenuSelected[index]
                                    ? Colors.black
                                    : Colors.white,
                                border: Border.fromBorderSide(BorderSide(
                                  color: Colors.grey.shade300,
                                  width: 2,
                                )),
                                borderRadius: BorderRadius.circular(20)),
                            child: Center(
                                child: Text(
                              menus[index],
                              style: TextStyle(
                                  color: _isMenuSelected[index]
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 18,
                                  height: 1),
                            )),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      );
    } else if (_selectedIndex == 4) {
      return AppBar(
        flexibleSpace: Container(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.public,
                size: 40,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/instagram-logo.svg',
                    width: 46,
                  ),
                  Gaps.h10,
                  const Icon(
                    Icons.menu,
                    size: 40,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    } else {
      return AppBar(
        title: Center(
          child: FaIcon(FontAwesomeIcons.threads),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.go("/", extra: _toggleAppBar);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _isAppBarVisible
          ? PreferredSize(
              preferredSize: Size.fromHeight(100),
              child: SafeArea(child: _getAppBar(context)))
          : null,
      body: widget.child,
      bottomNavigationBar: BottomAppBar(
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          NavTab(
            text: "홈",
            isSelected: _selectedIndex == 0,
            icon: FontAwesomeIcons.house,
            onTap: () {
              _onTap(0);
            },
          ),
          NavTab(
            text: "검색",
            isSelected: _selectedIndex == 1,
            icon: FontAwesomeIcons.magnifyingGlass,
            onTap: () => _onTap(1),
          ),
          NavTab(
            text: "글쓰기",
            isSelected: _selectedIndex == 2,
            icon: FontAwesomeIcons.penToSquare,
            onTap: () => _onTap(2),
          ),
          NavTab(
            text: "알림",
            isSelected: _selectedIndex == 3,
            icon: FontAwesomeIcons.heart,
            onTap: () => _onTap(3),
          ),
          NavTab(
            text: "프로필",
            isSelected: _selectedIndex == 4,
            icon: FontAwesomeIcons.user,
            onTap: () => _onTap(4),
          ),
        ]),
      ),
    );
  }
}
