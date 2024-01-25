import 'digital.dart';
import 'factory.dart';

void main() {
  int value = 199432;
  String bin = value.toRadixString(2);
  print(bin);

  for (int i = 0; i < bin.length; i++) {
    int v = int.parse(bin[i]);
    Digital digital = DigitalFactory.instance.getDigital(v);
    digital.show();
  }
}
