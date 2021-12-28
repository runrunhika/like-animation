import 'package:flutter/material.dart';

import 'isHeartAnimatingWidget.dart';

class PostWidget extends StatefulWidget {
  const PostWidget({Key? key}) : super(key: key);

  @override
  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool isLiked = false;
  bool isHeartAnimating = false;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      buildImage(),
      buildActions()
    ],
  );

  Widget buildImage() {
    return GestureDetector(
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Image.network(
              'https://pbs.twimg.com/profile_images/1399770499199254532/zn_-38Hw_400x400.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Opacity(
            opacity: isHeartAnimating ? 1 : 0,
            child: HeartAnimatinWidget(
                isAnimating: isHeartAnimating,
                duration: Duration(milliseconds: 700),
                child: Icon(
                  Icons.favorite,
                  color: Colors.white,
                  size: 100,
                ),
                onEnd: () => setState(() {
                      isHeartAnimating = false;
                    })),
          )
        ],
      ),
      onDoubleTap: () {
        setState(() {
          isHeartAnimating = true;
          isLiked = true;
        });
      },
    );
  }

  Widget buildActions() {
    final icon = isLiked ? Icons.favorite : Icons.favorite_outline;
    final color = isLiked ? Colors.red : Colors.white;

    return Container(
      padding: EdgeInsets.all(4),
      child: Row(
        children: [
          HeartAnimatinWidget(
            alwaysAnimate: true,
            isAnimating: isLiked,
            child: IconButton(
                onPressed: () {
                  setState(() {
                    isLiked = !isLiked;
                  });
                },
                icon: Icon(icon, color: color, size: 28)),
          )
        ],
      ),
    );
  }
}
