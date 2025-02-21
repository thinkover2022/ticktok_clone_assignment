import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:ticktok_clone/constants/gaps.dart';
import 'package:ticktok_clone/features/main_navigation/models/post.dart';
import 'package:ticktok_clone/utils/network_image_provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<Post> posts = List.generate(10, (index) {
    return Post(
      likeCnt: "${faker.randomGenerator.integer(100)}",
      replyCnt: "${faker.randomGenerator.integer(100)}",
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
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    Post post = posts[0];
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        children: [
          ProfileHeader(
            userName: post.userName,
            text: post.text,
            likeCnt: post.likeCnt,
            followUrls: post.followUrls,
            avatarUrl: post.avatarUrl,
          ),
          Gaps.v10,
          ProfileTabs(tabController: _tabController),
          Expanded(
            child: TabBarView(controller: _tabController, children: [
              PostList(),
              ReplyList(),
            ]),
          ),
        ],
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader(
      {super.key,
      required this.userName,
      required this.text,
      required this.likeCnt,
      required this.followUrls,
      required this.avatarUrl});
  final String userName;
  final String text;
  final String likeCnt;
  final List<String> followUrls;
  final String avatarUrl;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 170),
                  child: Text(
                    overflow: TextOverflow.ellipsis,
                    userName,
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                  ),
                ),
                Gaps.v10,
                Row(
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxWidth: 102,
                      ),
                      child: Text(
                        overflow: TextOverflow.ellipsis,
                        '${userName}_mobbin',
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    Gaps.h10,
                    Container(
                        decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .surfaceContainerHigh,
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          'threads.net',
                          style: TextStyle(fontSize: 16),
                        )),
                  ],
                ),
                Gaps.v10,
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 250),
                  child: Text(
                    text,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                Gaps.v10,
                Row(
                  children: [
                    Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: CircleAvatar(
                              backgroundImage: NetworkImageProvider(
                                followUrls[0],
                                headers: {"Access-Control-Allow-Origin": "*"},
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 30,
                          child: Container(
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.white, width: 2)),
                            child: CircleAvatar(
                              backgroundImage: NetworkImageProvider(
                                followUrls[1],
                                headers: {"Access-Control-Allow-Origin": "*"},
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Gaps.h40,
                    Text(
                      '$likeCnt followers',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade500,
                      ),
                    )
                  ],
                ),
              ],
            ),
            CircleAvatar(
              backgroundImage: NetworkImageProvider(
                avatarUrl,
                headers: {"Access-Control-Allow-Origin": "*"},
              ),
              radius: 40,
            ),
          ],
        ),
        Gaps.v10,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: Text(
                    "Edit profile",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
            Gaps.h10,
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: Text(
                    "Share profile",
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}

class ProfileTabs extends StatefulWidget {
  final TabController tabController;
  const ProfileTabs({super.key, required this.tabController});

  @override
  State<ProfileTabs> createState() => _ProfileTabsState();
}

class _ProfileTabsState extends State<ProfileTabs> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: TabBar(
        controller: widget.tabController,
        // indicatorColor: Colors.black, // 🔹 현재 선택된 탭 표시
        // labelColor: Colors.black,
        // unselectedLabelColor: Colors.grey,
        tabs: [
          Tab(text: "Threads"),
          Tab(text: "Replies"),
        ],
      ),
    );
  }
}

class PostList extends StatelessWidget {
  final List<Map<String, String>> posts = List.generate(10, (index) {
    return {
      "avataUrl":
          "https://i.pravatar.cc/150?img=${faker.randomGenerator.integer(30) + 1}",
      "username": "jane_mobbin",
      "time": "5h",
      "text":
          "Give @john_mobbin a follow if you want to see more travel content!",
    };
  });

  PostList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: posts.length,
      itemBuilder: (context, index) {
        return PostCard(post: posts[index]);
      },
    );
  }
}

class PostCard extends StatelessWidget {
  final Map<String, String> post;

  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImageProvider(
                  post["avataUrl"]!,
                  headers: {"Access-Control-Allow-Origin": "*"},
                ),
              ),
              const SizedBox(width: 10),
              Text(post["username"]!,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 5),
              Text(post["time"]!, style: TextStyle(color: Colors.grey[600])),
            ],
          ),
          const SizedBox(height: 10),
          Text(post["text"]!),
          if (post.containsKey("shared")) ...[
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                post["shared"]!,
                style: TextStyle(color: Colors.grey[700]),
              ),
            ),
          ],
          const SizedBox(height: 10),
          Row(
            children: [
              IconButton(
                  icon: const Icon(Icons.favorite_border), onPressed: () {}),
              IconButton(icon: const Icon(Icons.repeat), onPressed: () {}),
              IconButton(icon: const Icon(Icons.send), onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}

class ReplyList extends StatelessWidget {
  final List<Map<String, String>> replies = List.generate(10, (index) {
    return {
      "avataUrl":
          "https://i.pravatar.cc/150?img=${faker.randomGenerator.integer(30) + 1}",
      "username": faker.person.name(),
      "time": "${faker.randomGenerator.integer(24)}h",
      "text": faker.lorem.sentence(),
      "shared": "Original post: '${faker.person.name()}'"
    };
  });

  ReplyList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: replies.length,
      itemBuilder: (context, index) {
        return ReplyCard(reply: replies[index]);
      },
    );
  }
}

class ReplyCard extends StatelessWidget {
  final Map<String, String> reply;

  const ReplyCard({super.key, required this.reply});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 0.5)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImageProvider(
                  reply["avataUrl"]!,
                  headers: {"Access-Control-Allow-Origin": "*"},
                ),
              ),
              const SizedBox(width: 10),
              Text(reply["username"]!,
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 5),
              Text(reply["time"]!, style: TextStyle(color: Colors.grey[600])),
            ],
          ),
          const SizedBox(height: 10),
          Text(reply["text"]!),
          if (reply.containsKey("shared")) ...[
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(reply["shared"]!,
                  style: TextStyle(color: Colors.grey[700])),
            ),
          ],
          const SizedBox(height: 10),
          Row(
            children: [
              IconButton(
                  icon: const Icon(Icons.favorite_border), onPressed: () {}),
              IconButton(
                  icon: const Icon(Icons.chat_bubble_outline),
                  onPressed: () {}),
              IconButton(icon: const Icon(Icons.repeat), onPressed: () {}),
              IconButton(icon: const Icon(Icons.send), onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
