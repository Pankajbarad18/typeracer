// ignore_for_file: avoid_init_to_null

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typeracer/constants/colors.dart';
import 'package:typeracer/provider/game_state_provider.dart';
import 'package:typeracer/resources/socket_client.dart';
import 'package:typeracer/resources/socket_methods.dart';
import 'package:typeracer/widgets/custom_button.dart';

class GameTextField extends StatefulWidget {
  const GameTextField({super.key});

  @override
  State<GameTextField> createState() => _GameTextFieldState();
}

class _GameTextFieldState extends State<GameTextField> {
  final SocketMethods _socketMethods = SocketMethods();
  late GameStateProvider? game;
  final _wordsController = TextEditingController();
  bool isBtn = true;
  var playerMe = null;
  @override
  void initState() {
    super.initState();
    game = Provider.of<GameStateProvider>(context, listen: false);
    findPlayerMe(game!);
  }

  findPlayerMe(GameStateProvider game) {
    game.gameState['players'].forEach((player) {
      if (player['socketID'] == SocketClient.instance.socket!.id) {
        playerMe = player;
      }
    });
  }

  handleStart(GameStateProvider game) {
    _socketMethods.startTimer(playerMe['_id'], game.gameState['id']);
    setState(() {
      isBtn = false;
    });
  }

  handleTextChange(String value, String gameID) {
    var lastChar = value[value.length - 1];

    if (lastChar == " ") {
      _socketMethods.sendUserInput(value, gameID);
      setState(() {
        _wordsController.text = "";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    GameStateProvider gameData = Provider.of<GameStateProvider>(context);
    return playerMe['isPartyLeader'] && isBtn
        ? CustomButton(text: 'S T A R T', onTap: () => handleStart(gameData))
        : TextFormField(
            readOnly: gameData.gameState['isJoin'],
            controller: _wordsController,
            onChanged: (val) => handleTextChange(val, gameData.gameState['id']),
            decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: Colors.grey)),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: appMainColor),
                ),
                hintText: 'Type Here',
                hintStyle: const TextStyle(fontSize: 18, color: Colors.grey),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5)),
          );
  }
}
