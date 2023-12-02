import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:typeracer/provider/client_timer_provider.dart';
import 'package:typeracer/provider/game_state_provider.dart';
import 'package:typeracer/screens/create_room_screen.dart';
import 'package:typeracer/screens/game_screen.dart';
import 'package:typeracer/screens/home_screen.dart';
import 'package:typeracer/screens/join_room_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => GameStateProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ClientTimerProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Typeracer',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        routes: {
          CreateRoomScreen.routeName: (context) => const CreateRoomScreen(),
          JoinRoomScreen.routeName: (context) => const JoinRoomScreen(),
          GameScreen.routeName: (context) => const GameScreen(),
        },
        home: const HomeScreen(),
      ),
    );
  }
}
