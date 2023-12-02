import 'package:flutter/material.dart';
import 'package:typeracer/constants/colors.dart';
import 'package:typeracer/resources/socket_methods.dart';
import 'package:typeracer/widgets/custom_button.dart';
import 'package:typeracer/widgets/custom_text_field.dart';

class JoinRoomScreen extends StatefulWidget {
  static const String routeName = '/join-room-screen';
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final _nameController = TextEditingController();
  final _gameIdController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.updateGameListener(context);
    _socketMethods.notCorrectGame(context);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _gameIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Join Room',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: appMainColor),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  CustomTextField(
                      controller: _nameController,
                      hintText: 'Enter Your nickname'),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextField(
                      controller: _gameIdController, hintText: 'Enter GameId'),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomButton(
                      text: 'Join',
                      onTap: () => _socketMethods.joinGame(
                          _nameController.text, _gameIdController.text))
                ],
              ),
            )),
      ),
    );
  }
}
