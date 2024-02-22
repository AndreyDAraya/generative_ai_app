import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:fpdart/fpdart.dart';
import 'package:ai_generative/src/utils/utils.dart';
import 'package:ai_generative/src/generative_ai/domain/domain.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class ApiGenerativeAI extends GenerativeAIRepository {
  const ApiGenerativeAI({
    required this.generativeAI,
    required this.dotEnv,
  });

  final GenerativeModel generativeAI;
  final DotEnv dotEnv;

  @override
  Future<Either<Failure, String>> generateContent({
    String prompt = '',
  }) async {
    try {
      final content = [Content.text(prompt)];
      final response = await generativeAI.generateContent(content);

      return Right(response.text ?? '');
    } catch (e) {
      return const Left(
        Failure(
          message: 'City not found',
        ),
      );
    }
  }

  @override
  Stream<Either<Failure, String>> generateContentStream({
    String prompt = '',
  }) async* {
    try {
      final content = [Content.text(prompt)];

      final Stream<String> generatedStream = generativeAI
          .generateContentStream(content)
          .map((event) => event.text ?? '');

      await for (final String text in generatedStream) {
        yield Right(text); // Emite el texto generado correctamente
      }
    } catch (e) {
      yield const Left(
        Failure(
          message: 'City not found',
        ),
      );
    }
  }
}
