class Post {
  final String userName;
  final String avatarUrl;
  final String text;
  final List<String> imageUrls;
  final String uploadTime;
  final List<String> followUrls;
  final String replyCnt;
  final String likeCnt;
  Post(
      {required this.uploadTime,
      required this.followUrls,
      required this.replyCnt,
      required this.likeCnt,
      required this.userName,
      required this.avatarUrl,
      required this.text,
      required this.imageUrls});
}
