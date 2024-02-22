part of 'bloc.dart';

sealed class GenerativeAIEvent extends Equatable {
  const GenerativeAIEvent();
}

final class OnGenerativeAIText extends GenerativeAIEvent {
  const OnGenerativeAIText({
    required this.prompt,
  });
  final String prompt;

  @override
  List<Object?> get props => [prompt];
}
