import 'digital.dart';

class DigitalFactory {
  final Map<num, Digital> _pool = {};

  DigitalFactory._();

  static DigitalFactory instance = DigitalFactory._();

  Digital getDigital(int num) {
    Digital? digital = _pool[num];
    if(digital==null){
      digital = Digital(num);
      _pool[num] = digital;
    }
    return digital;
  }
}
