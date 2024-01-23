import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:reading_flutter/src/screens/bookshelf.dart';
import 'package:reading_flutter/src/screens/bookstore.dart';

/// 主页

class Reading extends StatefulWidget {
  const Reading({super.key});

  @override
  State<StatefulWidget> createState() {
    return ReadingState();
  }
}

class ReadingState extends State<Reading> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: GoRouter(
        initialLocation: bookstoreRouter,
        routes: [
          ShellRoute(
            builder: (context, state, child) {
              return HomePage(
                selectedIndex: switch (state.uri.path) {
                  var p when p.startsWith(bookstoreRouter) => 0,
                  var p when p.startsWith(bookshelfRouter) => 1,
                  _ => 0
                },
                child: child,
              );
            },
            routes: [
              GoRoute(
                  path: bookstoreRouter,
                  pageBuilder: (context, child) {
                    return const MaterialPage(child: BookstoreScreen());
                  }),
              GoRoute(
                  path: bookshelfRouter,
                  pageBuilder: (context, child) {
                    return const MaterialPage(child: BookshelfScreen());
                  }),
            ],
          )
        ],
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final Widget child;
  final int selectedIndex;

  const HomePage({super.key, required this.child, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final goRouter = GoRouter.of(context);

    return Scaffold(
      body: AdaptiveNavigationScaffold(
        selectedIndex: selectedIndex,
        body: child,
        onDestinationSelected: (idx) {
          if (idx == 0) {
            goRouter.go(bookstoreRouter);
          } else if (idx == 1) {
            goRouter.go(bookshelfRouter);
          }
        },
        destinations: const [
          AdaptiveScaffoldDestination(title: "书店", icon: Icons.book),
          AdaptiveScaffoldDestination(title: "书架", icon: Icons.mark_chat_read),
        ],
      ),
    );
  }
}
