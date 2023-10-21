import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:localization/localization.dart';
import 'package:provider/provider.dart';
import 'package:tamini_app/pages/home_page.dart';
import 'package:tamini_app/pages/owner_tracking.dart';
import 'package:tamini_app/pages/profile.dart';
import 'package:tamini_app/pages/registration.dart';
import 'package:tamini_app/pages/request_quotations.dart';
import 'package:tamini_app/pages/request_refund.dart';
import 'package:tamini_app/pages/user_tracking.dart';
import 'package:tamini_app/provider/language_provider.dart';
import 'package:tamini_app/provider/theme_provider.dart';
import 'package:tamini_app/themes/tamini_themes.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GoRouter _router = GoRouter(
    routes: <RouteBase>[
      GoRoute(
        path: '/',
        builder: (BuildContext context, GoRouterState state) {
          return checkUserAuthentication() ? const HomePage() : const Registration();
        },
        routes: <RouteBase>[
          GoRoute(
            path: 'registration',
            builder: (BuildContext context, GoRouterState state) {
              return const Registration();
            },
          ),
          GoRoute(
            path: 'owner_tracking',
            builder: (BuildContext context, GoRouterState state) {
              return const OwnerTracking();
            },
          ),
          GoRoute(
            path: 'home_page',
            builder: (BuildContext context, GoRouterState state) {
              return const HomePage();
            },
          ),
          GoRoute(
            path: 'request_quotations',
            builder: (BuildContext context, GoRouterState state) {
              return const RequestQuotations();
            },
          ),
          GoRoute(
            path: 'request_refund',
            builder: (BuildContext context, GoRouterState state) {
              return const RequestRefund();
            },
          ),
          GoRoute(
            path: 'user_tracking',
            builder: (BuildContext context, GoRouterState state) {
              return const UserTracking();
            },
          ),
          GoRoute(
            path: 'profile',
            builder: (BuildContext context, GoRouterState state) {
              return const ProfilePage();
            },
          ),
        ],
      ),
    ],
  );

  LanguageProvider languageProvider = LanguageProvider();

  @override
  Widget build(BuildContext context) {
    // Set the directories where the translation JSON files are located
    LocalJsonLocalization.delegate.directories = ['lib/i18n'];

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LanguageProvider>(
          create: (context) => languageProvider,
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(slateBlueLight), // default theme
        ),
      ],
      child: Consumer2<LanguageProvider, ThemeProvider>(
        builder: (context, languageProvider, themeProvider, child) {
          return MaterialApp.router(
            routerConfig: _router,
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              LocalJsonLocalization.delegate,
            ],
            locale: languageProvider.currentLocale,
            supportedLocales: const [
              Locale('ar', 'SA'), // Arabic
              Locale('en', 'US'), // English
            ],
            localeResolutionCallback: (deviceLocale, supportedLocales) {
              if (deviceLocale?.languageCode == 'ar' && supportedLocales.contains(const Locale('ar', 'SA'))) {
                return const Locale('ar', 'SA');
              } else {
                return const Locale('en', 'US');
              }
            },
            theme: Provider.of<ThemeProvider>(context).getTheme(),
            debugShowCheckedModeBanner: false,
          );
        },
      ),
    );
  }
}

bool checkUserAuthentication() {
  /// Get the current user from Firebase Authentication
  /// Check if the firebaseUser is not null, indicating the user is authenticated
  /// Return true if authenticated, otherwise return false

  return FirebaseAuth.instance.currentUser != null ? true : false;
}
