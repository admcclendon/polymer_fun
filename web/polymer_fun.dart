import 'dart:html';
import 'dart:convert';
import 'package:polymer/polymer.dart';
import 'elements/chat_window.dart';
import 'elements/form_register.dart';

Client c;
ChatWindow cw;

void main() {
  initPolymer();
  c = new Client();
  
  FormRegister f = querySelector("#register_form");
  cw = querySelector("#window_chat");
  f.on["login"].listen((CustomEvent e) {
    c.Login(e.detail);
  });
  cw.on["message"].listen((CustomEvent e) {
    c.SendMessage(e.detail);
  });
}

void onLoginEvent(Event e, dynamic detail)
{
  
}

class Client
{
  WebSocket ws;
  String username;
  
  Client()
  {
    connect();
  }
  
  void connect()
  {
    ws = new WebSocket('ws://localhost:9223/ws');
    ws..onOpen.first.then((_) { onConnected(); })
      ..onClose.first.then((_) { onDisconnected(); })
      ..onError.first.then((_) { });
  }
  
  void onConnected()
  {
    ws.onMessage.listen((e) { handleMessage(e.data); });
  }
  
  void onDisconnected()
  {
    try
    {
      // try to close then reopen the socket.
      ws.close();
    }
    catch(e) { } // Do anything??
    finally
    {
      connect();
    }
  }
  
  void Login(String username)
  {
    ws.send(JSON.encode({'action': 'login', 'username': username}));
  }
  
  void SendMessage(String message)
  {
    ws.send(JSON.encode({'action': 'message', 'message': message}));
  }
  
  void handleMessage(String data)
  {
    var json = JSON.decode(data);
    var action = json['action'];
    switch (action)
    {
      case 'notify':
        cw.PrintMessage(json['message']);
        break;
      case 'message':
        cw.PrintMessage(new DateTime.now().toString() + " " + json['from'] + ": " + json['message']);
        break;
      case 'login':
        if (json['result'])
        {
          username = json['username'];
        }
        break;
    }
  }
}