import 'package:flame/collisions.dart';
import 'package:flame/components.dart';

class Floor extends PositionComponent {
  Floor() : super(
    size: Vector2(600, 5),  // Hardcoded size: 600 width, 5 height
    position: Vector2(
        (600 / 2),  // Center horizontally based on width
        1000 - 5  // Position it at the bottom, accounting for its height
    ),
    anchor: Anchor.topCenter,  // Anchor the floor at the top center
  );

  @override
  void onLoad() {
    super.onLoad();
    add(RectangleHitbox(
      collisionType: CollisionType.passive,  // Floor should be a solid object
    ));
  }
}
