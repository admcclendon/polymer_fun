library elements.chat_window;

import 'dart:html';
import 'package:polymer/polymer.dart';

@CustomTag('chat-window')
class ChatWindow extends DivElement with Polymer, Observable
{
  @observable Map data = {'message': ''};
  
  HtmlElement content;
  
  ChatWindow.created() : super.created()
  {
    polymerCreated();
  }
  
  @override
  void attached()
  {
    super.attached();
    content = $['contentarea'];
  }
  
  void send_button_click(Event e, var detail, Node target)
  {
    e.preventDefault();
    
    SendMessage();
  }
  
  void SendMessage()
  {
    this.fire("message", detail: data['message']);
  }
  
  void PrintMessage(String msg)
  {
    content.appendHtml("<p>$msg</p>");
  }
}