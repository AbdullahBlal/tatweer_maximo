import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tatweer_maximo/screens/main_screen/main_screen.dart';
// import 'package:flutter_downloader/flutter_downloader.dart';

var kColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.light,
  primary: Colors.black,
  secondary: const Color.fromARGB(255, 255, 71, 19),
  tertiary: Colors.white,
  seedColor: const Color.fromARGB(255, 127, 135, 138),
);

final theme = ThemeData(
  colorScheme: kColorScheme,
  appBarTheme: const AppBarTheme().copyWith(
    backgroundColor: Colors.white,
  ),
  cardTheme: const CardTheme().copyWith(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  ),
  textTheme: GoogleFonts.geologicaTextTheme(),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((fn) {
    runApp(
      ProviderScope(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: theme,
          home: const MainScreen(),
        ),
      ),
    );
  });
}
