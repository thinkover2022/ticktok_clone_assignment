import 'package:flutter/material.dart';
import 'package:faker/faker.dart';

import 'package:ticktok_clone/features/main_navigation/models/post.dart';
import 'package:ticktok_clone/features/main_navigation/widgets/post_item.dart';

class HomeScreen extends StatefulWidget {
  final Function(bool) toggleAppBar;
  const HomeScreen({super.key, required this.toggleAppBar});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  bool _isAppBarVisible = true;
  final List<Post> posts = List.generate(10, (index) {
    return Post(
      likeCnt: "${faker.randomGenerator.integer(100)} likes",
      replyCnt: "${faker.randomGenerator.integer(100)} replies",
      uploadTime: "${faker.randomGenerator.integer(24)}h",
      avatarUrl: "https://i.pravatar.cc/150?img=${index + 1}",
      followUrls: List.generate(3, (index) {
        return "https://i.pravatar.cc/150?img=${faker.randomGenerator.integer(30) + 1}";
      }),
      userName: faker.person.name(),
      text: faker.lorem.sentence(),
      imageUrls: index % 2 == 1
          ? List.generate(3, (index) {
              return "https://picsum.photos/300/200?random=${faker.randomGenerator.integer(100)}";
            })
          : [],
    );
  });
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.offset > 100 && _isAppBarVisible) {
        _isAppBarVisible = false;
        widget.toggleAppBar(false);
      } else if (_scrollController.offset <= 100 && !_isAppBarVisible) {
        _isAppBarVisible = true;
        widget.toggleAppBar(true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListView.builder(
        controller: _scrollController,
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostItem(post: posts[index]);
        });
  }

  @override
  bool get wantKeepAlive => true;
}
