import 'dart:math';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ticktok_clone/constants/gaps.dart';
import 'package:ticktok_clone/features/main_navigation/models/post.dart';

class PostItemAvata extends StatelessWidget {
  PostItemAvata({
    super.key,
    required this.post,
  });

  final Post post;
  final List<int> _avataSizes = [23, 16, 19];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(post.avatarUrl),
            ),
            Positioned(
              bottom: -10,
              right: -10,
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: FaIcon(
                  FontAwesomeIcons.plus,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        Gaps.v5,
        Expanded(
          child: Container(
            width: 4,
            //height: 300,
            decoration: BoxDecoration(color: Colors.grey.shade400),
          ),
        ),
        Gaps.v5,
        SizedBox(
          width: 100,
          height: 100,
          child: Stack(
            clipBehavior: Clip.none,
            children: post.followUrls.asMap().entries.map(
              (e) {
                int index = e.key;
                double angle = (index / post.followUrls.length) * 2 * pi;
                double left = 25 + 25 * cos(angle);
                double top = 25 + 25 * sin(angle);
                return Positioned(
                  top: top,
                  left: left,
                  child: CircleAvatar(
                    radius: _avataSizes[index].toDouble(),
                    backgroundImage: NetworkImage(e.value),
                  ),
                );
              },
            ).toList(),
          ),
        ),
      ],
    );
  }
}
