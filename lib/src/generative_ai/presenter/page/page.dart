import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ai_generative/src/shared/shared.dart';
import 'package:ai_generative/src/generative_ai/presenter/bloc/bloc.dart';

import 'package:markdown_widget/markdown_widget.dart';

part '_widget/search.dart';

class GenerativeAIPage extends StatelessWidget {
  const GenerativeAIPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => Modular.get<GenerativeAIBloc>(),
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GenerativeAIBloc, GenerativeAIState>(
      listener: (context, state) {
        if (state is NoInternetState) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              'There is no internet connection at the moment. Please try again later.',
            ),
          ));
        }
      },
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          title: Text(
            'Generative AI',
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
        body: _Body(),
      ),
    );
  }
}

class _Body extends StatefulWidget {
  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GenerativeAIBloc, GenerativeAIState>(
      listenWhen: (previous, current) => current is PromptLoadedState,
      listener: (context, state) {
        if (state is PromptLoadedState) {
          if (_scrollController.hasClients) {
            WidgetsBinding.instance.addPostFrameCallback(
              (_) => _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: const Duration(
                  milliseconds: 1000,
                ),
                curve: Curves.easeOutCirc,
              ),
            );
          }
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(DsSpace.lg).copyWith(bottom: 0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      state.prompt,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    DsVerticalSpace.sm,
                    AIGeneratorTextWidget(
                      scrollController: _scrollController,
                      generateContentResponse: state.generateContentResponse,
                    ),
                    DsVerticalSpace.md,
                    if (state is ShowLoading || state.isPromptLoading) ...[
                      const _LoadingWidget(),
                      DsVerticalSpace.md,
                    ],
                  ],
                ),
              ),
              BoxSearch(),
              DsVerticalSpace.xxl,
            ],
          ),
        );
      },
    );
  }
}

class AIGeneratorTextWidget extends StatelessWidget {
  const AIGeneratorTextWidget({
    super.key,
    required ScrollController scrollController,
    required this.generateContentResponse,
  }) : _scrollController = scrollController;

  final ScrollController _scrollController;
  final String generateContentResponse;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: MarkdownGenerator().buildWidgets(
            generateContentResponse,
          ),
        ),
      ),
    );
  }
}

class _LoadingWidget extends StatelessWidget {
  const _LoadingWidget();

  @override
  Widget build(BuildContext context) {
    return const Align(
      alignment: Alignment.center,
      child: SizedBox(
        height: 20,
        width: 20,
        child: CircularProgressIndicator.adaptive(),
      ),
    );
  }
}
