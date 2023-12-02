import 'package:flutter/material.dart';
import 'package:typeracer/models/game_state_model.dart';

class GameStateProvider extends ChangeNotifier {
  GameState _gameState = GameState(
    id: '',
    players: [],
    isJoin: true,
    isOver: false,
    words: [],
  );

  Map<String, dynamic> get gameState => _gameState.toJson();

  updateGameState(
      {required id,
      required players,
      required isJoin,
      required isOver,
      required words}) {
    _gameState = GameState(
      id: id,
      players: players,
      isJoin: isJoin,
      isOver: isOver,
      words: words,
    );
    notifyListeners();
  }
}
