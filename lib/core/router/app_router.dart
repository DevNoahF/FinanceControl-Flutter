import 'package:finance_control/core/auth/auth_service.dart';
import 'package:finance_control/pages/cadastro.dart';
import 'package:finance_control/pages/dashboard.dart';
import 'package:finance_control/pages/login.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/home',
  refreshListenable: authService,
  redirect: (_, state) {
    final isAuthenticated = authService.isAuthenticated;
    final isLoginRoute = state.matchedLocation == '/login';
    final isCadastroRoute = state.matchedLocation == '/cadastro';
    final isPublicRoute = isLoginRoute || isCadastroRoute;

    if (!isAuthenticated && !isPublicRoute) {
      return '/login';
    }

    if (isAuthenticated && isLoginRoute) {
      return '/home';
    }

    return null;
  },
  routes: [
    GoRoute(
      path: '/login',
      builder: (_, __) => const Login(),
    ),
    GoRoute(
      path: '/cadastro',
      builder: (_, __) => const Cadastro(),
    ),
    GoRoute(
      path: '/home',
      builder: (_, __) => const HomeScreen(),
    ),
  ],
);