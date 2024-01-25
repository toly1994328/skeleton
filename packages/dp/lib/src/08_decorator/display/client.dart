import 'border.dart';

import 'display.dart';

void main(){
  Display display = StringDisplay('hello dart');
  // display.show();

  Display display2 = SideBorder("|", display);
  // display2.show();

  Display display3 = FullBorder( display);
  // display3.show();

  Display display4 = FullBorder(display3);
  // display4.show();

  Display display5 = SideBorder('*',FullBorder( display4));
  display5.show();
}