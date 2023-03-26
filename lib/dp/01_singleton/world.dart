class World {
  World._();

  World? world;

  static World instance = World._();
}

// 懒加载
// 即，只在第一参使用 instance 时，才会实例化对象
class World2 {
  World2._();

  static World2? world;

  static World2 get instance {
    world = world ?? World2._();
    return world!;
  }
}

main() {
  World world1 = World.instance;
  World world2 = World.instance;
  print(world1 == world2);

  World2 world21 = World2.instance;
  World2 world22 = World2.instance;
  print(world21 == world22);
}
