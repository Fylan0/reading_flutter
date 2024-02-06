import 'package:adaptive_navigation/adaptive_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:reading_flutter/src/screens/bookshelf.dart';
import 'package:reading_flutter/src/screens/bookstore.dart';
import 'package:reading_flutter/src/screens/reading.dart';
import 'package:reading_flutter/src/screens/test.dart';

import '../generated/l10n.dart';

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
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: S.delegate.supportedLocales,
      // locale: const Locale('en', 'US'), // 可以手动指定当前的语言
      routerConfig: GoRouter(
        initialLocation: bookstoreRouter,
        routes: [
          ShellRoute(
            builder: (context, state, child) {
              return HomePage(
                selectedIndex: switch (state.uri.path) {
                  var p when p.startsWith(bookstoreRouter) => 0,
                  var p when p.startsWith(bookshelfRouter) => 1,
                  var p when p.startsWith(testRouter) => 2,
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
              GoRoute(
                  path: testRouter,
                  pageBuilder: (context, child) {
                    return const MaterialPage(child: TestScreen());
                  }),
            ],
          ),
          GoRoute(
              path: '$readingRouter/:$paramsBookId',
              pageBuilder: (context, state) {
                String bookId = state.pathParameters[paramsBookId]!;
                return MaterialPage(child: ReadingScreen(bookId: bookId));
              }),
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
          } else if (idx == 2) {
            goRouter.go(testRouter);
          }
        },
        destinations: [
          AdaptiveScaffoldDestination(
              title: S.current.bookstore, icon: Icons.book),
          AdaptiveScaffoldDestination(
              title: S.current.bookshelf, icon: Icons.mark_chat_read),
          AdaptiveScaffoldDestination(
              title: "Test", icon: Icons.mark_chat_read),
        ],
      ),
    );
  }
}
