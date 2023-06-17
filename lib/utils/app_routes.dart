import 'package:consume_api_kel_9/models/post.dart';
import 'package:consume_api_kel_9/pages/add_post_page.dart';
import 'package:consume_api_kel_9/pages/homepage.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const home = "home";
  static const post = "post";
  static const addPost = "add-post";
  static const editPost = "edit-post";
  static const todo = "todo";

  static Page _homePageBuilder(BuildContext context, GoRouterState state) {
    return const MaterialPage(
      child: HomePage(),
    );
  }



  static Page _addPostPageBuilder(BuildContext context, GoRouterState state) {
    return const MaterialPage(
      child: AddPostPage(),
    );
  }

  static Page _editPostPageBuilder(BuildContext context, GoRouterState state) {
    return MaterialPage(
      child: AddPostPage(
        post: state.extra as Post,
      ),
    );
  }

  static GoRouter goRouter = GoRouter(
    initialLocation: "/home",
    routes: [
      GoRoute(
          name: home,
          path: "/home",
          pageBuilder: _homePageBuilder,
          routes: [
            
            GoRoute(
              name: addPost,
              path: "add-post",
              pageBuilder: _addPostPageBuilder,
            ),
            GoRoute(
              name: editPost,
              path: "edit-post",
              pageBuilder: _editPostPageBuilder,
            ),
          ]),
    ],
  );
}