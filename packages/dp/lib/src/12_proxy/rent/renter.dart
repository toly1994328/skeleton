import 'rentable.dart';

void main(){
  Host host =  Host();
  RentProxy proxy = RentProxy(host);

  proxy.rent();
}