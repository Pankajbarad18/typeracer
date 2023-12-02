import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:typeracer/provider/client_timer_provider.dart';
import 'package:typeracer/provider/game_state_provider.dart';
import 'package:typeracer/resources/socket_client.dart';
import 'package:typeracer/screens/game_screen.dart';
import 'package:typeracer/widgets/snackbar.dart';

class SocketMethods {
  final Socket _socketClient = SocketClient.instance.socket!;
  bool _isPlaying = false;

  //create
  createGame(String nickname) {
    if (nickname.isNotEmpty) {
      _socketClient.emit(
        'create-game',
        {'nickname': nickname},
      );
    }
  }

  //join-game
  joinGame(String nickname, String gameId) {
    if (nickname.isNotEmpty && gameId.isNotEmpty) {
      _socketClient.emit(
        'join-game',
        {
          'nickname': nickname,
          'gameId': gameId,
        },
      );
    }
  }

  //start timer
  startTimer(String playerId, String gameID) {
    _socketClient.emit('timer', {
      'playerId': playerId,
      'gameID': gameID,
    });
  }

  //take user Input
  sendUserInput(String val, String gameID) {
    _socketClient.emit('userInput', {
      'userInput': val,
      'gameID': gameID,
    });
  }

  updateGameListener(BuildContext context) {
    _socketClient.on('updateGame', (data) {
      try {
        final gameStateProvider =
            Provider.of<GameStateProvider>(context, listen: false);
        gameStateProvider.updateGameState(
          id: data['_id'],
          players: data['players'],
          isJoin: data['isJoin'],
          words: data['words'],
          isOver: data['isOver'],
        );

        if (data['_id'].isNotEmpty && !_isPlaying) {
          Navigator.pushNamed(context, GameScreen.routeName);
          _isPlaying = true;
        }
      } catch (e) {
        customSnackbar(context, e.toString());
      }
    });
  }

  notCorrectGame(BuildContext context) {
    _socketClient.on('notCorrectGame', (data) {
      customSnackbar(context, data);
    });
  }

  updateTimer(BuildContext context) {
    final clientTimerProvider =
        Provider.of<ClientTimerProvider>(context, listen: false);
    _socketClient.on('timer', (data) {
      clientTimerProvider.setClientTimer(data);
    });
  }

  updateGame(BuildContext context) {
    _socketClient.on('updateGame', (data) {
      try {
        final gameStateProvider =
            Provider.of<GameStateProvider>(context, listen: false);
        gameStateProvider.updateGameState(
          id: data['_id'],
          players: data['players'],
          isJoin: data['isJoin'],
          words: data['words'],
          isOver: data['isOver'],
        );
      } catch (e) {
        customSnackbar(context, e.toString());
      }
    });
  }

  gameFinishedListener() {
    _socketClient.on(
      'done',
      (data) => _socketClient.off('timer'),
    );
  }
}
