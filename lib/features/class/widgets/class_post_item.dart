import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../model/post_model.dart';

class ClassPostItem extends StatelessWidget {
  final PostModel post; // Accept the entire post object

  const ClassPostItem({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.userId,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      timeago.format(post.createdAt),
                      style: const TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
                const Icon(Icons.more_vert),
              ],
            ),
            const SizedBox(height: 12.0),
            // Content
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(post.content),
                if (post.image != null && post.image!.isNotEmpty) ...[
                  const SizedBox(height: 8.0),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: post.image!.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Image.network(
                            post.image![index],
                            fit: BoxFit.cover,
                            width: 100,
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
            const SizedBox(height: 12.0),
            // Footer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.thumb_up, color: Colors.grey),
                    const SizedBox(width: 4.0),
                    Text('${post.likes}'),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.visibility, color: Colors.grey),
                    const SizedBox(width: 4.0),
                    Text('${post.views}'),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
