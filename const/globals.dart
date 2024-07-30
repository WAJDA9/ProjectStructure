import 'package:physio_app/models/player.dart';
import 'package:physio_app/services/data_provider.dart';

List<Player> players = [
  Player(
    name: "Abdallah",
    surname: "Zayen",
    position: "Goalkeeper",
    association: "Al-HIlal FC",
    injuries: MockDataProvider().fetchInjuries(),
  ),
  Player(
    name: "Ahmed",
    surname: "Boughanem",
    position: "Midfielder",
    association: "Al-HIlal FC",
    injuries: MockDataProvider().fetchInjuries(),
  ),
  Player(
    name: "Ali",
    surname: "Al-Nemer",
    position: "Defender",
    association: "Al-HIlal FC",
    injuries: MockDataProvider().fetchInjuries(),
  ),
];
