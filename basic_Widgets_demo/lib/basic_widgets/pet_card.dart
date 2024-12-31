import 'package:flutter/material.dart';

// 定义宠物卡的数据模型
class PetCardViewModel {
  // 封面地址
  final String coverUrl;

  // 用户头像地址
  final String userImgUrl;

  // 用户名
  final String userName;

  // 用户描述
  final String description;

  // 话题
  final String topic;

  // 发布时间
  final String publishTime;

  // 发布内容
  final String publishContent;

  // 回复数量
  final int replies;

  // 喜欢数量
  final int likes;

  // 分享数量
  final int shares;

  const PetCardViewModel({
    required this.coverUrl,
    required this.userImgUrl,
    required this.userName,
    required this.description,
    required this.topic,
    required this.publishTime,
    required this.publishContent,
    required this.replies,
    required this.likes,
    required this.shares,
  });
}

// 宠物卡界面的实现
class PetCard extends StatelessWidget {
  final PetCardViewModel data; // 宠物卡的数据模型对象

  const PetCard({super.key, required this.data});  

  // 封面区域
  Widget renderCover() {
    return Stack(
      fit: StackFit.passthrough,
      children: <Widget>[
        ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
          ),
          child: Image.network(
            data.coverUrl,
            height: 200,
            fit: BoxFit.fitWidth,
          ),
        ),
        Positioned(
          left: 0,
          top: 100,
          right: 0,
          bottom: 0,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromARGB(0, 0, 0, 0),
                  Color.fromARGB(80, 0, 0, 0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 用户信息区域
  Widget renderUserInfo() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                radius: 20,
                backgroundColor: const Color(0xFFCCCCCC),
                backgroundImage: NetworkImage(data.userImgUrl),
              ),
              const Padding(padding: EdgeInsets.only(left: 8)),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    data.userName,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                  const Padding(padding: EdgeInsets.only(top: 2)),
                  Text(
                    data.description,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Color(0xFF999999),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            data.publishTime,
            style: const TextStyle(
              fontSize: 13,
              color: Color(0xFF999999),
            ),
          ),
        ],
      ),
    );
  }

  // 发布内容区域
  Widget renderPublishContent() {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 14),
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: const BoxDecoration(
              color: Color(0xFFFFC600),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(8),
                bottomLeft: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
            ),
            child: Text(
              '# ${data.topic}',
              style: const TextStyle(
                fontSize: 12,
                color: Colors.white,
              ),
            ),
          ),
          Text(
            data.publishContent,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Color(0xFF333333),
            ),
          ),
        ],
      ),
    );
  }

  // 互动区域
  Widget renderInteractionArea() {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 16),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(
                Icons.message,
                size: 16,
                color: Color(0xFF999999),
              ),
              const Padding(padding: EdgeInsets.only(left: 6)),
              Text(
                data.replies.toString(),
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF999999),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              const Icon(
                Icons.favorite,
                size: 16,
                color: Color(0xFFFFC600),
              ),
              const Padding(padding: EdgeInsets.only(left: 6)),
              Text(
                data.likes.toString(),
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF999999),
                ),
              ),
            ],
          ),
          Row(
            children: <Widget>[
              const Icon(
                Icons.share,
                size: 16,
                color: Color(0xFF999999),
              ),
              const Padding(padding: EdgeInsets.only(left: 6)),
              Text(
                data.shares.toString(),
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF999999),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 界面实现
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: const [
          BoxShadow(
            blurRadius: 6,
            spreadRadius: 4,
            color: Color.fromARGB(20, 0, 0, 0),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          renderCover(), // 封面区域
          renderUserInfo(), // 用户信息区域
          renderPublishContent(), // 发布内容区域
          renderInteractionArea(), // 互动区域
        ],
      ),
    );
  }
}
