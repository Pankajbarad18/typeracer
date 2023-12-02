import 'package:flutter/material.dart';
import 'package:typeracer/constants/colors.dart';
import 'package:typeracer/screens/create_room_screen.dart';
import 'package:typeracer/screens/join_room_screen.dart';
import 'package:typeracer/widgets/custom_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Create/Join the Room to play!',
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: appMainColor),
                  ),
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  CustomButton(
                      text: 'Create',
                      onTap: () => Navigator.pushNamed(
                          context, CreateRoomScreen.routeName)),
                  SizedBox(
                    height: size.height * 0.03,
                  ),
                  CustomButton(
                      text: 'Join',
                      onTap: () => Navigator.pushNamed(
                          context, JoinRoomScreen.routeName))
                ],
              )),
        ),
      ),
    );
  }
}
