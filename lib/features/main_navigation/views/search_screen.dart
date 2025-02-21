import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:ticktok_clone/features/main_navigation/models/post.dart';
import 'package:ticktok_clone/utils/network_image_provider.dart';

class SearchScreen extends StatefulWidget {
  final String query;
  const SearchScreen({super.key, required this.query});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final List<Post> posts = List.generate(10, (index) {
    return Post(
      likeCnt: "${faker.randomGenerator.integer(100)}",
      replyCnt: "${faker.randomGenerator.integer(100)} replies",
      uploadTime: "${faker.randomGenerator.integer(24)}h",
      avatarUrl: "https://i.pravatar.cc/150?img=${index + 1}",
      followUrls: [],
      userName: faker.person.name(),
      text: faker.lorem.sentence(),
      imageUrls: [],
    );
  });

  List<Post> get filteredPosts {
    if (widget.query.isEmpty) {
      return posts; // 검색어가 없을 때 전체 리스트 반환
    }
    return posts.where((post) {
      return post.userName.toLowerCase().contains(widget.query.toLowerCase());
    }).toList(); // 검색어로 필터링된 리스트 반환
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: filteredPosts.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImageProvider(
              filteredPosts[index].avatarUrl,
              headers: {"Access-Control-Allow-Origin": "*"},
            ),
          ),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  filteredPosts[index].userName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Icon(
                Icons.verified,
                color: Colors.blue,
                size: 16,
              )
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                filteredPosts[index].text,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              Text(
                "${filteredPosts[index].likeCnt}K followers",
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
            ],
          ),
          trailing: OutlinedButton(
              onPressed: () {},
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                "Follow",
              )),
        );
      },
    );
  }
}
