import 'problem.dart';
import 'handler.dart';

void main(){
  Handler ali = NoHandler("ali");
  Handler bobo = NoAssetsHandler("bobo");
  Handler card = InnerErrorHandler("card");
  Handler dodo = InnerErrorHandler("dodo");

  ali.setNext(bobo).setNext(card).setNext(dodo);

  ali.handle(Problem(500));
  ali.handle(Problem(400));
  ali.handle(Problem(404));

}