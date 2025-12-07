import 'package:flutter/material.dart';
import 'package:frontend/features/auth/center_auth_screen.dart';
import 'package:frontend/features/auth/controller/auth_controller.dart';
import 'package:frontend/features/auth/sign_in_screen.dart';
import 'package:frontend/features/auth/sign_up_screen.dart';
import 'package:frontend/features/home/home_screen.dart';
import 'package:frontend/features/layout/layout_scaffold.dart';
import 'package:frontend/features/profile/profile_screen.dart';
import 'package:frontend/routing/animation.dart';
import 'package:frontend/routing/page_routes.dart';
import 'package:go_router/go_router.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final authController = AuthController();

final goRouter = GoRouter(
  initialLocation:
      authController.isSignIn ? PageRoutes.homePage : PageRoutes.auth,
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
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: PageRoutes.news,
              pageBuilder:
                  (context, state) =>
                      animationRouter(const HomeScreen(), state),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: PageRoutes.profile,
              pageBuilder:
                  (context, state) =>
                      animationRouter(const ProfileScreen(), state),
            ),
          ],
        ),
      ],
    ),
  ],
);

