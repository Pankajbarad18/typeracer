import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typeracer/provider/game_state_provider.dart';

class ScoreBoard extends StatelessWidget {
  const ScoreBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<GameStateProvider>(context);
    return ListView.builder(
        shrinkWrap: true,
        itemCount: game.gameState['players'].length,
        itemBuilder: (context, index) {
          final playerData = game.gameState['players'][index];
          return ListTile(
            title: Text(playerData['nickname']),
            trailing: Text(playerData['WPM'].toString()),
          );
        });
  }
}
