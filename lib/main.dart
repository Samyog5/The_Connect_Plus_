import 'package:flutter/material.dart';

import 'package:tcp/features/auth/presentation/pages/login_page.dart';

import 'package:tcp/features/student/home/presentation/pages/student_home_page.dart';
import 'package:tcp/features/student/more/presentation/pages/student_more_page.dart';
import 'package:tcp/routes/app_router.dart';
import 'core/localization/app_localizations_delegate.dart';
import 'core/localization/locale_provider.dart';
import 'features/auth/auth_injection.dart';
import 'package:tcp/injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  setupAuthInjection();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final LocaleProvider _localeProvider;

  @override
  void initState() {
    super.initState();
    _localeProvider = getLocaleProvider();
    _localeProvider.addListener(_onLocaleChanged);
  }

  @override
  void dispose() {
    _localeProvider.removeListener(_onLocaleChanged);
    super.dispose();
  }

  void _onLocaleChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'EduConnect',
      debugShowCheckedModeBanner: false,
      routerConfig: AppRouter.router, // ✅ Works only with MaterialApp.router
      theme: ThemeData(
        primaryColor: const Color(0xFFB71C1C),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFB71C1C)),
        useMaterial3: true,
      ),
      // Localization setup
      locale: _localeProvider.locale,
      localizationsDelegates: [
        const AppLocalizationsDelegate(),
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
        Locale('fr'),
        Locale('hi'),
        Locale('ne'),
      ],
    );
  }
}
