import 'package:flutter/material.dart';
import 'package:ticktok_clone/features/main_navigation/models/post.dart';
import 'package:ticktok_clone/features/main_navigation/views/bottom_sheet_screen.dart';
import 'package:ticktok_clone/features/main_navigation/widgets/post_item_avata.dart';
import 'package:ticktok_clone/features/main_navigation/widgets/post_item_content.dart';

class PostItem extends StatelessWidget {
  final Post post;

  const PostItem({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IntrinsicHeight(
              //왼쪽 column과 오른쪽Column위젯의 높이맞추기위해 사용
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  PostItemAvata(post: post), //왼쪽PostItem
                  Expanded(
                    //second column text and image
                    child: PostItemContent(
                      post: post,
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return BottomSheetScreen();
                            });
                      },
                    ), //오른쪽PostItem
                  ),
                ],
              ),
            ),
            SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
