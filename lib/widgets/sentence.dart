// ignore_for_file: avoid_init_to_null

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typeracer/provider/game_state_provider.dart';
import 'package:typeracer/resources/socket_client.dart';
import 'package:typeracer/resources/socket_methods.dart';
import 'package:typeracer/widgets/score_board.dart';

class ShowSentence extends StatefulWidget {
  const ShowSentence({super.key});

  @override
  State<ShowSentence> createState() => _ShowSentenceState();
}

class _ShowSentenceState extends State<ShowSentence> {
  var playerMe = null;
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.updateGame(context);
  }

  findPlayerMe(GameStateProvider game) {
    game.gameState['players'].forEach((player) {
      if (player['socketID'] == SocketClient.instance.socket!.id) {
        playerMe = player;
      }
    });
  }

  Widget typedWords(words, player) {
    var typewords = words.sublist(0, player['currentWordIndex']);
    String typedwords = typewords.join(' ');
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        typedwords,
        style: const TextStyle(
          color: Colors.green,
          fontSize: 24,
        ),
      ),
    );
  }

  Widget currentWord(words, player) {
    return Padding(
      padding: const EdgeInsets.only(left: 4.0),
      child: Text(
        words[player['currentWordIndex']],
        style: const TextStyle(
            decoration: TextDecoration.underline,
            fontSize: 26,
            fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget remainingWords(words, player) {
    var typewords = words.sublist(player['currentWordIndex'] + 1, words.length);
    String typedwords = typewords.join(' ');
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        typedwords,
        style: const TextStyle(
          fontSize: 24,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<GameStateProvider>(context);
    findPlayerMe(game);
    if (game.gameState['words'].length > playerMe['currentWordIndex']) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Wrap(
          children: [
            //typed words
            typedWords(game.gameState['words'], playerMe),
            //current word
            currentWord(game.gameState['words'], playerMe),
            //remaining sentance
            remainingWords(game.gameState['words'], playerMe),
          ],
        ),
      );
    }
    return const ScoreBoard();
  }
}
