import 'package:flutter/material.dart';
import 'package:typeracer/constants/colors.dart';
import 'package:typeracer/resources/socket_methods.dart';
import 'package:typeracer/widgets/custom_button.dart';
import 'package:typeracer/widgets/custom_text_field.dart';

class CreateRoomScreen extends StatefulWidget {
  static const String routeName = '/create-room-screen';
  const CreateRoomScreen({super.key});

  @override
  State<CreateRoomScreen> createState() => _CreateRoomScreenState();
}

class _CreateRoomScreenState extends State<CreateRoomScreen> {
  final _nameController = TextEditingController();
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
                    'Create Room',
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
                  CustomButton(
                    text: 'Create',
                    onTap: () =>
                        _socketMethods.createGame(_nameController.text),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
