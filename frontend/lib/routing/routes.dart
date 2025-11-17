import 'package:flutter/material.dart';
import 'package:frontend/features/auth/center_auth_screen.dart';
import 'package:frontend/features/auth/sign_in_screen.dart';
import 'package:frontend/features/auth/sign_up_screen.dart';
import 'package:frontend/features/home/home_screen.dart';
import 'package:frontend/features/layout/layout_scaffold.dart';
import 'package:frontend/routing/animation.dart';
import 'package:frontend/routing/page_routes.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

final goRouter = GoRouter(
  initialLocation: PageRoutes.auth,
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: PageRoutes.auth,
      pageBuilder:
          (context, state) => animationRouter(const CenterAuthScreen(), state),
    ),
    GoRoute(
      path: PageRoutes.signUp,
      pageBuilder:
          (context, state) => animationRouter(const SignUpScreen(), state),
    ),
    GoRoute(
      path: PageRoutes.signIn,
      pageBuilder:
          (context, state) => animationRouter(const SignInScreen(), state),
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return LayoutScaffold(navigationShell: navigationShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: PageRoutes.homePage,
              pageBuilder:
                  (context, state) =>
                      animationRouter(const HomeScreen(), state),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: PageRoutes.chat,
              pageBuilder:
                  (context, state) =>
                      animationRouter(const HomeScreen(), state),
            ),
          ],
        ),
      ],
    ),
  ],
);
