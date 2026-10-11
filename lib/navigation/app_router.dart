// lib/navigation/app_router.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hizashi/navigation/app_route_names.dart';
import 'package:hizashi/screens/HomeScreen.dart';
import 'package:hizashi/screens/novel/NovelDetailScreen.dart';
import 'package:hizashi/screens/novel/sourceNovelsScreen.dart';


// final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();


final GoRouter appRouter = GoRouter(
    initialLocation: '/',
    routes:[
        GoRoute(
            name: AppRouteNames.homeScreen,
            path: '/',
            builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path:'/source-novels-screen/:sourceId',
          name: AppRouteNames.sourceNovelScreen,
          builder: (context, state) => SourceNovelScreen(
              sourceId: state.pathParameters['sourceId']!,
          ),
        ),
        GoRoute(
           name: AppRouteNames.novelDetailScreen,
           path:'/novel-detail-screen/:sourceId/:novelId',
           builder: (context, state) => NovelDetailScreen(
               sourceId: state.pathParameters['sourceId']!,
               novelId: state.pathParameters['novelId']!,
           ),
        )
    ]
);