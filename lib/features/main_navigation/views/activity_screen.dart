import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:ticktok_clone/constants/gaps.dart';
import 'package:ticktok_clone/features/main_navigation/models/post.dart';
import 'package:ticktok_clone/utils/network_image_provider.dart';

class ActivityScreen extends StatefulWidget {
  const ActivityScreen({super.key});

  @override
  State<ActivityScreen> createState() => _ActivityScreenState();
}

class _ActivityScreenState extends State<ActivityScreen> {
  final List<Post> posts = List.generate(10, (index) {
    return Post(
      likeCnt: "${faker.randomGenerator.integer(100)}",
      replyCnt: "${faker.randomGenerator.integer(100)}",
      uploadTime: "${faker.randomGenerator.integer(24)}h",
      avatarUrl: "https://i.pravatar.cc/150?img=${index + 1}",
      followUrls: [],
      userName: faker.person.name(),
      text: faker.lorem.sentence(),
      imageUrls: [],
    );
  });
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImageProvider(
              posts[index].avatarUrl,
              headers: {"Access-Control-Allow-Origin": "*"},
            ),
          ),
          title: Row(
            children: [
              Expanded(
                child: Text(
                  posts[index].userName,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Gaps.h10,
              Text(
                posts[index].uploadTime,
                style: TextStyle(
                  color: Colors.grey.shade500,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                posts[index].text,
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              Text(
                "${posts[index].likeCnt}K followers",
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
                style: TextStyle(),
              )),
        );
      },
    );
  }
}
