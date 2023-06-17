import 'package:consume_api_kel_9/controller/post_controller.dart';
import 'package:flutter/material.dart';

import '../models/comment.dart' as c;
import '../models/post.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key, required this.post});

  final Post post;

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    final PostController postController = PostController();
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        backgroundColor: Colors.yellow,
        title: const Text(
          "Detail Post",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.post.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            SizedBox(
              height: size.width,
              child: Text(
                widget.post.body,
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            const Text("Komentar"),
            SizedBox(
              height: size.height * 0.02,
            ),
            Expanded(
              child: FutureBuilder<List<c.Comment>>(
                future: postController.fetchComments(widget.post.id),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isNotEmpty) {
                      List<c.Comment> comments = snapshot.data!;
                      return ListView.separated(
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(
                                comments[index].name,
                              ),
                              subtitle: Text(
                                comments[index].body,
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: size.height * 0.0005,
                          );
                        },
                        itemCount: comments.length,
                      );
                    } else {
                      return const Text(
                        "Tidak ada komentar",
                      );
                    }
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return AspectRatio(
                      aspectRatio: 1 / 1,
                      child: SizedBox(
                        height: size.height * 0.2,
                        width: size.width * 0.2,
                        child: const CircularProgressIndicator(),
                      ),
                    );
                  } else {
                    return const Text("Err");
                  }
                },
              ),
            )
          ],
        ),
      )),
    );
  }
}
