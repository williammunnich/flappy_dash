import 'package:flappy_dash/bloc/game/game_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopScore extends StatelessWidget {
  const TopScore({super.key});

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: BlocBuilder<GameCubit, GameState>(
        builder: (context, state) {
          return Text(
            state.currentScore.toString(),
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 38,
              letterSpacing: 4,
            ),
          );
        },
      ),
    );
  }
}
