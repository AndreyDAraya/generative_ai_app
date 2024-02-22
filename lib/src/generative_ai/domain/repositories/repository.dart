import 'package:fpdart/fpdart.dart';
import 'package:ai_generative/src/utils/utils.dart';

abstract class GenerativeAIRepository {
  const GenerativeAIRepository();

  Future<Either<Failure, String>> generateContent({
    String prompt = '',
  });

  Stream<Either<Failure, String>> generateContentStream({
    String prompt = '',
  });
}
