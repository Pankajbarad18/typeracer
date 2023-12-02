class ClientTimer {
  final Map<String, dynamic> timer;

  ClientTimer({required this.timer});

  Map<String, dynamic> toJson() => {'timer': timer};
}
