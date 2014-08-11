import 'dart:html';
import 'dart:math';
import 'package:polymer/polymer.dart';

@CustomTag('my-random')
class RandomTag extends PolymerElement
{
  @observable String number = '0';
  
  Random rand = new Random();
  HtmlElement click_element;
  
  RandomTag.created() : super.created();
  
  @override
  void attached()
  {
    super.attached();
    click_element = $['random_click'];
  }
  
  void random_click(Event e, var detail, Node target)
  {
    num new_num = rand.nextDouble();
    number = (new_num*1000).round().toString();
  }
}