import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ticktok_clone/constants/gaps.dart';

class ReportSheetScreen extends StatelessWidget {
  ReportSheetScreen({super.key});
  final List<String> contents = [
    "I just don't like it",
    "It's unlawful content under NetzDG",
    "It's spam",
    "Hate speech or symbols",
    "Nudity or sexual activity",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(75.0),
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: AppBar(
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(1.0),
                child: Container(
                  color: Colors.grey.shade300,
                  height: 1.0,
                )),
            automaticallyImplyLeading: false,
            centerTitle: true,
            flexibleSpace: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade400,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Report",
                      style: TextStyle(fontSize: 30),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Why are you reporting this thread?",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            Gaps.v10,
            Text(
              softWrap: true,
              "Your report is anonymous, except if you're reporting an intellectual property infringement. If someone is in immediate danger, call the local emergency services - don't wait.",
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            ),
            Gaps.v10,
            Container(
              color: Colors.grey.shade300,
              height: 2,
            ),
            Expanded(
              child: ListView.separated(
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 60,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              contents[index],
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w400),
                            ),
                          ),
                          FaIcon(
                            FontAwesomeIcons.angleRight,
                            color: Colors.grey.shade400,
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Container(
                      color: Colors.grey.shade300,
                      height: 2,
                    );
                  },
                  itemCount: contents.length),
            ),
          ],
        ),
      ),
    );
  }
}
