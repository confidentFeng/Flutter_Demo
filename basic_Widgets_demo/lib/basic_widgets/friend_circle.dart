import 'package:flutter/material.dart';

// 评论内容类
class Comment {
  // 是否发起人
  final bool source;

  // 评论者
  final String fromUser;

  // 被评论者
  final String toUser;

  // 评论内容
  final String content;

  const Comment({
    required this.source,
    required this.fromUser,
    required this.toUser,
    required this.content,
  });
}

// 定义朋友圈的数据模型
class FriendCircleViewModel {
  // 用户名
  final String userName;

  // 用户头像地址
  final String userImgUrl;

  // 说说
  final String saying;

  // 图片
  final String pic;

  //发布时间
  final String publishTime;

  // 评论内容列表
  final List<Comment> comments;

  const FriendCircleViewModel({
    required this.userName,
    required this.userImgUrl,
    required this.saying,
    required this.pic,
    required this.publishTime,
    required this.comments,
  });
}

// 朋友圈界面的实现
class FriendCircle extends StatelessWidget {
  final FriendCircleViewModel data; // 朋友圈的数据模型对象

  const FriendCircle({super.key, required this.data});  

  Widget renderComments() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(10),
      color: const Color(0xFFF3F3F5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: data.comments.map((comment) {
          return Text.rich(
            TextSpan(
              style: const TextStyle(
                fontSize: 15,
                color: Color(0xFF333333),
              ),
              children: [
                TextSpan(
                  text: comment.fromUser,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF636F80),
                  ),
                ),
                TextSpan(text: '：${comment.content}'),
              ]..insertAll(1, comment.source ? [const TextSpan()] : [
                  const TextSpan(text: ' 回复 '),
                  TextSpan(
                    text: comment.toUser,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF636F80),
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Image.network(
              data.userImgUrl,
              width: 50,
              height: 50,
            ),
          ),
          const Padding(padding: EdgeInsets.only(left: 12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  data.userName,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF636F80),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(top: 6)),
                Text(
                  data.saying,
                  style: const TextStyle(
                    fontSize: 15,
                    height: 0.8,
                    color: Color(0xFF333333),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Image.network(
                    data.pic,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      data.publishTime,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF999999),
                      ),
                    ),
                    const Icon(
                      Icons.comment,
                      size: 16,
                      color: Color(0xFF999999),
                    ),
                  ],
                ),
                renderComments(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}


