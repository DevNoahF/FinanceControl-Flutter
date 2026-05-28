import 'package:finance_control/adapter/services/auth/auth_service.dart';
import 'package:finance_control/frontend/pages/cadastro.dart';
import 'package:finance_control/frontend/pages/dashboard.dart';
import 'package:finance_control/frontend/pages/login.dart';
import 'package:finance_control/frontend/pages/input.dart';
import 'package:finance_control/frontend/pages/emConstrucao.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/login',
  refreshListenable: authService,
  redirect: (context, state) {
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
    GoRoute(path: '/login', builder: (context, state) => const Login()),
    GoRoute(path: '/cadastro', builder: (context, state) => const Cadastro()),
    GoRoute(path: '/home', builder: (context, state) => const HomeScreen()),
    GoRoute(path: '/input', builder: (context, state) => const InputScreen()),
    GoRoute(
      path: '/emConstrucao',
      builder: (context, state) => const EmConstrucaoPage(),
    ),
  ],
);
