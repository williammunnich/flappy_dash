import 'dart:ui';

import 'package:flappy_dash/bloc/game/game_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HighScoreManager {
  //set high score to local preference storage if current score exceeds past highscore
  static const _highScoreKey = 'highScore';

  // Save high score
  Future<void> setHighScore(int score) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_highScoreKey, score);
  }

  // Read high score
  Future<int?> getHighScore() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_highScoreKey) ?? 0; // Default to 0 if no high score
  }
}

class GameOverWidget extends StatelessWidget {
  const GameOverWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (context, state) {
        return FutureBuilder<int?>(
          future: HighScoreManager().getHighScore(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }

            int? highScore = snapshot.data;
            int currentScore = state.currentScore;

            // Update high score if current score is greater
            if (currentScore > highScore!) {
              HighScoreManager().setHighScore(currentScore);
              highScore = currentScore;
            }

            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Container(
                color: Colors.black54,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'GAME OVER!',
                        style: TextStyle(
                          color: Color(0xFFFFCA00),
                          fontWeight: FontWeight.bold,
                          fontSize: 48,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Score: $currentScore',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          letterSpacing: 2,
                        ),
                      ),
                      Text(
                        'High Score: $highScore',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          letterSpacing: 2,
                        ),
                      ),
                      const SizedBox(height: 60),
                      ElevatedButton(
                        onPressed: () => context.read<GameCubit>().restartGame(),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'PLAY AGAIN!',
                            style: TextStyle(
                              fontSize: 22,
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
