import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ticktok_clone/constants/gaps.dart';
import 'package:ticktok_clone/features/main_navigation/models/post.dart';

class PostItemContent extends StatelessWidget {
  const PostItemContent({
    super.key,
    required this.post,
    required this.onTap,
  });

  final Post post;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 150,
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  post.userName,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Gaps.h5,
              Container(
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: Colors.blue),
                  child: FaIcon(
                    FontAwesomeIcons.check,
                    color: Colors.white,
                  )),
              Spacer(),
              Text(
                post.uploadTime,
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
              Gaps.h10,
              GestureDetector(
                  onTap: onTap, child: FaIcon(FontAwesomeIcons.ellipsis)),
            ],
          ),
          if (post.text.isNotEmpty) ...[
            Gaps.v20,
            Text(
              post.text,
              softWrap: true,
              style: TextStyle(fontSize: 20),
            ),
          ],
          if (post.imageUrls.isNotEmpty) ...[
            Gaps.v20,
            SizedBox(
              height: 200,
              width: double.infinity,
              child: PageView(
                children: post.imageUrls
                    .map((imageUrl) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: imageUrl,
                              fit: BoxFit.cover,
                              placeholder: (context, url) =>
                                  Center(child: CircularProgressIndicator()),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            ))))
                    .toList(),
              ),
            ),
          ],
          Gaps.v20,
          Row(
            children: [
              Gaps.h10,
              FaIcon(FontAwesomeIcons.heart),
              Gaps.h10,
              FaIcon(FontAwesomeIcons.comment),
              Gaps.h10,
              FaIcon(FontAwesomeIcons.recycle),
              Gaps.h10,
              FaIcon(FontAwesomeIcons.paperPlane),
            ],
          ),
          Gaps.v20,
          Row(
            children: [
              Text(
                post.replyCnt,
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
              Gaps.h10,
              Text(
                "•",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
              Gaps.h10,
              Text(
                post.likeCnt,
                style: TextStyle(color: Colors.grey, fontSize: 20),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
