import 'dart:developer';

import 'package:consume_api_kel_9/controller/post_controller.dart';
import 'package:consume_api_kel_9/models/post.dart';
import 'package:consume_api_kel_9/pages/todo_page.dart';
import 'package:consume_api_kel_9/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PostController postController = PostController();
  int _currentIndex = 0;
  final PageController _pageController = PageController();

  tapBottomItem(int index) {
    if (index != 3) {
      setState(() {
        _currentIndex = index;
      });
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  @override
  void initState() {
    _pageController.addListener(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Consume API",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.yellow,
      ),
      body: PageView(controller: _pageController, children: [
        SafeArea(
          child: FutureBuilder<List<Post>>(
            future: postController.fetchAll(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (snapshot.hasData) {
                if (snapshot.data!.isNotEmpty) {
                  inspect(snapshot.data!);
                  return Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: size.width * 0.01),
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: Key(snapshot.data![index].id.toString()),
                            onDismissed: (direction) {
                              postController
                                  .delete(snapshot.data![index].id)
                                  .then(
                                (result) {
                                  if (result) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Post Delete"),
                                        backgroundColor: Colors.red,
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                    setState(() {});
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text("Failed to delete Post"),
                                        behavior: SnackBarBehavior.floating,
                                      ),
                                    );
                                    setState(() {});
                                  }
                                },
                              );
                            },
                            child: Card(
                              child: ListTile(
                                onLongPress: () {
                                  AppRoutes.goRouter.pushNamed(
                                      AppRoutes.editPost,
                                      extra: snapshot.data![index]);
                                },
                                onTap: () {
                                  GoRouter.of(context).pushNamed(AppRoutes.post,
                                      extra: snapshot.data![index]);
                                },
                                title: Text(
                                  snapshot.data![index].title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  snapshot.data![index].body,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: size.height * 0.0005,
                          );
                        },
                        itemCount: snapshot.data!.length),
                  );
                } else {
                  return const Text("tidak ada data");
                }
              } else {
                return const Text("err");
              }
            },
          ),
        ),
        TodoPage(),
      ]),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          showUnselectedLabels: false,
          selectedItemColor: Colors.black,
          onTap: tapBottomItem,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.post_add_outlined),
              label: "Post",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.task_outlined),
              label: "Todo",
            ),
          ]),
    );
  }
}
