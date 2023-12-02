import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:typeracer/constants/colors.dart';
import 'package:typeracer/provider/client_timer_provider.dart';
import 'package:typeracer/provider/game_state_provider.dart';
import 'package:typeracer/resources/socket_methods.dart';
import 'package:typeracer/widgets/game_textfield.dart';
import 'package:typeracer/widgets/sentence.dart';
import 'package:typeracer/widgets/snackbar.dart';

class GameScreen extends StatefulWidget {
  static const routeName = '/game-screen';
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethods _socketMethods = SocketMethods();
  @override
  void initState() {
    super.initState();
    _socketMethods.updateTimer(context);
    _socketMethods.updateGame(context);
    _socketMethods.gameFinishedListener();
  }

  @override
  Widget build(BuildContext context) {
    final game = Provider.of<GameStateProvider>(context);
    final clientTimerProvider = Provider.of<ClientTimerProvider>(context);
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SingleChildScrollView(
              child: Expanded(
                child: Column(
                  children: [
                    Chip(
                      label: Text(
                        clientTimerProvider.clientTimer['timer']['msg']
                            .toString(),
                        style: const TextStyle(fontSize: 20),
                      ),
                    ),
                    Text(
                      clientTimerProvider.clientTimer['timer']['countDown']
                          .toString(),
                      style: const TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    game.gameState['isJoin']
                        ? ConstrainedBox(
                            constraints: const BoxConstraints(maxWidth: 600),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 20),
                              child: TextField(
                                readOnly: true,
                                onTap: () {
                                  Clipboard.setData(ClipboardData(
                                          text: game.gameState['id']))
                                      .then((value) {
                                    customSnackbar(
                                        context, 'Copied into Clipboard');
                                  });
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: const BorderSide(
                                            color: Colors.grey)),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide:
                                          const BorderSide(color: Colors.grey),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide:
                                          BorderSide(color: appMainColor),
                                    ),
                                    hintText: 'Click to Copy GameID',
                                    hintStyle: const TextStyle(
                                        fontSize: 18, color: Colors.grey),
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 5)),
                              ),
                            ),
                          )
                        : Container(),
                    const ShowSentence(),
                    ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 600),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: game.gameState['players'].length,
                              itemBuilder: (context, index) {
                                final playerData =
                                    game.gameState['players'][index];
                                return Column(
                                  children: [
                                    Text(playerData['nickname']),
                                    Slider(
                                        value: playerData['currentWordIndex'] /
                                            game.gameState['words'].length,
                                        onChanged: (val) {})
                                  ],
                                );
                              })),
                    ),
                  ],
                ),
              ),
            ),
            Container(
                height: 50,
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                ).copyWith(bottom: 10),
                child: const GameTextField()),
          ],
        ),
      )),
    );
  }
}
