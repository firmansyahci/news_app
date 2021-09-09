import 'package:flutter/material.dart';

class HeadlineItem extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;

  HeadlineItem(this.imageUrl, this.title, this.description);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SizedBox(
            width: 60,
            height: 100,
            child: Image.network(imageUrl),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
            ),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            description,
            style: TextStyle(fontSize: 14),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
