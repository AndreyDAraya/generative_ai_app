import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ai_generative/src/generative_ai/data/data.dart';
import 'package:ai_generative/src/generative_ai/domain/domain.dart';
import 'package:ai_generative/src/generative_ai/presenter/bloc/bloc.dart';
import 'package:ai_generative/src/generative_ai/presenter/presenter.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class GenerativeAIModule extends Module {
  GenerativeAIModule({required this.envInstance, required this.generativeAI});

  final DotEnv envInstance;

  final GenerativeModel generativeAI;

  @override
  void binds(i) {
    ///Dependencie that Getting Enviroment Variablesz`
    i.addSingleton(() => envInstance);

    ///Dependencie Injection for GenerativeAIRepository DOMAIN
    i.addSingleton<GenerativeAIRepository>(ApiGenerativeAI.new);

    ///Dependencie Injection for BloC (Management State)
    i.addSingleton(GenerativeAIBloc.new);

    i.addSingleton(() => generativeAI);
  }

  @override
  void routes(r) {
    /// Root page GenerativeAIPage
    r.child(
      '/',
      child: (context) => const GenerativeAIPage(),
    );
  }
}
