part of 'bloc.dart';

sealed class GenerativeAIState extends Equatable {
  const GenerativeAIState({
    required this.generateContentResponse,
    required this.prompt,
    required this.isPromtpLoading,
  });

  final String generateContentResponse;
  final String prompt;
  final bool isPromtpLoading;

  @override
  List<Object?> get props => [prompt, generateContentResponse, isPromtpLoading];
}

final class InitialState extends GenerativeAIState {
  const InitialState({
    required super.generateContentResponse,
    required super.prompt,
    required super.isPromtpLoading,
  });

  @override
  List<Object?> get props => [prompt, generateContentResponse];
}

final class ShowLoading extends GenerativeAIState {
  const ShowLoading({
    required super.generateContentResponse,
    this.message = '',
    required super.prompt,
    required super.isPromtpLoading,
  });

  final String message;

  @override
  List<Object?> get props => [prompt, generateContentResponse, message];
}

final class IsLoadingPromtp extends GenerativeAIState {
  const IsLoadingPromtp({
    required super.generateContentResponse,
    this.message = '',
    required super.prompt,
    required super.isPromtpLoading,
  });

  final String message;

  @override
  List<Object?> get props => [prompt, generateContentResponse, message];
}

final class CloseLoading extends GenerativeAIState {
  const CloseLoading({
    required super.generateContentResponse,
    required super.prompt,
    required super.isPromtpLoading,
  });

  @override
  List<Object?> get props => [prompt, generateContentResponse];
}

final class PromptLoadedState extends GenerativeAIState {
  const PromptLoadedState({
    required super.generateContentResponse,
    required super.prompt,
    required super.isPromtpLoading,
  });

  @override
  List<Object?> get props => [prompt, generateContentResponse];
}

final class PromtpFailure extends GenerativeAIState {
  const PromtpFailure({
    required this.failure,
    required super.generateContentResponse,
    required super.prompt,
    required super.isPromtpLoading,
  });

  final Failure failure;

  @override
  List<Object?> get props => [failure, prompt, generateContentResponse];
}

final class NoInternetState extends GenerativeAIState {
  const NoInternetState({
    required super.generateContentResponse,
    required super.prompt,
    required super.isPromtpLoading,
  });

  @override
  List<Object?> get props => [prompt, generateContentResponse];
}
