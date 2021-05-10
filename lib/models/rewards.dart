import 'package:equatable/equatable.dart';

class Reward extends Equatable {
  final String name;
  final String description;

  Reward(this.name, this.description);

  @override
  List<Object> get props => [name, description];

  @override
  String toString() {
    return 'Reward { name: $name , desc: $description }';
  }
}
