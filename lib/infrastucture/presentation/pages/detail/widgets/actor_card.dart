import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_final_test/domain/actor/actor.dart';

class ActorCard extends StatelessWidget {
  final Actor actor;
  const ActorCard({super.key, required this.actor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: Container(
          height: 160,
          color: Colors.grey,
          child: Stack(
            children: [
              actor.id == 0
                  ? Image.asset(
                      'images/c2.jpg',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    )
                  : ShaderMask(
                      shaderCallback: (bounds) => LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7)
                        ],
                      ).createShader(bounds),
                      blendMode: BlendMode.darken,
                      child: Image.network(
                        dotenv.env["API_IMAGE"]! + actor.profile_path,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent? loadingProgress) {
                          if (loadingProgress == null) {
                            return child;
                          } else {
                            return Container(
                              color: Colors.grey,
                              child: Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          (loadingProgress.expectedTotalBytes ??
                                              1)
                                      : null,
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ),
              Positioned(
                bottom: 10,
                left: 10,
                child: SizedBox(
                  width: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          actor.original_name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          actor.character,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
