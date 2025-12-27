import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wesal_app/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const WesalApp());
}

class WesalApp extends StatelessWidget {
  const WesalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'وصال', // Arabic Title
      // RTL Support
      locale: const Locale('ar'),
      supportedLocales: const [Locale('ar'), Locale('en')],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: ThemeData(
        useMaterial3: true,
        // Color Scheme
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7851A9), // Soft Royal Purple
          primary: const Color(0xFF7851A9),
          secondary: const Color(0xFF191970), // Deep Midnight Blue
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF3F4F6),
        // Font
        textTheme: GoogleFonts.tajawalTextTheme(Theme.of(context).textTheme),
        // Button Theme for global styling
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            elevation: 8,
            shadowColor: Colors.purple.withValues(alpha: 0.4),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {'/': (_) => const SplashScreen()},
      debugShowCheckedModeBanner: false,
    );
  }
}
