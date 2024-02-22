part of 'bloc.dart';

sealed class GenerativeAIState extends Equatable {
  const GenerativeAIState({
    required this.generateContentResponse,
    required this.prompt,
    required this.isPromptLoading,
  });

  final String generateContentResponse;
  final String prompt;
  final bool isPromptLoading;

  @override
  List<Object?> get props => [prompt, generateContentResponse, isPromptLoading];
}

final class InitialState extends GenerativeAIState {
  const InitialState({
    required super.generateContentResponse,
    required super.prompt,
    required super.isPromptLoading,
  });

  @override
  List<Object?> get props => [prompt, generateContentResponse];
}

final class ShowLoading extends GenerativeAIState {
  const ShowLoading({
    required super.generateContentResponse,
    this.message = '',
    required super.prompt,
    required super.isPromptLoading,
  });

  final String message;

  @override
  List<Object?> get props => [prompt, generateContentResponse, message];
}

final class IsLoadingprompt extends GenerativeAIState {
  const IsLoadingprompt({
    required super.generateContentResponse,
    this.message = '',
    required super.prompt,
    required super.isPromptLoading,
  });

  final String message;

  @override
  List<Object?> get props => [prompt, generateContentResponse, message];
}

final class CloseLoading extends GenerativeAIState {
  const CloseLoading({
    required super.generateContentResponse,
    required super.prompt,
    required super.isPromptLoading,
  });

  @override
  List<Object?> get props => [prompt, generateContentResponse];
}

final class PromptLoadedState extends GenerativeAIState {
  const PromptLoadedState({
    required super.generateContentResponse,
    required super.prompt,
    required super.isPromptLoading,
  });

  @override
  List<Object?> get props => [prompt, generateContentResponse];
}

final class promptFailure extends GenerativeAIState {
  const promptFailure({
    required this.failure,
    required super.generateContentResponse,
    required super.prompt,
    required super.isPromptLoading,
  });

  final Failure failure;

  @override
  List<Object?> get props => [failure, prompt, generateContentResponse];
}

final class NoInternetState extends GenerativeAIState {
  const NoInternetState({
    required super.generateContentResponse,
    required super.prompt,
    required super.isPromptLoading,
  });

  @override
  List<Object?> get props => [prompt, generateContentResponse];
}
