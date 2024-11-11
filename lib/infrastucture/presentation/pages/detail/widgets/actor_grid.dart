import 'package:flutter/material.dart';
import 'package:flutter_final_test/domain/actor/actor.dart';
import 'package:flutter_final_test/infrastucture/presentation/pages/detail/widgets/actor_card.dart';

class ActorGrid extends StatelessWidget {
  final List<Actor> actors;
  const ActorGrid({super.key, required this.actors});

  @override
  Widget build(BuildContext context) {
    return actors.isNotEmpty
        ? Row(
            children: [
              Expanded(
                child: ActorCard(actor: actors[0]),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ActorCard(actor: actors[1]),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ActorCard(actor: actors[2]),
              ),
            ],
          )
        : Container();
  }
}
