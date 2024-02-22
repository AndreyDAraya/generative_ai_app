import 'package:ai_generative/src/common/theme.dart';
import 'package:ai_generative/src/generative_ai/module.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:provider/provider.dart';

void main() async {
  /// Loads environment variables from a .env file into your root of Flutter application.
  /// Example of file .env:
  /// GOOGLE_KEY_AI=TU_CLAVE_API

  await dotenv.load();

  final apiKey = dotenv.get('GOOGLE_KEY_AI');

  final generativeAI = GenerativeModel(model: 'gemini-pro', apiKey: apiKey)
    ..startChat();

  runApp(
    ///Modular architecture, routing, and dependency injection setup.
    ModularApp(
      module: GenerativeAIModule(
        envInstance: dotenv,
        generativeAI: generativeAI,
      ),
      child: const RootWidget(),
    ),
  );
}

class RootWidget extends StatelessWidget {
  const RootWidget({super.key});

  @override
  Widget build(BuildContext context) {
    /// Modular architecture,
    Modular.setInitialRoute('/');
    return ChangeNotifierProvider(
      create: (context) => ColorSchemeProvider(
        initialColorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blueGrey,
        ),
      ),
      child: Consumer<ColorSchemeProvider>(builder: (context, provider, child) {
        return MaterialApp.router(
          title: 'Generative AI',
          theme: ThemeData.light().copyWith(
            // Define the default brightness and colors.
            colorScheme: provider.colorScheme,
          ),
          routerConfig: Modular.routerConfig,
        );
      }),
    ); //added by extension
  }
}
