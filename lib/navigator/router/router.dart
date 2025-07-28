import 'package:dna/navigator/navigator_screen/tabbar_screen.dart';
import 'package:go_router/go_router.dart';
import 'package:dna/navigator/navigator_screen/home_screen.dart';
import 'package:dna/navigator/navigator_screen/create_account_screen.dart';
import 'package:dna/navigator/navigator_screen/profile_screen.dart';
import 'package:dna/navigator/navigator_screen/goal_screen.dart';
import 'package:dna/navigator/navigator_screen/welcome_screen.dart';
import 'package:dna/navigator/navigator_screen/main_screen.dart';

// Quản lí chuyển màn hình
final GoRouter router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) =>  HomeScreen(),
    ),

    GoRoute(
      path: '/createprofile',
      builder: (context, state) => CreateAccountScreen(),
    ),

    GoRoute(
      path: '/profile',
      builder: (context, state) => ProfileScreen(),
    ),

    GoRoute(
      path: '/goal',
      builder: (context, state) => GoalScreen(),
    ),

    GoRoute(
      path: '/welcome',  
      builder: (context, state) => WelcomeScreen(fromLogin: true),
    ),

    GoRoute(
      path: '/main',
      builder: (context, state) {
        final fromLogin = state.uri.queryParameters['fromLogin'] == 'true';
        return MainScreen(fromLogin: fromLogin);
      } 
    ),
    GoRoute(
      path: '/tabbar',
      builder: (context, state) => TabbarScreen(),    
    ),
  ],
);