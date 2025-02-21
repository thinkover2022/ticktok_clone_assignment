import 'package:camera/camera.dart';
import 'package:faker/faker.dart' as faker;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ticktok_clone/constants/gaps.dart';
import 'package:ticktok_clone/features/main_navigation/models/post.dart';
import 'package:ticktok_clone/features/main_navigation/views/attach_screen.dart';
import 'package:ticktok_clone/features/main_navigation/widgets/post_item_avata.dart';

class WriteScreen extends StatefulWidget {
  final List<CameraDescription> cameras;
  const WriteScreen({super.key, required this.cameras});

  @override
  State<WriteScreen> createState() => _WriteScreenState();
}

class _WriteScreenState extends State<WriteScreen> {
  List<String>? _fileList;
  bool _isPostBtnEnable = false;
  final TextEditingController _controller = TextEditingController();

  Post post = Post(
    likeCnt: "${faker.faker.randomGenerator.integer(100)} likes",
    replyCnt: "${faker.faker.randomGenerator.integer(100)} replies",
    uploadTime: "${faker.faker.randomGenerator.integer(24)}h",
    avatarUrl:
        "https://i.pravatar.cc/150?img=${faker.faker.randomGenerator.integer(30) + 1}",
    followUrls: List.generate(2, (index) {
      return "https://i.pravatar.cc/150?img=${faker.faker.randomGenerator.integer(30) + 1}";
    }),
    userName: faker.faker.person.name(),
    text: faker.faker.lorem.sentence(),
    imageUrls: [],
  );
  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      setState(() {
        _isPostBtnEnable = _controller.text.trim().isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _pressAttach() async {
    _fileList = await Navigator.push<List<String>>(context,
        MaterialPageRoute(builder: (context) {
      return AttachScreen(
        cameras: widget.cameras,
      );
    }));
    if (_fileList != null && _fileList!.length > 1) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gaps.v20,
        IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              PostItemAvata(post: post),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            post.userName,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          hintText: "Start a thread...",
                          border: InputBorder.none,
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                      ),
                      Gaps.v10,
                      if (_fileList != null && _fileList!.isNotEmpty)
                        Container(
                          clipBehavior: Clip.hardEdge,
                          height: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            physics: ClampingScrollPhysics(),
                            itemCount: _fileList!.length,
                            itemBuilder: (context, index) {
                              return Image.network(_fileList![index]);
                            },
                            separatorBuilder: (context, index) {
                              return Gaps.h5;
                            },
                          ),
                        ),
                      GestureDetector(
                          onTap: () {
                            _pressAttach();
                          },
                          child: FaIcon(FontAwesomeIcons.paperclip)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                              onPressed: () {},
                              child: Text(
                                "Post",
                                style: TextStyle(
                                  color: _isPostBtnEnable
                                      ? Colors.blue.shade300
                                      : Colors.grey,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
