import 'dart:ui';

abstract class Selectable{
  bool selected = false;
  bool contains(Offset p);
}