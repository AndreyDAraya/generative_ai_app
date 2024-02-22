import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ai_generative/src/utils/utils.dart';
import 'package:ai_generative/src/generative_ai/domain/domain.dart';
import 'package:fpdart/fpdart.dart';

part 'event.dart';
part 'state.dart';

/// Bloc responsible for managing generative_ai-related events and states.
class GenerativeAIBloc extends Bloc<GenerativeAIEvent, GenerativeAIState>
    with ConnectionState {
  GenerativeAIBloc(this._repository)
      : super(
          const InitialState(
            prompt: '',
            generateContentResponse: '',
            isPromptLoading: false,
          ),
        ) {
    // Set up event listeners
    on<OnGenerativeAIText>(
      _onGenerativeAIText,
      transformer: restartable(),
    );
  }

  final GenerativeAIRepository _repository;

  FutureOr<void> _onGenerativeAIText(
    OnGenerativeAIText event,
    Emitter<GenerativeAIState> emit,
  ) async {
    /// Verify if has internet
    if (!await hasInternet()) {
      emit(
        NoInternetState(
          prompt: state.prompt,
          generateContentResponse: state.generateContentResponse,
          isPromptLoading: state.isPromptLoading,
        ),
      );
      return;
    }

    // Show loading widget
    emit(
      ShowLoading(
        generateContentResponse: '',
        prompt: state.prompt,
        isPromptLoading: state.isPromptLoading,
      ),
    );

    // Make request to get latitude and longitude by city name
    final eitherGenerativeAI =
        _repository.generateContentStream(prompt: event.prompt);

    await emit.onEach<Either<Failure, String>>(
      eitherGenerativeAI,
      onError: (e, st) {
        emit(
          promptFailure(
            failure: Failure(message: e.toString()),
            generateContentResponse: state.generateContentResponse,
            prompt: state.prompt,
            isPromptLoading: state.isPromptLoading,
          ),
        );
      },
      onData: (gAI) {
        gAI.fold(
          (failure) {
            emit(
              promptFailure(
                failure: failure,
                generateContentResponse: state.generateContentResponse,
                prompt: state.prompt,
                isPromptLoading: state.isPromptLoading,
              ),
            );
          },
          (res) {
            emit(
              PromptLoadedState(
                generateContentResponse: [state.generateContentResponse, res]
                    .fold('', (pv, newtext) => pv + newtext),
                prompt: event.prompt,
                isPromptLoading: true,
              ),
            );
          },
        );
      },
    );

    emit(
      IsLoadingprompt(
        generateContentResponse: state.generateContentResponse,
        prompt: state.prompt,
        isPromptLoading: false,
      ),
    );
  }
}
